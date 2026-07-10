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

extension DataManager: GetHiraganasDataManagerContract {
    public func getHiragana() throws -> Kana {
        let kana = try fileService.getHiragana()
        return DataMapper.mapAudioURLs(to: kana, using: fileService)
    }
}
