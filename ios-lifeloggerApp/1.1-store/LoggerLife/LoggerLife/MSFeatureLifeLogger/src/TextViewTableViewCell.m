//
//  TextViewTableViewCell.m
//  LifeLogger
//
//  Created by John Mulvey on 1/8/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#import "TextViewTableViewCell.h"

@implementation TextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.textColor = [UIColor blackColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}/*
+(UINib*)nib {
    
    return [UINib nibWithNibName:@"TextViewTableViewCell" bundle:nil];
}*/
@end
