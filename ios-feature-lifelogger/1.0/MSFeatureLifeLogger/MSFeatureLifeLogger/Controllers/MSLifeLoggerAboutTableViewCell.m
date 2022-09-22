//
//  MSLifeLoggerAboutTableViewCell.m
//  LifeLogger
//
//  Created by John Mulvey on 8/30/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//
@import GoogleMobileAds;

#import <MSFeatureLifeLogger/MSFeatureLifeLogger.h>
#import "MSLifeLoggerAboutTableViewCell.h"

@implementation MSLifeLoggerAboutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)buttonMailSupport:(id)sender {
    
    NSURL* url = [NSURL URLWithString:@"mailto:lifeloggersupport@gmail.com"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onTapBannerButton:(id)sender {
}
@end
