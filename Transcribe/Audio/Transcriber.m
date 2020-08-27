//
//  Transcriber.m
//  Transcribe
//
//  Created by Chad Parker on 8/25/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

#import "Transcriber.h"
#import <Speech/Speech.h>

@implementation Transcriber

+ (void)requestTranscriptionPermissions:(void (^)(BOOL authorized))completion
{
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(status == SFSpeechRecognizerAuthorizationStatusAuthorized);
        });
    }];
}

+ (void)transcribeAudioURL:(NSURL *)audioURL completion:(void (^)(NSString *text))completion
{
    SFSpeechRecognizer *recognizer = [[SFSpeechRecognizer alloc] init];
    SFSpeechURLRecognitionRequest * request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:audioURL];

    [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (!result) {
            NSLog(@"Recognition error: %@", error);
            return;
        }

        if (result.isFinal) {
            completion(result.bestTranscription.formattedString);
        }
    }];
}

@end
