//
//  MSLifeLoggerUserSettings.m
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 2/27/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//


#import "MSFeatureLifeLogger.h"
#import "MSLifeLoggerUserSettings.h"

@implementation MSLifeLoggerUserSettings
-(id)init {
    self =  [super init];
    return self;
}
-(void)setObject:(id)object key:(NSString*)key {
    
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(id)getObject:(NSString*)key {
   NSString* idObject =  [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!idObject) {
        idObject = @"0";
        [self setObject:key key:idObject];
    }
    
    return idObject;
}
-(NSInteger)lastCatagorySelectedIndex {
    NSString* idObject = [self getObject:MSLifeLoggerSettingLastCatagory];
    
    return [idObject integerValue];
}
-(bool) hasCreatedInitialCatagories {
    NSString* idObject = [self getObject:MSHasCreatedInitialCatagories];

    return [idObject boolValue];
    
}
-(bool)hasBannerAdsDisabled {
    NSString* idObject = [self getObject:MSHasBannerAdsDisabled];
    return [idObject boolValue];
}

-(void)toggleBannerAds {
    bool banner = self.hasBannerAdsDisabled;
    
    if (banner)
        [self setObject:@"0" key:MSHasBannerAdsDisabled];
    else
        [self setObject:@"1" key:MSHasBannerAdsDisabled];
    
}

@end
