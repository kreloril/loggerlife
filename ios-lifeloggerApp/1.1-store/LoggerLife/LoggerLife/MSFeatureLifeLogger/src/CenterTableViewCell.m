//
//  CenterTableViewCell.m
//  LifeLogger
//
//  Created by John Mulvey on 2/25/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#import "CenterTableViewCell.h"

@implementation CenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.viewCellContent.layer.cornerRadius = 10.0;
    self.viewCellContent.clipsToBounds = NO;
    self.textLogLabel.text = @"";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
