//
//  GetKanjis.swift
//  JLPT-N5
//

import Foundation

struct GetKanjisRequest: Request {
}

struct GetKanjisResponse: Response {
    let kanji: Kanji
}

public protocol GetKanjisDataManagerContract {
    func getKanjis() throws -> Kanji
}

final class GetKanjis: UseCase<GetKanjisRequest, GetKanjisResponse> {
    let dataManager: GetKanjisDataManagerContract
    
    init(dataManager: GetKanjisDataManagerContract) {
        self.dataManager = dataManager
    }
    
    override func run(request: GetKanjisRequest) async throws -> GetKanjisResponse {
        let kanji = try dataManager.getKanjis()
        return GetKanjisResponse(kanji: kanji)
    }
}
