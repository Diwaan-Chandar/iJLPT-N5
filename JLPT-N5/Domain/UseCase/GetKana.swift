//
//  GetKana.swift
//  JLPT-N5
//

import Foundation

struct GetKanaRequest: Request {
    let kanaType: KanaType
}

struct GetKanaResponse: Response {
    let kana: Kana
}

public protocol GetKanaDataManagerContract {
    func getKana(type: KanaType) throws -> Kana
}

final class GetKana: UseCase<GetKanaRequest, GetKanaResponse> {
    let dataManager: GetKanaDataManagerContract
    
    init(dataManager: GetKanaDataManagerContract) {
        self.dataManager = dataManager
    }
    
    override func run(request: GetKanaRequest) async throws -> GetKanaResponse {
        let kana = try dataManager.getKana(type: request.kanaType)
        return GetKanaResponse(kana: kana)
    }
}
