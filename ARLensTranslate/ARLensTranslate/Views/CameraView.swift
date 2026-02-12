//
//  CameraView.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import SwiftUI
import AVFoundation

struct CameraView: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Camera Preview
                CameraPreviewView(cameraService: viewModel.cameraService)
                    .ignoresSafeArea()
                
                // Translation Overlays
                TranslationOverlayView(
                    detectedTexts: viewModel.detectedTexts,
                    viewSize: geometry.size
                )
                
                // Processing Indicator
                if viewModel.isProcessing {
                    VStack {
                        HStack {
                            Spacer()
                            ProgressView()
                                .tint(.white)
                                .padding(8)
                                .background(.ultraThinMaterial, in: Circle())
                                .padding()
                        }
                        Spacer()
                    }
                }
                
                // Error Message
                if let error = viewModel.errorMessage {
                    VStack {
                        Spacer()
                        Text(error)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red.opacity(0.8), in: RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                }
            }
        }
    }
}

// MARK: - Camera Preview View
struct CameraPreviewView: UIViewRepresentable {
    let cameraService: CameraService
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        
        let previewLayer = cameraService.getPreviewLayer()
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            DispatchQueue.main.async {
                previewLayer.frame = uiView.bounds
            }
        }
    }
}

// MARK: - Translation Overlay View
struct TranslationOverlayView: View {
    let detectedTexts: [DetectedText]
    let viewSize: CGSize
    
    var body: some View {
        ZStack {
            ForEach(detectedTexts) { detectedText in
                if let translation = detectedText.translation {
                    TranslationBubble(
                        text: translation,
                        boundingBox: detectedText.boundingBox,
                        viewSize: viewSize
                    )
                }
            }
        }
    }
}

// MARK: - Translation Bubble
struct TranslationBubble: View {
    let text: String
    let boundingBox: CGRect
    let viewSize: CGSize
    
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.blue.opacity(0.9))
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            )
            .position(
                x: convertCoordinate(boundingBox.midX, from: boundingBox.width, to: viewSize.width),
                y: convertCoordinate(boundingBox.midY, from: boundingBox.height, to: viewSize.height)
            )
            .transition(.scale.combined(with: .opacity))
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: text)
    }
    
    private func convertCoordinate(_ value: CGFloat, from sourceSize: CGFloat, to targetSize: CGFloat) -> CGFloat {
        return (value / sourceSize) * targetSize
    }
}

#Preview {
    CameraView(viewModel: CameraViewModel())
}
