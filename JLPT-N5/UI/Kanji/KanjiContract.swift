//
//  KanjiContract.swift
//  JLPT-N5
//

import Foundation
import Combine

@MainActor
public protocol KanjiPresenterContract: ObservableObject {
    var kanji: Kanji? { get }
    func loadKanjis() async
}
