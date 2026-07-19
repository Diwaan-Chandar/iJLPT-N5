//
//  KanjiPresenter.swift
//  JLPT-N5
//

import Foundation
import Combine

@MainActor
public final class KanjiPresenter: KanjiPresenterContract {
    @Published public var kanji: Kanji?
    
    private let getKanjisUseCase: UseCase<GetKanjisRequest, GetKanjisResponse>
    
    init(getKanjisUseCase: UseCase<GetKanjisRequest, GetKanjisResponse>) {
        self.getKanjisUseCase = getKanjisUseCase
    }
    
    public func loadKanjis() async {
        do {
            let response = try await getKanjisUseCase.execute(request: GetKanjisRequest())
            self.kanji = response.kanji
        } catch {
            print("Error loading Kanjis: \(error)")
        }
    }
}
