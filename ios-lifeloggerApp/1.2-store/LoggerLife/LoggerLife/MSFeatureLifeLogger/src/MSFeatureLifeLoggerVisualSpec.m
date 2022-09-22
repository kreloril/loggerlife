//
//  MSFeatureLifeLoggerVisualSpec.m
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/29/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import "MSFeatureLifeLogger.h"
#import "UIColor+Hex.h"
@implementation MSFeatureLifeLoggerVisualSpec
+(MSFeatureLifeLoggerVisualSpec*) instance {
    static MSFeatureLifeLoggerVisualSpec* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MSFeatureLifeLoggerVisualSpec alloc]  init];
        [MSLogger log:@"MSFeatureLifeLoggerVisualSpec started"];
        
    });
    
    return instance;
}
+(UIColor*)colorForHex:(NSString*)hex {
    return [UIColor colorWithCSS:hex];
}

+(UIColor*)backgroundViewColor {
    return [self colorForHex:@"#D0D0D0"];
}
+(UIColor*)navigationBarColor {
   // return [UIColor lightGrayColor];
    
    return [self colorForHex:@"#0D2955"];
}
@end
