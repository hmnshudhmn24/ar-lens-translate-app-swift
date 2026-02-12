//
//  ContentView.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var cameraViewModel = CameraViewModel()
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Camera View
                CameraView(viewModel: cameraViewModel)
                    .ignoresSafeArea()
                
                // Overlay UI
                VStack {
                    // Top Bar
                    topBar
                    
                    Spacer()
                    
                    // Bottom Controls
                    bottomControls
                }
                .padding()
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .environmentObject(appState)
            }
            .task {
                // Sync settings with view model
                cameraViewModel.sourceLanguage = appState.sourceLanguage
                cameraViewModel.targetLanguage = appState.targetLanguage
                cameraViewModel.isOfflineMode = appState.isOfflineMode
                
                // Start camera
                await cameraViewModel.startCamera()
            }
            .onDisappear {
                cameraViewModel.cleanup()
            }
            .onChange(of: appState.targetLanguage) { _, newValue in
                cameraViewModel.targetLanguage = newValue
            }
            .onChange(of: appState.sourceLanguage) { _, newValue in
                cameraViewModel.sourceLanguage = newValue
            }
            .onChange(of: appState.isOfflineMode) { _, newValue in
                cameraViewModel.isOfflineMode = newValue
            }
        }
    }
    
    // MARK: - Top Bar
    private var topBar: some View {
        HStack {
            // Language Selector
            languageSelector
            
            Spacer()
            
            // Settings Button
            Button {
                showSettings = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(.ultraThinMaterial, in: Circle())
            }
        }
    }
    
    // MARK: - Language Selector
    private var languageSelector: some View {
        HStack(spacing: 8) {
            Menu {
                ForEach(Language.allLanguages) { language in
                    Button {
                        appState.sourceLanguage = language
                        appState.saveSettings()
                    } label: {
                        Label(language.name, systemImage: appState.sourceLanguage.id == language.id ? "checkmark" : "")
                    }
                }
            } label: {
                HStack {
                    Text(appState.sourceLanguage.flag)
                    Text(appState.sourceLanguage.code.uppercased())
                        .font(.caption.bold())
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial, in: Capsule())
            }
            
            Image(systemName: "arrow.right")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
            
            Menu {
                ForEach(Language.targetLanguages) { language in
                    Button {
                        appState.targetLanguage = language
                        appState.saveSettings()
                    } label: {
                        Label(language.name, systemImage: appState.targetLanguage.id == language.id ? "checkmark" : "")
                    }
                }
            } label: {
                HStack {
                    Text(appState.targetLanguage.flag)
                    Text(appState.targetLanguage.code.uppercased())
                        .font(.caption.bold())
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial, in: Capsule())
            }
        }
    }
    
    // MARK: - Bottom Controls
    private var bottomControls: some View {
        HStack(spacing: 40) {
            // Flash Button (placeholder)
            Button {
                // Toggle flash
            } label: {
                Image(systemName: "bolt.slash.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial, in: Circle())
            }
            
            // Capture Button
            Button {
                cameraViewModel.capturePhoto()
            } label: {
                Circle()
                    .strokeBorder(.white, lineWidth: 4)
                    .frame(width: 70, height: 70)
                    .overlay {
                        Circle()
                            .fill(.white)
                            .frame(width: 58, height: 58)
                    }
            }
            
            // Gallery Button (placeholder)
            Button {
                // Open gallery
            } label: {
                Image(systemName: "photo.on.rectangle")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .background(.ultraThinMaterial, in: Circle())
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
