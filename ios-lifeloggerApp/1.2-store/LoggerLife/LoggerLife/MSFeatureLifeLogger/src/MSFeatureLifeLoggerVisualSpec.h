//
//  MSFeatureLifeLoggerVisualSpec.h
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/29/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSFeatureLifeLoggerVisualSpec : NSObject
+(MSFeatureLifeLoggerVisualSpec*) instance;
+(UIColor*)colorForHex:(NSString*)hex;
+(UIColor*)backgroundViewColor;
+(UIColor*)navigationBarColor;
@end

NS_ASSUME_NONNULL_END
