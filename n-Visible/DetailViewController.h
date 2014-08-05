//
//  DetailViewController.h
//  n-Visible
//
//  Created by Gil Creque on 7/21/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MixModel;
@class AudioPlayer;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) MixModel *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *mixTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mixDJLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mixImageView;
@property (weak, nonatomic) IBOutlet UILabel *mixDateLabel;
@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *timeElapsed;
@property BOOL scrubbing;
@property NSTimer *timer;
@end

AudioPlayer *playerManager;
UIColor *redColor;

NSMutableArray *items;
UIBarButtonItem *playButton;
UIBarButtonItem *pauseButton;
UIBarButtonItem *resumeButton;
UIBarButtonItem *spacer;