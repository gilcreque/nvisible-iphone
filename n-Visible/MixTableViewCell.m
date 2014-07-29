//
//  MixTableViewCell.m
//  n-Visible
//
//  Created by Gil Creque on 7/21/14.
//  Copyright (c) 2014 n-Visible.com. All rights reserved.
//

#import "MixTableViewCell.h"

@implementation MixTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0,0,150,180);
    self.imageView.bounds = CGRectMake(0, 0, 150, 180);
    self.textLabel.frame = CGRectMake(25, 0, 200, 40);   //change this to your needed
    self.detailTextLabel.frame = CGRectMake(25, 40, 200, 40);
}
@end
