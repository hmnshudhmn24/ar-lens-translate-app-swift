//
//  SettingsView.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                // Translation Settings
                Section {
                    Picker("Source Language", selection: $appState.sourceLanguage) {
                        ForEach(Language.allLanguages) { language in
                            HStack {
                                Text(language.flag)
                                Text(language.name)
                            }
                            .tag(language)
                        }
                    }
                    
                    Picker("Target Language", selection: $appState.targetLanguage) {
                        ForEach(Language.targetLanguages) { language in
                            HStack {
                                Text(language.flag)
                                Text(language.name)
                            }
                            .tag(language)
                        }
                    }
                } header: {
                    Text("Translation")
                } footer: {
                    Text("Select source and target languages for real-time translation")
                }
                
                // Mode Settings
                Section {
                    Toggle("Offline Mode", isOn: $appState.isOfflineMode)
                } header: {
                    Text("Mode")
                } footer: {
                    Text("Use on-device translation models when offline. Limited language support.")
                }
                
                // History
                Section {
                    NavigationLink {
                        HistoryView()
                    } label: {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                            Text("Translation History")
                            Spacer()
                            Text("\(appState.savedTranslations.count)")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Button(role: .destructive) {
                        appState.savedTranslations.removeAll()
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Clear History")
                        }
                    }
                    .disabled(appState.savedTranslations.isEmpty)
                } header: {
                    Text("Data")
                }
                
                // About
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    
                    Link(destination: URL(string: "https://github.com/yourusername/ar-lens-translate")!) {
                        HStack {
                            Image(systemName: "link")
                            Text("GitHub Repository")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/yourusername/ar-lens-translate/blob/main/LICENSE")!) {
                        HStack {
                            Image(systemName: "doc.text")
                            Text("License")
                            Spacer()
                            Text("Apache 2.0")
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Text("About")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        appState.saveSettings()
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - History View
struct HistoryView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            if appState.savedTranslations.isEmpty {
                ContentUnavailableView(
                    "No Translation History",
                    systemImage: "clock.arrow.circlepath",
                    description: Text("Your translation history will appear here")
                )
            } else {
                ForEach(appState.savedTranslations) { translation in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(Language.fromCode(translation.sourceLanguage).flag)
                            Text(translation.originalText)
                                .font(.body)
                            Spacer()
                        }
                        
                        HStack {
                            Text(Language.fromCode(translation.targetLanguage).flag)
                            Text(translation.translatedText)
                                .font(.body)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        
                        Text(translation.timestamp, style: .relative)
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
