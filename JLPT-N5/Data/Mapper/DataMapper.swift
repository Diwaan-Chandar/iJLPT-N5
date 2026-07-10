//
//  DataMapper.swift
//  JLPT-N5
//

import Foundation

final class DataMapper {
    static func mapAudioURLs(to kana: Kana, using fileService: FileContract) -> Kana {
        var updatedKana = kana
        for sIndex in updatedKana.sections.indices {
            for rowIndex in updatedKana.sections[sIndex].rows.indices {
                for charIndex in updatedKana.sections[sIndex].rows[rowIndex].characters.indices {
                    if let id = updatedKana.sections[sIndex].rows[rowIndex].characters[charIndex]?.id {
                        updatedKana.sections[sIndex].rows[rowIndex].characters[charIndex]?.audioURL = fileService.getAudioFileURL(
                            for: id,
                            in: DirectoriesUtil.hiraganaAudio
                        )
                    }
                }
            }
        }
        return updatedKana
    }
}
