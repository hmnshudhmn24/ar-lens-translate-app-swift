//
//  Language.swift
//  ARLensTranslate
//
//  Copyright © 2026 AR Lens Translate. All rights reserved.
//  Licensed under the Apache License, Version 2.0

import Foundation

struct Language: Identifiable, Hashable, Codable {
    let id: String
    let code: String
    let name: String
    let flag: String
    
    init(code: String, name: String, flag: String) {
        self.id = code
        self.code = code
        self.name = name
        self.flag = flag
    }
    
    // MARK: - Predefined Languages
    static let auto = Language(code: "auto", name: "Auto Detect", flag: "🌐")
    static let english = Language(code: "en", name: "English", flag: "🇺🇸")
    static let spanish = Language(code: "es", name: "Spanish", flag: "🇪🇸")
    static let french = Language(code: "fr", name: "French", flag: "🇫🇷")
    static let german = Language(code: "de", name: "German", flag: "🇩🇪")
    static let italian = Language(code: "it", name: "Italian", flag: "🇮🇹")
    static let portuguese = Language(code: "pt", name: "Portuguese", flag: "🇵🇹")
    static let russian = Language(code: "ru", name: "Russian", flag: "🇷🇺")
    static let japanese = Language(code: "ja", name: "Japanese", flag: "🇯🇵")
    static let chinese = Language(code: "zh", name: "Chinese", flag: "🇨🇳")
    static let korean = Language(code: "ko", name: "Korean", flag: "🇰🇷")
    static let arabic = Language(code: "ar", name: "Arabic", flag: "🇸🇦")
    static let hindi = Language(code: "hi", name: "Hindi", flag: "🇮🇳")
    static let dutch = Language(code: "nl", name: "Dutch", flag: "🇳🇱")
    static let polish = Language(code: "pl", name: "Polish", flag: "🇵🇱")
    static let turkish = Language(code: "tr", name: "Turkish", flag: "🇹🇷")
    static let swedish = Language(code: "sv", name: "Swedish", flag: "🇸🇪")
    static let danish = Language(code: "da", name: "Danish", flag: "🇩🇰")
    static let norwegian = Language(code: "no", name: "Norwegian", flag: "🇳🇴")
    static let finnish = Language(code: "fi", name: "Finnish", flag: "🇫🇮")
    static let greek = Language(code: "el", name: "Greek", flag: "🇬🇷")
    static let czech = Language(code: "cs", name: "Czech", flag: "🇨🇿")
    static let romanian = Language(code: "ro", name: "Romanian", flag: "🇷🇴")
    static let thai = Language(code: "th", name: "Thai", flag: "🇹🇭")
    static let vietnamese = Language(code: "vi", name: "Vietnamese", flag: "🇻🇳")
    static let indonesian = Language(code: "id", name: "Indonesian", flag: "🇮🇩")
    static let malay = Language(code: "ms", name: "Malay", flag: "🇲🇾")
    static let hebrew = Language(code: "he", name: "Hebrew", flag: "🇮🇱")
    static let ukrainian = Language(code: "uk", name: "Ukrainian", flag: "🇺🇦")
    
    // MARK: - All Available Languages
    static let allLanguages: [Language] = [
        .auto,
        .english,
        .spanish,
        .french,
        .german,
        .italian,
        .portuguese,
        .russian,
        .japanese,
        .chinese,
        .korean,
        .arabic,
        .hindi,
        .dutch,
        .polish,
        .turkish,
        .swedish,
        .danish,
        .norwegian,
        .finnish,
        .greek,
        .czech,
        .romanian,
        .thai,
        .vietnamese,
        .indonesian,
        .malay,
        .hebrew,
        .ukrainian
    ]
    
    static let targetLanguages: [Language] = allLanguages.filter { $0.code != "auto" }
    
    // MARK: - Helper Methods
    static func fromCode(_ code: String) -> Language {
        return allLanguages.first { $0.code == code } ?? .english
    }
}
