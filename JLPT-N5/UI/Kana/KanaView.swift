//
//  KanaView.swift
//  JLPT-N5
//

import SwiftUI

struct KanaView<Presenter>: View where Presenter: KanaPresenterContract {
    @ObservedObject var presenter: Presenter
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let kana = presenter.kana {
                    ForEach(kana.sections, id: \.title) { section in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(section.title)
                                .font(.title)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(section.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer(minLength: 2)

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: section.columnsCount), spacing: 10) {
                                ForEach(section.rows, id: \.row) { row in
                                    ForEach(0..<section.columnsCount, id: \.self) { index in
                                        if index < row.characters.count {
                                            KanaCellView(character: row.characters[index]) {
                                                if let character = row.characters[index] {
                                                    presenter.playSound(for: character)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            await presenter.loadKana()
        }
        .navigationTitle("Hiragana")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}
