//
//  KanaCellView.swift
//  JLPT-N5
//

import SwiftUI

struct KanaCellView: View {
    let character: Character?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if let char = character {
                VStack(spacing: 0) {
                    Text(char.kana)
                        .font(.title.bold())
                    Text(char.romaji)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary.opacity(0.1), lineWidth: 2)
                )
                .contentShape(Rectangle())
            }
        }
        .buttonStyle(.plain)
        .frame(height: 80)
    }
}
