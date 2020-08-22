//
//  AudioController.swift
//  Transcribe
//
//  Created by Chad Parker on 8/18/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

import Foundation
import Speech

class AudioController: ObservableObject {

    @Published var isRecording = false
    @Published var errorString: String?

    private let audioEngine = AVAudioEngine()
    private var speechRecognizer = SFSpeechRecognizer()
    private var request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?

    private var outputFile = AVAudioFile()

    init() {
        getTranscribePermissions()
        guard SFSpeechRecognizer.authorizationStatus() == .authorized else { fatalError("Not authorized") }
    }

    func startRecording() {

        recognitionTask?.cancel()
        recognitionTask = nil

        let node = audioEngine.inputNode
        node.removeTap(onBus: 0)
        let recordingFormat = node.inputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.request.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            errorString = "Error: \(error.localizedDescription)"
            return
        }

        isRecording = true

        request.shouldReportPartialResults = true
        request.requiresOnDeviceRecognition = true

        recognitionTask = speechRecognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    let transcribedString = result.bestTranscription.formattedString
                    print(transcribedString)
                }
            }

            if error != nil {
                print("error: \(error!.localizedDescription)")
                self.audioEngine.stop()
                node.removeTap(onBus: 0)
                self.recognitionTask = nil
            }
        }
    }

    func initializeAudioEngine() {

        audioEngine.stop()
        audioEngine.reset()

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord)

            let ioBufferDuration = 128.0 / 44100.0

            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(ioBufferDuration)

        } catch {

            assertionFailure("AVAudioSession setup error: \(error)")
        }

        let fileUrl = URL(string: "a")! //URLFor("/NewRecording.caf")
        print(fileUrl)
        do {

            try outputFile = AVAudioFile(forWriting:  fileUrl, settings: audioEngine.mainMixerNode.outputFormat(forBus: 0).settings)
        }
        catch {

        }

        //let input = audioEngine.inputNode
        //let format = input.inputFormat(forBus: 0)

        try! audioEngine.start()
    }

    func startRecording2() {

        let mixer = audioEngine.mainMixerNode
        let format = mixer.outputFormat(forBus: 0)

        mixer.installTap(onBus: 0, bufferSize: 1024, format: format, block:
            { (buffer: AVAudioPCMBuffer!, time: AVAudioTime!) -> Void in

                print(NSString(string: "writing"))
                do{
                    try self.outputFile.write(from: buffer)
                }
                catch {
                    print(NSString(string: "Write failed"));
                }
        })
    }

    func stopRecording2() {

        audioEngine.mainMixerNode.removeTap(onBus: 0)
        audioEngine.stop()
        isRecording = false
    }

    func stopRecording() {
        audioEngine.stop()
        request.endAudio()
        isRecording = false
    }

    func cancelRecording() {
        audioEngine.stop()
        recognitionTask?.cancel()
        isRecording = false
    }

    func getTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("authorized")
                } else {
                    print("transcription permission was declined")
                }
            }
        }
    }

    func notesFromVideo() { // WWDC 19 Advances in Speech Recognition (6 minute video)
        // Recognizing pre-recorded audio

        guard let recognizer = SFSpeechRecognizer() else {
            fatalError("Speech recognition not supported for device's locale")
        }
        guard recognizer.isAvailable else {
            fatalError("Recognizer not available")
        }
        let request = SFSpeechURLRecognitionRequest(url: URL(string: "a")!)

        if recognizer.supportsOnDeviceRecognition {
            request.requiresOnDeviceRecognition = true
        }
    }

    func hackingWithSwiftOfflineVersion(url: URL) {
        guard let recognizer = SFSpeechRecognizer() else {
            fatalError("Speech recognition not supported for device's locale")
        }
        let request = SFSpeechURLRecognitionRequest(url: url)

        recognizer.recognitionTask(with: request) { result, error in
            guard let result = result else {
                fatalError("didn't get transcription back: \(error!)")
            }

            // may get an initial transcription back containing some or all of the text,
            // but it’s only considered final – i.e. as good as it gets – when the isFinal flag is true.
            if result.isFinal {
                print(result.bestTranscription.formattedString)
            }
        }
    }
}
