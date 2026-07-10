//
//  KanaContainerView.swift
//  JLPT-N5
//

import SwiftUI

struct KanaContainerView: View {
    @ObservedObject var presenter: KanaPresenter

    var body: some View {
        List {
            NavigationLink(destination: KanaView(presenter: presenter)) {
                Text("Hiragana")
            }
            
            NavigationLink(destination: Text("Coming Soon...")
                .navigationTitle("Katakana")) {
                Text("Katakana")
            }
            
            NavigationLink(destination: Text("Coming Soon...")
                .navigationTitle("Kanji")) {
                Text("Kanji")
            }
        }
        .navigationTitle("Kana")
    }
}
