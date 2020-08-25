//
//  AudioPlayer.swift
//  AudioComments
//
//  Created by Chad Parker on 2020-07-14.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject, ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var isPlaying = false
    @Published private(set) var elapsedTimeString = ""
    @Published private(set) var remainingTimeString = ""
    
    private var audioPlayer: AVAudioPlayer? {
        didSet {
            guard let audioPlayer = audioPlayer else { return }
            
            audioPlayer.delegate = self
            updateProperties()
        }
    }
    private weak var timer: Timer?
    
    private lazy var timeIntervalFormatter: DateComponentsFormatter = {
        // NOTE: DateComponentFormatter is good for minutes/hours/seconds
        // DateComponentsFormatter is not good for milliseconds, use DateFormatter instead)
        
        let formatting = DateComponentsFormatter()
        formatting.unitsStyle = .positional // 00:00  mm:ss
        formatting.zeroFormattingBehavior = .pad
        formatting.allowedUnits = [.minute, .second]
        return formatting
    }()
    
    private func updateProperties() {
        isPlaying = audioPlayer?.isPlaying ?? false
        
        let elapsedTime = audioPlayer?.currentTime ?? 0
        let duration = audioPlayer?.duration ?? 0
        let timeRemaining = duration.rounded() - elapsedTime
        
        elapsedTimeString = timeIntervalFormatter.string(from: elapsedTime)!
        
        //timeSlider.minimumValue = 0
        //timeSlider.maximumValue = Float(duration)
        //timeSlider.value = Float(elapsedTime)
        
        remainingTimeString = "-" + timeIntervalFormatter.string(from: timeRemaining)!
    }

    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        loadAudio()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    
    // MARK: - Playback
    
    func loadAudio(url: URL? = Bundle.main.url(forResource: "piano", withExtension: "mp3")) {
        guard let url = url else {
            print("URL was nil")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            preconditionFailure("Failure to load audio file: \(error)")
        }
    }
    
    func play() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, options: [.defaultToSpeaker])
            try session.setActive(true, options: []) // can fail if on a phone call, for instance

            audioPlayer?.play()
            updateProperties()
            startTimer()
        } catch {
            print("Cannot play audio: \(error)")
        }
    }
    
    func pause() {
        audioPlayer?.pause()
        updateProperties()
        cancelTimer()
    }

    func togglePlayback() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }


    // MARK: - Timer

    private func startTimer() {
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 0.030, repeats: true) { [weak self] (_) in
            guard let self = self else { return }

            self.updateProperties()

//            if let audioPlayer = self.audioPlayer,
//                self.isPlaying == true {
//
//                audioPlayer.updateMeters()
//                self.audioVisualizer.addValue(decibelValue: audioPlayer.averagePower(forChannel: 0))
//            }
        }
    }

    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
}


// MARK: - Delegate

extension AudioPlayer: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateProperties()
        cancelTimer()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            print("Audio Player Error: \(error)")
        }
    }
}
