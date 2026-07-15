//
//  Character.swift
//  JLPT-N5
//

import Foundation

public struct Character: Codable, Sendable {
    let kana: String
    let romaji: String
    let id: String
    var audioURL: URL?

    enum CodingKeys: String, CodingKey {
        case kana, romaji, id
    }
}

public struct KanaRow: Codable, Sendable {
    let row: String
    var characters: [Character?]
}

public struct KanaSection: Codable, Sendable {
    let title: String
    let description: String
    var columnsCount: Int = 0
    var rows: [KanaRow]

    enum CodingKeys: String, CodingKey {
        case title, description, rows
    }
}

public struct Kana: Codable, Sendable {
    var sections: [KanaSection]
}
