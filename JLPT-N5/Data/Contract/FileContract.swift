//
//  FileContract.swift
//  JLPT-N5
//

import Foundation

public protocol FileContract: Sendable {
    func getKana(type: KanaType) throws -> Kana

    func getAudioFileURL(for id: String, in subdirectory: String?) -> URL?
}
