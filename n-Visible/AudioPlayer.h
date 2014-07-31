//
//  AudioPlayer.h
//  n-Visible
//
//  Created by Gil Creque on 7/28/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STKAudioPlayer.h"
#import "MixModel.h"

@interface AudioPlayer : NSObject
//{
//    STKAudioPlayer *audioPlayer;
//    bool audioPlayerIsPlaying;
//}

@property (strong, nonatomic) STKAudioPlayer* audioPlayer;

+ (id) sharedAudioPlayer;
- (void)playMixURL:(NSString*)mixURL;
- (void)setupNowPlayingInfoCenter:(MixModel*)currentSong;
- (void)pause;
- (void)resume;
@end
