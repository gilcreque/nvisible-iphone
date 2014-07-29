//
//  MixModel.h
//  n-Visible
//
//  Created by Gil Creque on 7/21/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//

#import "JSONModel.h"
#import <UIKit/UIKit.h>

@protocol MixModel @end

@interface MixModel : JSONModel

@property (strong, nonatomic) NSString *mixName;
@property (strong, nonatomic) NSString *mixDate;
@property (strong, nonatomic) NSString *mixDJ;
@property (strong, nonatomic) NSString *mixTitle;
@property (strong, nonatomic) NSString *mixURL;
@property (strong, nonatomic) NSString *mixImageURL;
@property (strong, nonatomic) UIImage<Ignore> *mixImage;
@property (strong, nonatomic) NSURL<Ignore> *mixURLConv;
@property (strong, nonatomic) NSDate<Ignore> *mixDateConv;

@end
