//
//  KanjiDetailView.swift
//  JLPT-N5
//

import SwiftUI

struct KanjiDetailView<Presenter>: View where Presenter: KanjiDetailPresenterContract {
    @ObservedObject var presenter: Presenter
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Kanji Header
                VStack(spacing: 8) {
                    Text(presenter.kanji.kanji)
                        .font(.system(size: 100, weight: .light, design: .serif))
                }
                .padding(.top, 20)
                
                // Radical Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "pencil.and.outline")
                        Text("Radical")
                            .font(.headline)
                    }
                    .foregroundColor(.secondary)
                    
                    HStack {
                        Text(presenter.kanji.radical)
                            .font(.title2)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Readings
                HStack(alignment: .top, spacing: 16) {
                    // On'yomi
                    if !presenter.kanji.onYomi.isEmpty {
                        readingCard(title: "On'yomi", icon: "character.book.closed", readings: presenter.kanji.onYomi, type: "Katakana")
                    }
                    
                    // Kun'yomi
                    if !presenter.kanji.kunYomi.isEmpty {
                        readingCard(title: "Kun'yomi", icon: "character", readings: presenter.kanji.kunYomi, type: "Hiragana")
                    }
                }
                .padding(.horizontal)
                
                // Sample Words
                let allSampleWords = presenter.kanji.onYomi.flatMap { $0.sampleWords } + presenter.kanji.kunYomi.flatMap { $0.sampleWords }
                if !allSampleWords.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Sample Words")
                                .font(.headline)
                        }
                        .foregroundColor(.secondary)
                        
                        VStack(spacing: 0) {
                            ForEach(Array(allSampleWords.enumerated()), id: \.offset) { index, sample in
                                Button(action: {
                                    presenter.speak(text: sample.word)
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("\(sample.word) (\(sample.reading))")
                                                .font(.body)
                                                .foregroundColor(.primary)
                                            Text(sample.meaning)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Image(systemName: "speaker.wave.2")
                                            .foregroundColor(.blue)
                                    }
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                                .padding(.vertical, 12)
                                
                                if index < allSampleWords.count - 1 {
                                    Divider()
                                }
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 30)
        }
        .navigationTitle(presenter.kanji.kanji)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func readingCard(title: String, icon: String, readings: [KanjiReading], type: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(readings, id: \.kana) { reading in
                    Button(action: {
                        presenter.speak(text: reading.kana)
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(reading.kana)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                Text(reading.romaji)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(reading.meaning)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "speaker.wave.2")
                                .foregroundColor(.blue)
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
        }
    }
}
