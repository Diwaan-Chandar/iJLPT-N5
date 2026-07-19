//
//  FileContract.swift
//  JLPT-N5
//

import Foundation

public protocol FileContract: Sendable {
    func getKana(type: KanaType) throws -> Kana
    func getKanjis() throws -> Kanji

    func getAudioFileURL(for id: String, in subdirectory: String?) -> URL?
}
