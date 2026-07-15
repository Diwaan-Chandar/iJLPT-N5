//
//  DataMapper.swift
//  JLPT-N5
//

import Foundation

final class DataMapper {
    static func mapAudioURLs(to kana: Kana, type: KanaType, using fileService: FileContract) -> Kana {
        var updatedKana = kana
        for sIndex in updatedKana.sections.indices {
            let maxCols = updatedKana.sections[sIndex].rows.map { $0.characters.count }.max() ?? 0
            updatedKana.sections[sIndex].columnsCount = maxCols
            for rowIndex in updatedKana.sections[sIndex].rows.indices {
                for charIndex in updatedKana.sections[sIndex].rows[rowIndex].characters.indices {
                    if let id = updatedKana.sections[sIndex].rows[rowIndex].characters[charIndex]?.id {
                        updatedKana.sections[sIndex].rows[rowIndex].characters[charIndex]?.audioURL = fileService.getAudioFileURL(
                            for: id,
                            in: DirectoriesUtil.audioDirectory(for: type)
                        )
                    }
                }
            }
        }
        return updatedKana
    }
}
