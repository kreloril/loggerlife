//
//  MSLifeLoggerEditCatagoryTableViewCell.m
//  LifeLogger
//
//  Created by John Mulvey on 4/4/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//
#import "MSFeatureLifeLogger.h"
#import "MSLifeLoggerEditCatagoryTableViewCell.h"

@implementation MSLifeLoggerEditCatagoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.heightTextView.constant = 45;
    self.buttonDeleteCategory.layer.cornerRadius = 10;
    self.buttonDeleteCategory.clipsToBounds = NO;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
    // Configure the view for the selected state
}

- (IBAction)buttonEditCatagory:(id)sender {
    [self.textViewCatagoryName setEnabled:TRUE];
    [self.textViewCatagoryName becomeFirstResponder];
}
@end
