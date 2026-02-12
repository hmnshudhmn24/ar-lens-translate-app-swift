//
//  DetectedText.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import Foundation
import CoreGraphics
import Vision

struct DetectedText: Identifiable {
    let id: UUID
    let text: String
    let boundingBox: CGRect
    let confidence: Float
    var translation: String?
    var isTranslating: Bool = false
    
    init(id: UUID = UUID(), text: String, boundingBox: CGRect, confidence: Float, translation: String? = nil) {
        self.id = id
        self.text = text
        self.boundingBox = boundingBox
        self.confidence = confidence
        self.translation = translation
    }
    
    // Create from Vision recognition result
    static func from(observation: VNRecognizedTextObservation, in imageSize: CGSize) -> DetectedText? {
        guard let candidate = observation.topCandidates(1).first else {
            return nil
        }
        
        let text = candidate.string
        let boundingBox = observation.boundingBox
        let confidence = observation.confidence
        
        // Convert normalized coordinates to image coordinates
        let rect = VNImageRectForNormalizedRect(
            boundingBox,
            Int(imageSize.width),
            Int(imageSize.height)
        )
        
        return DetectedText(
            text: text,
            boundingBox: rect,
            confidence: confidence
        )
    }
}

// MARK: - Hashable & Equatable
extension DetectedText: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: DetectedText, rhs: DetectedText) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Translation Result
struct TranslationResult {
    let originalText: String
    let translatedText: String
    let sourceLanguage: String
    let targetLanguage: String
    let confidence: Double?
    
    init(originalText: String, translatedText: String, sourceLanguage: String, targetLanguage: String, confidence: Double? = nil) {
        self.originalText = originalText
        self.translatedText = translatedText
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
        self.confidence = confidence
    }
}
