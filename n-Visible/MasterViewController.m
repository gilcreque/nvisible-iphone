//
//  MasterViewController.m
//  n-Visible
//
//  Created by Gil Creque on 7/21/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MixTableViewCell.h"
#import "JSONModelLib.h"
#import "MixFeed.h"
#import "MixModel.h"
#import "HUD.h"
#import "AudioPlayer.h"
#import "UIImage+Resize.h" 

@interface MasterViewController () {
    
}
@end

@implementation MasterViewController {
    
}

-(IBAction)pausePlaying
{
    NSLog(@"pause tap");
    [playerManager pause];
//    [items removeLastObject];
//    [items addObject:playButton];
//    [self setToolbarItems:items animated:YES];
//    self.navigationController.toolbarHidden = YES;
//    self.navigationController.toolbarHidden = NO;
    [self toggleToolbar];
}

-(IBAction)resumePlaying
{
    NSLog(@"resume tap");
    [playerManager resume];
//    [items removeLastObject];
//    [items addObject:pauseButton];
//    [self setToolbarItems:items];
//    self.navigationController.toolbarHidden = YES;
//    self.navigationController.toolbarHidden = NO;
    [self toggleToolbar];
}

-(void)toggleToolbar
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UIImage *nowPlayingImage = [playerManager.currentSong.mixImage resizedImageToFitInSize:CGSizeMake(44, 44) scaleIfSmaller:NO];
    UIButton *npImageButton = [[UIButton alloc] init];
    npImageButton.bounds = CGRectMake(0, 0, nowPlayingImage.size.width, nowPlayingImage.size.height);
    [npImageButton setImage:nowPlayingImage forState:UIControlStateNormal];
    nowPlayingImageButton = [[UIBarButtonItem alloc] initWithCustomView:npImageButton];
    [items addObject:nowPlayingImageButton];
    
    spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:spacer];
    
    UILabel *nowPlayingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 11.0f, 200, 41.0f)];
    nowPlayingLabel.font = [UIFont fontWithName:@"Avenir-Book" size:10];
    nowPlayingLabel.numberOfLines = 2;
    nowPlayingLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nowPlayingLabel.text = [NSString stringWithFormat:@"%@\r%@", playerManager.currentSong.mixDJ, playerManager.currentSong.mixTitle];
    nowPlayingLabelButton = [[UIBarButtonItem alloc] initWithCustomView:nowPlayingLabel];
    [items addObject:nowPlayingLabelButton];
    
    [items addObject:spacer];
    
    pauseButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(pausePlaying)];
    [pauseButton setTintColor:redColor];
    
    playButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(resumePlaying)];
    [playButton setTintColor:redColor];
    
    switch (playerManager.audioPlayer.state) {
        case STKAudioPlayerStatePlaying:
        case STKAudioPlayerStateBuffering:
            //NSLog(@"Pause Button showing, State=%u", playerManager.audioPlayer.state);
            [items addObject:pauseButton];
            break;
        case STKAudioPlayerStatePaused:
            //NSLog(@"Play Button showing, State=%u", playerManager.audioPlayer.state);
            [items addObject:playButton];
            break;
        default:
            //NSLog(@"Default, State=%u", playerManager.audioPlayer.state);
            break;
    }
    
    [self setToolbarItems:items animated:YES];
    
    if (playerManager.audioPlayer.state == STKAudioPlayerStatePaused || playerManager.audioPlayer.state == STKAudioPlayerStatePlaying)
    {
        self.navigationController.toolbarHidden = NO;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    playerManager = [AudioPlayer sharedAudioPlayer];
    redColor = [UIColor colorWithRed:255/255.0f green:1/255.0f blue:0/255.0f alpha:1.0f];
    [self.navigationController setToolbarHidden:YES animated:NO];
    self.tableView.backgroundColor = redColor;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(toggleToolbar)
                                                 name:@"appDidBecomeActive"
                                               object:nil];
}


-(void)viewDidAppear:(BOOL)animated
{
    if (self.feed == nil)
    {
        //show loader view
        [HUD showUIBlockingIndicatorWithText:@"Fetching Mixes"];
        
        //fetch the feed
        self.feed = [[MixFeed alloc] initFromURLWithString:@"http://n-visible.com/mixesjson.php"
                                             completion:^(JSONModel *model, JSONModelError *err) {
                                                 
                                                 //hide the loader view
                                                 [HUD hideUIBlockingIndicator];
                                                 
                                                 //json fetched
                                                 //NSLog(@"feed results: %@\n", _feed.mixes);
                                                 NSLog(@"Feed fetched");
                                                                                              
                                                 //reload the table view
                                                 [self.tableView reloadData];
                                             }];
    }
    
    [self toggleToolbar];
}

#pragma mark - table methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Feed count: %@\n", [NSString stringWithFormat:@"%lu", (unsigned long)self.feed.mixes.count]);
    return self.feed.mixes.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MixModel* mix = self.feed.mixes[indexPath.row];
    
    MixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Black" size:16];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",
                           mix.mixTitle
                           ];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Book" size:14];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",
                                mix.mixDJ
                                ];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

//    [self performSegueWithIdentifier:@"segueDVC" sender:self];

//    MixModel *mix = _feed.mixes[indexPath.row];
//    
//    
//    DetailViewController *detailController = [[DetailViewController alloc] init];
//    detailController.detailItem = mix;
//    [[self navigationController] pushViewController:detailController animated:YES];
//    
//    NSString *message = [NSString stringWithFormat:@"%@ - %@",
//                         mix.mixDJ, mix.mixTitle
//                         ];
//    
//    [HUD showTimedAlertWithTitle:@"Mix details" text:message withTimeout:5];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"Row number: %i" , self.tableView.indexPathForSelectedRow.row);
    DetailViewController *detailController = segue.destinationViewController;
    MixModel *mixDVC = self.feed.mixes [self.tableView.indexPathForSelectedRow.row];
    //NSLog(@"dvc mix : %@", mixDVC.mixTitle);
    detailController.detailItem = mixDVC;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = redColor;
}

@end