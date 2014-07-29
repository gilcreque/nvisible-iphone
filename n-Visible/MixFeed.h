//
//  MixFeed.h
//  n-Visible
//
//  Created by Gil Creque on 7/21/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//


#import "JSONModel.h"
#import "MixModel.h"


@interface MixFeed : JSONModel

@property (strong, nonatomic) NSArray<MixModel>* mixes;

@end
