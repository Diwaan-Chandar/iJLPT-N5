//
//  Kanji.swift
//  JLPT-N5
//

import Foundation

public struct KanjiCharacter: Codable, Sendable {
    let kanji: String
    let id: String
    let strokes: [String]
    let radical: String
    let radicalId: String?
    let onYomi: [KanjiReading]
    let kunYomi: [KanjiReading]
}

public struct KanjiReading: Codable, Sendable {
    let kana: String
    let romaji: String
    let meaning: String
    let sampleWords: [KanjiSampleWord]
}

public struct KanjiSampleWord: Codable, Sendable {
    let word: String
    let reading: String
    let meaning: String
}

public struct KanjiSection: Codable, Sendable {
    let title: String
    let description: String
    var characters: [KanjiCharacter]
}

public struct Kanji: Codable, Sendable {
    var sections: [KanjiSection]
}

