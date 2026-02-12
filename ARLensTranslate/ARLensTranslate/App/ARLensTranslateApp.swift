//
//  ARLensTranslateApp.swift
//  ARLensTranslate
//
//  Created on 2026.
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0

import SwiftUI

@main
struct ARLensTranslateApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var sourceLanguage: Language = .auto
    @Published var targetLanguage: Language = .spanish
    @Published var isOfflineMode: Bool = false
    @Published var savedTranslations: [SavedTranslation] = []
    
    init() {
        loadSettings()
    }
    
    private func loadSettings() {
        // Load user preferences from UserDefaults
        if let sourceCode = UserDefaults.standard.string(forKey: "sourceLanguage") {
            sourceLanguage = Language.fromCode(sourceCode)
        }
        if let targetCode = UserDefaults.standard.string(forKey: "targetLanguage") {
            targetLanguage = Language.fromCode(targetCode)
        }
        isOfflineMode = UserDefaults.standard.bool(forKey: "isOfflineMode")
    }
    
    func saveSettings() {
        UserDefaults.standard.set(sourceLanguage.code, forKey: "sourceLanguage")
        UserDefaults.standard.set(targetLanguage.code, forKey: "targetLanguage")
        UserDefaults.standard.set(isOfflineMode, forKey: "isOfflineMode")
    }
    
    func addSavedTranslation(_ translation: SavedTranslation) {
        savedTranslations.insert(translation, at: 0)
        if savedTranslations.count > 100 {
            savedTranslations.removeLast()
        }
    }
}

// MARK: - Saved Translation Model
struct SavedTranslation: Identifiable, Codable {
    let id: UUID
    let originalText: String
    let translatedText: String
    let sourceLanguage: String
    let targetLanguage: String
    let timestamp: Date
    
    init(id: UUID = UUID(), originalText: String, translatedText: String, sourceLanguage: String, targetLanguage: String, timestamp: Date = Date()) {
        self.id = id
        self.originalText = originalText
        self.translatedText = translatedText
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
        self.timestamp = timestamp
    }
}
