//
//  KanjiDetailPresenter.swift
//  JLPT-N5
//

import Foundation
import Combine
import AVFoundation

@MainActor
public final class KanjiDetailPresenter: KanjiDetailPresenterContract {
    @Published public var kanji: KanjiCharacter
    private let synthesizer = AVSpeechSynthesizer()
    
    init(kanji: KanjiCharacter) {
        self.kanji = kanji
    }
    
    public func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        synthesizer.speak(utterance)
    }
}
