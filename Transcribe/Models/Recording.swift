//
//  Recording.swift
//  Transcribe
//
//  Created by Chad Parker on 8/26/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation

class Recording: Identifiable, Hashable, Codable {

    let id = UUID()
    let audioFileURL: URL
    var textTranscript: String?
    let duration: Int

    init(audioFileURL: URL, textTranscript: String? = nil, duration: Int) {
        self.audioFileURL = audioFileURL
        self.textTranscript = textTranscript
        self.duration = duration

        if textTranscript == nil {
            transcribe()
        }
    }

    private func transcribe() {
        Transcriber.transcribeAudioURL(audioFileURL) { text in
            self.textTranscript = text
        }
    }

    // MARK: - Hashable

    static func == (lhs: Recording, rhs: Recording) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
