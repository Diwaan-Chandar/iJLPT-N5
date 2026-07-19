//
//  ContentView.swift
//  JLPT-N5
//

import SwiftUI

struct ContentView: View {
    @StateObject private var kanaPresenter: KanaPresenter
    @StateObject private var kanjiPresenter: KanjiPresenter
    
    init() {
        let networkService = NetworkService()
        let databaseService = DatabaseService()
        let fileService = FileService()
        let dataManager = DataManager(
            networkService: networkService,
            databaseService: databaseService,
            fileService: fileService
        )
        let getKanaUseCase = GetKana(dataManager: dataManager)
        let kanaPresenter = KanaPresenter(getKana: getKanaUseCase)
        
        let getKanjisUseCase = GetKanjis(dataManager: dataManager)
        let kanjiPresenter = KanjiPresenter(getKanjisUseCase: getKanjisUseCase)
        
        _kanaPresenter = StateObject(wrappedValue: kanaPresenter)
        _kanjiPresenter = StateObject(wrappedValue: kanjiPresenter)
    }

    var body: some View {
        TabView {
            Text("Coming Soon...")
                .tabItem {
                    Label("Flash Cards", systemImage: "rectangle.stack")
                }
            
            Text("Coming Soon...")
                .tabItem {
                    Label("Words", systemImage: "character.book.closed")
                }
            
            Text("Coming Soon...")
                .tabItem {
                    Label("Listen", systemImage: "headphones")
                }
            
            NavigationStack {
                KanaContainerView(kanaPresenter: kanaPresenter, kanjiPresenter: kanjiPresenter)
            }
            .tabItem {
                Label("Kana", systemImage: "textformat.abc")
            }
        }
    }
}

#Preview {
    ContentView()
}
