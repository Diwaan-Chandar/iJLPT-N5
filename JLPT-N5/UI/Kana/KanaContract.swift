//
//  KanaContract.swift
//  JLPT-N5
//

import Foundation
import Combine

protocol KanaPresenterContract: ObservableObject {
    var kana: Kana? { get }
    func loadKana(type: KanaType) async
    func playSound(for character: Character)
}
