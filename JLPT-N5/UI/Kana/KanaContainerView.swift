//
//  KanaContainerView.swift
//  JLPT-N5
//

import SwiftUI

enum KanaTab: String, CaseIterable {
    case hiragana = "HIRAGANA"
    case katakana = "KATAKANA"
    case kanji = "KANJI"
}

struct KanaContainerView: View {
    @ObservedObject var presenter: KanaPresenter
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
            
#if os(macOS)
            switch selectedTab {
            case .hiragana:
                KanaView(presenter: presenter)
            case .katakana:
                Text("Coming Soon...")
            case .kanji:
                Text("Coming Soon...")
            }
            Spacer()
#else
            TabView(selection: $selectedTab) {
                KanaView(presenter: presenter)
                    .tag(KanaTab.hiragana)
                
                Text("Coming Soon...")
                    .tag(KanaTab.katakana)
                
                Text("Coming Soon...")
                    .tag(KanaTab.kanji)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
#endif
        }
    }
}
