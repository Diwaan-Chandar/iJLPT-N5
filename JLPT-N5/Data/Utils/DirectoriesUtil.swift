//
//  DirectoriesUtil.swift
//  JLPT-N5
//

import Foundation

enum DirectoriesUtil {
    static let hiraganaData: String? = nil
    static let hiraganaAudio: String? = nil
    static let katakanaData: String? = nil
    static let katakanaAudio: String? = nil
    static let kanjiData: String? = nil
    static let kanjiAudio: String? = nil
    
    static func audioDirectory(for type: KanaType) -> String? {
        switch type {
        case .hiragana: return hiraganaAudio
        case .katakana: return katakanaAudio
        case .kanji: return kanjiAudio
        }
    }
}
