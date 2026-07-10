//
//  GetHiraganas.swift
//  JLPT-N5
//

import Foundation

struct GetHiraganaRequest: Request {}

struct GetHiraganaResponse: Response {
    let kana: Kana
}

public protocol GetHiraganasDataManagerContract {
    func getHiragana() throws -> Kana
}

final class GetHiraganas: UseCase<GetHiraganaRequest, GetHiraganaResponse> {
    let dataManager: GetHiraganasDataManagerContract
    
    init(dataManager: GetHiraganasDataManagerContract) {
        self.dataManager = dataManager
    }
    
    override func run(request: GetHiraganaRequest) async throws -> GetHiraganaResponse {
        let kana = try dataManager.getHiragana()
        return GetHiraganaResponse(kana: kana)
    }
}
