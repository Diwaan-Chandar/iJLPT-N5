//
//  KanjiCellView.swift
//  JLPT-N5
//

import SwiftUI

struct KanjiCellView: View {
    let character: KanjiCharacter?
    
    var body: some View {
        if let char = character {
            VStack(spacing: 0) {
                Text(char.kanji)
                    .font(.largeTitle.bold())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 2)
            )
            .contentShape(Rectangle())
        } else {
            Color.clear
        }
    }
}
