//
//  TextDetectionService.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import Foundation
import Vision
import CoreImage
import UIKit

class TextDetectionService {
    
    // MARK: - Properties
    private var textRecognitionRequest: VNRecognizeTextRequest?
    private let recognitionLevel: VNRequestTextRecognitionLevel = .accurate
    
    // MARK: - Initialization
    init() {
        setupTextRecognition()
    }
    
    // MARK: - Setup
    private func setupTextRecognition() {
        textRecognitionRequest = VNRecognizeTextRequest()
        textRecognitionRequest?.recognitionLevel = recognitionLevel
        textRecognitionRequest?.usesLanguageCorrection = true
        
        // Supported languages for better accuracy
        textRecognitionRequest?.recognitionLanguages = [
            "en-US", "es-ES", "fr-FR", "de-DE", "it-IT",
            "pt-BR", "zh-Hans", "zh-Hant", "ja-JP", "ko-KR"
        ]
    }
    
    // MARK: - Text Detection
    func detectText(in image: CIImage, completion: @escaping ([DetectedText]) -> Void) {
        guard let request = textRecognitionRequest else {
            completion([])
            return
        }
        
        let imageSize = image.extent.size
        
        // Create request handler
        let requestHandler = VNImageRequestHandler(ciImage: image, options: [:])
        
        // Perform request asynchronously
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
                
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    DispatchQueue.main.async {
                        completion([])
                    }
                    return
                }
                
                // Convert observations to DetectedText
                let detectedTexts = observations.compactMap { observation in
                    DetectedText.from(observation: observation, in: imageSize)
                }
                
                DispatchQueue.main.async {
                    completion(detectedTexts)
                }
                
            } catch {
                print("Text detection error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    // MARK: - Optimized Detection for Real-time
    func detectTextRealtime(in image: CIImage, completion: @escaping ([DetectedText]) -> Void) {
        // Use fast recognition for real-time
        let fastRequest = VNRecognizeTextRequest()
        fastRequest.recognitionLevel = .fast
        fastRequest.usesLanguageCorrection = false
        
        let imageSize = image.extent.size
        let requestHandler = VNImageRequestHandler(ciImage: image, options: [:])
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([fastRequest])
                
                guard let observations = fastRequest.results as? [VNRecognizedTextObservation] else {
                    DispatchQueue.main.async {
                        completion([])
                    }
                    return
                }
                
                // Filter by confidence threshold
                let detectedTexts = observations.compactMap { observation -> DetectedText? in
                    guard observation.confidence > 0.5 else { return nil }
                    return DetectedText.from(observation: observation, in: imageSize)
                }
                
                DispatchQueue.main.async {
                    completion(detectedTexts)
                }
                
            } catch {
                print("Real-time text detection error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    // MARK: - Language Detection
    func detectLanguage(in text: String) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        
        guard let languageCode = recognizer.dominantLanguage?.rawValue else {
            return nil
        }
        
        return languageCode
    }
}
