//
//  KanaContainerView.swift
//  JLPT-N5
//

import SwiftUI

enum KanaTab: String, CaseIterable {
    case hiragana = "HIRAGANA"
    case katakana = "KATAKANA"
    case kanji = "KANJI"
    
    var type: KanaType? {
        switch self {
        case .hiragana: return .hiragana
        case .katakana: return .katakana
        case .kanji: return nil
        }
    }
}

struct KanaContainerView: View {
    @ObservedObject var kanaPresenter: KanaPresenter
    @ObservedObject var kanjiPresenter: KanjiPresenter
    @State private var selectedTab: KanaTab = .hiragana
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 0) {
                ForEach(KanaTab.allCases, id: \.self) { tab in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedTab = tab
                        }
                    }) {
                        VStack(spacing: 8) {
                            Text(tab.rawValue)
                                .font(.default)
                                .bold()
                                .foregroundColor(selectedTab == tab ? .accentColor : .gray)
                                .padding(.vertical, 3)
                            
                            Rectangle()
                                .fill(selectedTab == tab ? Color.accentColor : Color.gray.opacity(0.3))
                                .frame(height: 3)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                    .frame(height: 40)
                }
            }
            .frame(height: 38)
            .padding(.horizontal)
            
            if let type = selectedTab.type {
                KanaView(presenter: kanaPresenter, type: type)
            } else if selectedTab == .kanji {
                KanjiView(presenter: kanjiPresenter)
            } else {
                Text("Coming Soon...")
            }
            Spacer()
        }
    }
}
