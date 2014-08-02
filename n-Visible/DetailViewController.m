//
//  DetailViewController.m
//  n-Visible
//
//  Created by Gil Creque on 7/21/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//

#import "DetailViewController.h"
#import "MixModel.h"
#import "AudioPlayer.h"

@interface DetailViewController ()
- (IBAction)buttonPressed;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (IBAction)buttonPressed {
    AudioPlayer *playerManager = [AudioPlayer sharedAudioPlayer];
    [playerManager playMixURL:[self.detailItem.mixURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [playerManager setupNowPlayingInfoCenter:self.detailItem];
    [playerManager setCurrentSong:self.detailItem];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem)
    {
        self.mixTitleLabel.text = self.detailItem.mixTitle;
        self.mixDJLabel.text = self.detailItem.mixDJ;
        self.detailItem.mixImage = [UIImage imageWithData:
                                   [NSData dataWithContentsOfURL:
                                   [NSURL URLWithString:
                                   [self.detailItem.mixImageURL
                                   stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
        [self.mixImageView setImage:self.detailItem.mixImage];
        self.mixDateLabel.text = self.detailItem.mixDate;
    }
    
    
    
}

//- (void)playMix:(NSString *)iSongName {
//    // Define this constant for the key-value observation context.
//    //static const NSString *ItemStatusContext;
//    
//    NSString *aSongURL = [iSongName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"Song URL : %@", aSongURL);
//
//    NSURL *url = [NSURL URLWithString:aSongURL];
//    
//    AVPlayerItem *aPlayerItem = [AVPlayerItem playerItemWithURL:url];
//    //[aPlayerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
//    AVPlayer *anAudioStreamer = [[AVPlayer alloc] initWithPlayerItem:aPlayerItem];
//    [anAudioStreamer play];
//    
//    // Access Current Time
//    NSTimeInterval aCurrentTime = CMTimeGetSeconds(anAudioStreamer.currentTime);
//    
//    // Access Duration
//    NSTimeInterval aDuration = CMTimeGetSeconds(anAudioStreamer.currentItem.asset.duration);
//}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.toolbarHidden = YES;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end