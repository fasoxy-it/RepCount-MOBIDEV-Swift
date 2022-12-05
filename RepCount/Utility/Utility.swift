//
//  Utility.swift
//  RepCount
//
//  Created by Mattia Fasoli on 18/11/22.
//

import Foundation
import AVFoundation

func formatTimerMmSsMSms(counter: Double) -> String {
    let minutes = Int(counter) / 60 % 60
    let seconds = Int(counter) % 60
    let milliseconds = Int(counter*1000) % 1000
    return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
}

struct Utility {
    
    let synthesizer = AVSpeechSynthesizer()
    
    func speak(string: String) {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
    
}
