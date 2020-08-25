//
//  AudioRecorder.swift
//  AudioComments
//
//  Created by Chad Parker on 2020-07-13.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
     
    // MARK: - Properties

    @Published private(set) var isRecording = false
    @Published private(set) var elapsedTimeString = ""
    
    var recordingURL: URL?
    var audioRecorder: AVAudioRecorder?
    weak var timer: Timer?

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
        isRecording = audioRecorder?.isRecording ?? false

        let elapsedTime = audioRecorder?.currentTime ?? 0
        elapsedTimeString = timeIntervalFormatter.string(from: elapsedTime)!
    }


    // MARK: - Lifecycle

    override init() {
        super.init()
    }

    deinit {
        timer?.invalidate()
    }


    // MARK: - Recording

    func createNewRecordingURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let name = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: .withInternetDateTime)
        let file = documents.appendingPathComponent(name, isDirectory: false).appendingPathExtension("caf")

        //print("recording URL: \(file)")

        return file
    }

    func requestPermissionOrStartRecording() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                guard granted == true else {
                    print("We need microphone access")
                    return
                }

                print("Recording permission has been granted!")
                // NOTE: Invite the user to tap record again, since we just interrupted them, and they may not have been ready to record
            }
        case .denied:
            print("Microphone access has been blocked.")

//            let alertController = UIAlertController(title: "Microphone Access Denied", message: "Please allow this app to access your Microphone.", preferredStyle: .alert)
//
//            alertController.addAction(UIAlertAction(title: "Open Settings", style: .default) { (_) in
//                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//            })
//
//            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//
//            present(alertController, animated: true, completion: nil)
        case .granted:
            startRecording()
        @unknown default:
            break
        }
    }

    func startRecording() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.record)
            try session.setActive(true, options: []) // can fail if on a phone call, for instance
        } catch {
            print("Cannot record audio: \(error)")
            return
        }

        recordingURL = createNewRecordingURL()

        let format = AVAudioFormat(standardFormatWithSampleRate: 44_100, channels: 1)!

        do {
            audioRecorder = try AVAudioRecorder(url: recordingURL!, format: format)
            audioRecorder?.delegate = self
            //audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            updateProperties()
            startTimer()
        } catch {
            preconditionFailure("The audio recorder could not be created with \(recordingURL!) and \(format): \(error)")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        updateProperties()
        cancelTimer()
    }

    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            requestPermissionOrStartRecording()
        }
    }


    // MARK: - Timer

    func startTimer() {
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 0.030, repeats: true) { [weak self] (_) in
            guard let self = self else { return }

            self.updateProperties()

//            if let audioRecorder = self.audioRecorder,
//                self.isRecording == true {
//
//                audioRecorder.updateMeters()
//                self.audioVisualizer.addValue(decibelValue: audioRecorder.averagePower(forChannel: 0))
//
//            }
        }
    }

    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
}


// MARK: - Delegate

extension AudioRecorder: AVAudioRecorderDelegate {

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if let recordingURL = recordingURL {
//            audioPlayer = try? AVAudioPlayer(contentsOf: recordingURL)
//        }
        audioRecorder = nil
        cancelTimer()
    }

    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        if let error = error {
            print("Audio Recorder error: \(error)")
        }
    }
}
