//
//  KanjiView.swift
//  JLPT-N5
//

import SwiftUI

struct KanjiView<Presenter>: View where Presenter: KanjiPresenterContract {
    @ObservedObject var presenter: Presenter
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let kanji = presenter.kanji {
                    ForEach(kanji.sections, id: \.title) { section in
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

                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(section.characters, id: \.id) { character in
                                    NavigationLink(destination: KanjiDetailView(presenter: KanjiDetailPresenter(kanji: character))) {
                                        KanjiCellView(character: character)
                                    }
                                    .buttonStyle(.plain)
                                    .frame(height: 80)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            await presenter.loadKanjis()
        }
    }
}
