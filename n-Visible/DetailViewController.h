//
//  DetailViewController.h
//  n-Visible
//
//  Created by Gil Creque on 7/21/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MixModel;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) MixModel *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *mixLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mixImage;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


@end

