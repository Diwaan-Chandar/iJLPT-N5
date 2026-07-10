//
//  ContentView.swift
//  JLPT-N5
//

import SwiftUI

struct ContentView: View {
    @StateObject private var kanaPresenter: KanaPresenter
    
    init() {
        let networkService = NetworkService()
        let databaseService = DatabaseService()
        let fileService = FileService()
        let dataManager = DataManager(
            networkService: networkService,
            databaseService: databaseService,
            fileService: fileService
        )
        let getHiraganasUseCase = GetHiraganas(dataManager: dataManager)
        let presenter = KanaPresenter(getHiraganas: getHiraganasUseCase)
        
        _kanaPresenter = StateObject(wrappedValue: presenter)
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
                KanaContainerView(presenter: kanaPresenter)
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
