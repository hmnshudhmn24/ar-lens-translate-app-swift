//
//  Extensions.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import SwiftUI
import UIKit

// MARK: - View Extensions
extension View {
    /// Adds a border with rounded corners
    func roundedBorder(color: Color = .primary, lineWidth: CGFloat = 1, cornerRadius: CGFloat = 8) -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(color, lineWidth: lineWidth)
            )
    }
}

// MARK: - Color Extensions
extension Color {
    static let appPrimary = Color.blue
    static let appSecondary = Color.purple
    static let appBackground = Color(.systemBackground)
    static let appSecondaryBackground = Color(.secondarySystemBackground)
}

// MARK: - UIImage Extensions
extension UIImage {
    /// Resizes image to fit within max dimension while maintaining aspect ratio
    func resized(maxDimension: CGFloat) -> UIImage {
        let scale = maxDimension / max(size.width, size.height)
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    /// Saves image to photo library
    func saveToPhotos(completion: @escaping (Bool) -> Void) {
        UIImageWriteToSavedPhotosAlbum(self, nil, nil, nil)
        completion(true)
    }
}

// MARK: - String Extensions
extension String {
    /// Truncates string to specified length
    func truncated(to length: Int, addEllipsis: Bool = true) -> String {
        if self.count <= length {
            return self
        }
        let truncated = String(self.prefix(length))
        return addEllipsis ? truncated + "..." : truncated
    }
    
    /// Removes extra whitespace and newlines
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Date Extensions
extension Date {
    /// Formats date as relative time (e.g., "2 hours ago")
    var relativeTime: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    /// Formats date as short string
    var shortFormat: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}

// MARK: - CGRect Extensions
extension CGRect {
    /// Returns center point of rectangle
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    /// Scales rectangle by given factor
    func scaled(by factor: CGFloat) -> CGRect {
        let newWidth = width * factor
        let newHeight = height * factor
        let newX = midX - newWidth / 2
        let newY = midY - newHeight / 2
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
}

// MARK: - Array Extensions
extension Array where Element == DetectedText {
    /// Filters texts by minimum confidence
    func byConfidence(minimum: Float) -> [DetectedText] {
        self.filter { $0.confidence >= minimum }
    }
    
    /// Groups nearby texts
    func groupedByProximity(threshold: CGFloat = 50) -> [[DetectedText]] {
        var groups: [[DetectedText]] = []
        var remaining = self
        
        while !remaining.isEmpty {
            var group = [remaining.first!]
            remaining.removeFirst()
            
            var i = 0
            while i < remaining.count {
                let text = remaining[i]
                if group.contains(where: { $0.boundingBox.center.distance(to: text.boundingBox.center) < threshold }) {
                    group.append(text)
                    remaining.remove(at: i)
                } else {
                    i += 1
                }
            }
            
            groups.append(group)
        }
        
        return groups
    }
}

// MARK: - CGPoint Extensions
extension CGPoint {
    /// Calculates distance to another point
    func distance(to point: CGPoint) -> CGFloat {
        let dx = x - point.x
        let dy = y - point.y
        return sqrt(dx * dx + dy * dy)
    }
}
