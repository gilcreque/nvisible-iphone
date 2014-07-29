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

@interface MasterViewController () {
    
}
@end

@implementation MasterViewController

-(void)viewDidAppear:(BOOL)animated
{

    self.tableView.backgroundColor = [UIColor colorWithRed:255/255.0f green:1/255.0f blue:0/255.0f alpha:1.0f];
    
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
}

@end