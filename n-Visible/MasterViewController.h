//
//  MasterViewController.h
//  n-Visible
//
//  Created by Gil Creque on 7/21/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MixFeed.h"
#import "AudioPlayer.h"

@interface MasterViewController : UITableViewController

@property (nonatomic) MixFeed *feed;
-(IBAction)pausePlaying;
-(IBAction)resumePlaying;
-(void)toggleToolbar;
@end

AudioPlayer *playerManager;
UIColor *redColor;

NSMutableArray *items;
UIBarButtonItem *playButton;
UIBarButtonItem *pauseButton;
UIBarButtonItem *nowPlayingLabelButton;
UIBarButtonItem *spacer;
//UIBarButtonItem *playPauseButton;
UIBarButtonItem *nowPlayingImageButton;