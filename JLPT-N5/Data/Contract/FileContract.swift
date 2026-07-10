//
//  FileContract.swift
//  JLPT-N5
//

import Foundation

public protocol FileContract: Sendable {
    func getHiragana() throws -> Kana

    func getAudioFileURL(for id: String, in subdirectory: String?) -> URL?
}
