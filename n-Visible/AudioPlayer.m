//
//  AudioPlayer.m
//  n-Visible
//
//  Created by Gil Creque on 7/28/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//
//  Based on Singleton example here http://www.galloway.me.uk/tutorials/singleton-classes/

#import "AudioPlayer.h"
#import "STKAudioPlayer.h"
#import "STKAutoRecoveringHTTPDataSource.h"


@implementation AudioPlayer

+ (id)sharedAudioPlayer
{
    static AudioPlayer *sharedAudioPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAudioPlayer = [[self alloc] init];
    });
    return sharedAudioPlayer;
}

- (id)init {
    if (self = [super init]) {
        _audioPlayer = [[STKAudioPlayer alloc] init];
        _audioPlayerIsPlaying = NO;
    }
    return self;
}

- (void)playMixURL:(NSString*)mixURL
{
    if (self.audioPlayerIsPlaying)
    {
        [self.audioPlayer stop];
    }
    
    NSLog(@"Song URL : %@", mixURL);
    
    [self.audioPlayer play:mixURL];
    self.audioPlayerIsPlaying = true;
}

@end
