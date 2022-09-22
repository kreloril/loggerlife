//
//  MSLifeLoggerUserSettings.h
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 2/27/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//
NS_ASSUME_NONNULL_BEGIN

#define MSLifeLoggerSettingLastCatagory     @"lastCatagory"
#define MSHasCreatedInitialCatagories       @"hasCreatedInitialCatagories"
#define MSHasBannerAdsDisabled              @"hasBannerAdsDisabled"
@interface MSLifeLoggerUserSettings : MSObjectStack
@property (readonly) NSInteger lastCatagorySelectedIndex;
@property (readonly) bool hasCreatedInitialCatagories;
@property (readonly) bool hasBannerAdsDisabled;

-(void)toggleBannerAds;

@end

NS_ASSUME_NONNULL_END
