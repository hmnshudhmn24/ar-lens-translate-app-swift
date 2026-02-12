//
//  CameraViewModel.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import Foundation
import SwiftUI
import Combine
import AVFoundation

@MainActor
class CameraViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var detectedTexts: [DetectedText] = []
    @Published var isProcessing = false
    @Published var errorMessage: String?
    @Published var capturedImage: UIImage?
    
    // MARK: - Services
    let cameraService = CameraService()
    private let textDetectionService = TextDetectionService()
    private let translationService = TranslationService()
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var processingTimer: Timer?
    private let processingInterval: TimeInterval = 0.5 // Process frames every 0.5 seconds
    
    // MARK: - Settings
    var sourceLanguage: Language = .auto
    var targetLanguage: Language = .spanish
    var isOfflineMode: Bool = false {
        didSet {
            translationService.setOfflineMode(isOfflineMode)
        }
    }
    
    // MARK: - Initialization
    init() {
        setupBindings()
    }
    
    // MARK: - Setup
    private func setupBindings() {
        // Observe camera frames
        cameraService.$currentFrame
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                // Frame updated, will be processed by timer
            }
            .store(in: &cancellables)
        
        // Observe captured images
        cameraService.$capturedImage
            .receive(on: DispatchQueue.main)
            .assign(to: &$capturedImage)
    }
    
    // MARK: - Camera Control
    func startCamera() async {
        await cameraService.setupSession()
        
        if cameraService.isAuthorized {
            cameraService.startSession()
            startProcessing()
        } else {
            errorMessage = "Camera access denied. Please enable camera access in Settings."
        }
    }
    
    func stopCamera() {
        cameraService.stopSession()
        stopProcessing()
    }
    
    // MARK: - Processing Control
    private func startProcessing() {
        processingTimer = Timer.scheduledTimer(withTimeInterval: processingInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                await self?.processCurrentFrame()
            }
        }
    }
    
    private func stopProcessing() {
        processingTimer?.invalidate()
        processingTimer = nil
    }
    
    // MARK: - Frame Processing
    private func processCurrentFrame() async {
        guard !isProcessing, let frame = cameraService.currentFrame else { return }
        
        isProcessing = true
        
        // Detect text
        await detectText(in: frame)
        
        isProcessing = false
    }
    
    private func detectText(in image: CIImage) async {
        await withCheckedContinuation { continuation in
            textDetectionService.detectTextRealtime(in: image) { [weak self] detectedTexts in
                Task { @MainActor in
                    guard let self = self else {
                        continuation.resume()
                        return
                    }
                    
                    // Update detected texts
                    self.detectedTexts = detectedTexts
                    
                    // Translate detected texts
                    await self.translateDetectedTexts()
                    
                    continuation.resume()
                }
            }
        }
    }
    
    // MARK: - Translation
    private func translateDetectedTexts() async {
        let textsToTranslate = detectedTexts.filter { $0.translation == nil && !$0.isTranslating }
        
        for (index, detectedText) in detectedTexts.enumerated() {
            guard textsToTranslate.contains(where: { $0.id == detectedText.id }) else { continue }
            
            // Mark as translating
            detectedTexts[index].isTranslating = true
            
            do {
                let translation = try await translationService.translate(
                    detectedText.text,
                    from: sourceLanguage.code,
                    to: targetLanguage.code
                )
                
                detectedTexts[index].translation = translation
                detectedTexts[index].isTranslating = false
                
            } catch {
                print("Translation error: \(error.localizedDescription)")
                detectedTexts[index].isTranslating = false
            }
        }
    }
    
    // MARK: - Photo Capture
    func capturePhoto() {
        cameraService.capturePhoto()
        
        // Provide haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    // MARK: - Cleanup
    func cleanup() {
        stopCamera()
        detectedTexts.removeAll()
        translationService.clearCache()
    }
}
