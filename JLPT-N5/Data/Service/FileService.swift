//
//  FileService.swift
//  JLPT-N5
//

import Foundation

enum FileServiceError: Error {
    case fileNotFound(String)
}

final class FileService: FileContract {
    func getHiragana() throws -> Kana {
        let isMainThread = Thread.isMainThread
        guard let url = Bundle.main.url(
            forResource: "Hiragana",
            withExtension: "json",
            subdirectory: DirectoriesUtil.hiraganaData
        ) else {
            throw FileServiceError.fileNotFound("Hiragana")
        }
        let data = try Data(contentsOf: url)
        let sections = try JSONDecoder().decode([KanaSection].self, from: data)
        return Kana(sections: sections)
    }

    func getAudioFileURL(for id: String, in subdirectory: String? = nil) -> URL? {
        return Bundle.main.url(
            forResource: id,
            withExtension: "mp3",
            subdirectory: subdirectory
        )
    }
}
