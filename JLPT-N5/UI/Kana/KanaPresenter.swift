//
//  KanaPresenter.swift
//  JLPT-N5
//

import Foundation
import Combine
import AVFoundation

final class KanaPresenter: KanaPresenterContract {
    @Published var kana: Kana?
    
    private let getKana: GetKana
    private var audioPlayer: AVAudioPlayer?
    
    init(getKana: GetKana) {
        self.getKana = getKana
    }
    
    func loadKana(type: KanaType) async {
        do {
            let request = GetKanaRequest(kanaType: type)
            let response = try await getKana.execute(request: request)
            
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
