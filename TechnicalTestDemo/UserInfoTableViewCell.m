//
//  UserInfoTableViewCell.m
//  TechnicalTestDemo
//
//  Created by Chandan Chavan on 23/06/16.
//  Copyright © 2016 Chandan Chavan. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _userImgView.layer.cornerRadius = 30;
    _userImgView.layer.borderWidth = 2;
    _userImgView.layer.borderColor = [UIColor blackColor].CGColor;
    _userImgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
