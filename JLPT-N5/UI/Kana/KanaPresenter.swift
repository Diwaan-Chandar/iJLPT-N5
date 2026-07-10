//
//  KanaPresenter.swift
//  JLPT-N5
//

import Foundation
import Combine
import AVFoundation

final class KanaPresenter: KanaPresenterContract {
    @Published var kana: Kana?
    
    private let getHiraganas: GetHiraganas
    private var audioPlayer: AVAudioPlayer?
    
    init(getHiraganas: GetHiraganas) {
        self.getHiraganas = getHiraganas
    }
    
    func loadKana() async {
        do {
            let request = GetHiraganaRequest()
            let response = try await getHiraganas.execute(request: request)
            
            await MainActor.run {
                self.kana = response.kana
            }
        } catch {
            print("Error loading Kana: \(error)")
        }
    }
    
    func playSound(for character: Character) {
        guard let url = character.audioURL else { return }
        
        do {
            // In a real app this might need try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error)")
        }
    }
}
