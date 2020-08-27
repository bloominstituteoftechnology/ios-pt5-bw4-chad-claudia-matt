//
//  Transcriber.h
//  Transcribe
//
//  Created by Chad Parker on 8/25/20.
//  Copyright © 2020 Chad-Claudia-Matt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Transcriber : NSObject

+ (void)requestTranscriptionPermissions:(void (^)(BOOL authorized))completion;
+ (void)transcribeAudioURL:(NSURL *)audioURL completion:(void (^)(NSString *text))completion;

@end

NS_ASSUME_NONNULL_END
