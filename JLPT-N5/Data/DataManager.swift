//
//  DataManager.swift
//  JLPT-N5
//

import Foundation

public class DataManager {
    let networkService: NetworkContract
    let databaseService: DatabaseContract
    let fileService: FileContract

    public init(networkService: NetworkContract, databaseService: DatabaseContract, fileService: FileContract) {
        self.networkService = networkService
        self.databaseService = databaseService
        self.fileService = fileService
    }
}

extension DataManager: GetKanaDataManagerContract {
    public func getKana(type: KanaType) throws -> Kana {
        let kana = try fileService.getKana(type: type)
        return DataMapper.mapAudioURLs(to: kana, type: type, using: fileService)
    }
}

extension DataManager: GetKanjisDataManagerContract {
    public func getKanjis() throws -> Kanji {
        return try fileService.getKanjis()
    }
}
