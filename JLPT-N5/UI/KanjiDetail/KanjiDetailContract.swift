//
//  KanjiDetailContract.swift
//  JLPT-N5
//

import Foundation
import Combine

@MainActor
public protocol KanjiDetailPresenterContract: ObservableObject {
    var kanji: KanjiCharacter { get }
    func speak(text: String)
}
