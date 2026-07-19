//
//  FileService.swift
//  JLPT-N5
//

import Foundation

enum FileServiceError: Error {
    case fileNotFound(String)
}

final class FileService: FileContract {
    func getKana(type: KanaType) throws -> Kana {
        let isMainThread = Thread.isMainThread
        
        let resourceName: String
        let subdirectory: String?
        
        switch type {
        case .hiragana:
            resourceName = "Hiragana"
            subdirectory = DirectoriesUtil.hiraganaData
        case .katakana:
            resourceName = "Katakana"
            subdirectory = DirectoriesUtil.katakanaData
        case .kanji:
            resourceName = "Kanji"
            subdirectory = DirectoriesUtil.kanjiData
        }
        
        guard let url = Bundle.main.url(
            forResource: resourceName,
            withExtension: "json",
            subdirectory: subdirectory
        ) else {
            throw FileServiceError.fileNotFound(resourceName)
        }
        let data = try Data(contentsOf: url)
        let sections = try JSONDecoder().decode([KanaSection].self, from: data)
        return Kana(sections: sections)
    }

    func getKanjis() throws -> Kanji {
        guard let url = Bundle.main.url(
            forResource: "Kanji",
            withExtension: "json",
            subdirectory: DirectoriesUtil.kanjiData
        ) else {
            throw FileServiceError.fileNotFound("Kanji")
        }
        let data = try Data(contentsOf: url)
        let sections = try JSONDecoder().decode([KanjiSection].self, from: data)
        return Kanji(sections: sections)
    }

    func getAudioFileURL(for id: String, in subdirectory: String? = nil) -> URL? {
        return Bundle.main.url(
            forResource: id,
            withExtension: "mp3",
            subdirectory: subdirectory
        )
    }
}
