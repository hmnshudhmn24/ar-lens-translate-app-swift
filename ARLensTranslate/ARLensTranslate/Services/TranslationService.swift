//
//  TranslationService.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import Foundation

class TranslationService {
    
    // MARK: - Properties
    private let cache = NSCache<NSString, NSString>()
    private var isOfflineMode: Bool = false
    
    // MARK: - Translation Methods
    
    /// Translate text to target language
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String) async throws -> String {
        // Check cache first
        let cacheKey = "\(sourceLanguage)-\(targetLanguage)-\(text)" as NSString
        if let cachedTranslation = cache.object(forKey: cacheKey) {
            return cachedTranslation as String
        }
        
        let translation: String
        
        if isOfflineMode {
            translation = try await translateOffline(text, from: sourceLanguage, to: targetLanguage)
        } else {
            translation = try await translateOnline(text, from: sourceLanguage, to: targetLanguage)
        }
        
        // Cache the result
        cache.setObject(translation as NSString, forKey: cacheKey)
        
        return translation
    }
    
    // MARK: - Online Translation
    private func translateOnline(_ text: String, from sourceLanguage: String, to targetLanguage: String) async throws -> String {
        // This is a mock implementation
        // In production, you would integrate with a translation API like:
        // - Google Cloud Translation API
        // - Microsoft Translator API
        // - DeepL API
        // - LibreTranslate (free/open-source option)
        
        // For demo purposes, simulate API call with delay
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds
        
        // Mock translation (in real app, this would be actual API call)
        return mockTranslate(text, to: targetLanguage)
    }
    
    // MARK: - Offline Translation
    private func translateOffline(_ text: String, from sourceLanguage: String, to targetLanguage: String) async throws -> String {
        // This is a simplified offline translation
        // In production, you would use Core ML models for translation
        // You can train custom models or use pre-trained translation models
        
        // For demo, we'll use a simple dictionary approach
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        return mockTranslate(text, to: targetLanguage)
    }
    
    // MARK: - Mock Translation (for demo purposes)
    private func mockTranslate(_ text: String, to targetLanguage: String) -> String {
        // Simple mock translations for common phrases
        let commonTranslations: [String: [String: String]] = [
            "Hello": [
                "es": "Hola",
                "fr": "Bonjour",
                "de": "Hallo",
                "it": "Ciao",
                "ja": "こんにちは",
                "zh": "你好",
                "ko": "안녕하세요",
                "ar": "مرحبا",
                "ru": "Привет"
            ],
            "Welcome": [
                "es": "Bienvenido",
                "fr": "Bienvenue",
                "de": "Willkommen",
                "it": "Benvenuto",
                "ja": "ようこそ",
                "zh": "欢迎",
                "ko": "환영합니다"
            ],
            "Thank you": [
                "es": "Gracias",
                "fr": "Merci",
                "de": "Danke",
                "it": "Grazie",
                "ja": "ありがとう",
                "zh": "谢谢",
                "ko": "감사합니다"
            ],
            "Goodbye": [
                "es": "Adiós",
                "fr": "Au revoir",
                "de": "Auf Wiedersehen",
                "it": "Arrivederci",
                "ja": "さようなら",
                "zh": "再见",
                "ko": "안녕히 가세요"
            ],
            "Yes": [
                "es": "Sí",
                "fr": "Oui",
                "de": "Ja",
                "it": "Sì",
                "ja": "はい",
                "zh": "是",
                "ko": "예"
            ],
            "No": [
                "es": "No",
                "fr": "Non",
                "de": "Nein",
                "it": "No",
                "ja": "いいえ",
                "zh": "不",
                "ko": "아니요"
            ],
            "Please": [
                "es": "Por favor",
                "fr": "S'il vous plaît",
                "de": "Bitte",
                "it": "Per favore",
                "ja": "お願いします",
                "zh": "请",
                "ko": "제발"
            ],
            "Exit": [
                "es": "Salida",
                "fr": "Sortie",
                "de": "Ausgang",
                "it": "Uscita",
                "ja": "出口",
                "zh": "出口",
                "ko": "출구"
            ],
            "Entrance": [
                "es": "Entrada",
                "fr": "Entrée",
                "de": "Eingang",
                "it": "Entrata",
                "ja": "入口",
                "zh": "入口",
                "ko": "입구"
            ],
            "Restaurant": [
                "es": "Restaurante",
                "fr": "Restaurant",
                "de": "Restaurant",
                "it": "Ristorante",
                "ja": "レストラン",
                "zh": "餐厅",
                "ko": "레스토랑"
            ],
            "Menu": [
                "es": "Menú",
                "fr": "Menu",
                "de": "Speisekarte",
                "it": "Menu",
                "ja": "メニュー",
                "zh": "菜单",
                "ko": "메뉴"
            ],
            "Water": [
                "es": "Agua",
                "fr": "Eau",
                "de": "Wasser",
                "it": "Acqua",
                "ja": "水",
                "zh": "水",
                "ko": "물"
            ]
        ]
        
        // Check if we have a translation
        if let translations = commonTranslations[text],
           let translation = translations[targetLanguage] {
            return translation
        }
        
        // For unknown text, add language indicator
        let languageNames: [String: String] = [
            "es": "Spanish",
            "fr": "French",
            "de": "German",
            "it": "Italian",
            "ja": "Japanese",
            "zh": "Chinese",
            "ko": "Korean",
            "ar": "Arabic",
            "ru": "Russian",
            "pt": "Portuguese"
        ]
        
        let langName = languageNames[targetLanguage] ?? targetLanguage
        return "[\(text) in \(langName)]"
    }
    
    // MARK: - Configuration
    func setOfflineMode(_ offline: Bool) {
        isOfflineMode = offline
    }
    
    // MARK: - Cache Management
    func clearCache() {
        cache.removeAllObjects()
    }
}
