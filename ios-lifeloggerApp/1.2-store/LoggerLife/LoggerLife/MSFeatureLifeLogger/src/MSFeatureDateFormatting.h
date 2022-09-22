//
//  MSFeatureDateFormatting.h
//  LoggerLife
//
//  Created by John Mulvey on 8/8/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSFeatureDateFormatting : NSObject
+(NSString*)formattedTimeStamp:(NSString*)timestamp;
+(NSString*)formattedTime:(NSString*)timestamp;
+(NSString*)headerFormattedTime:(NSString*)timestampentry;
+(NSString*)headerSortingIndex:(NSString*)timestampentry;
+(NSTimeInterval)headerFormattedTimeInterval:(NSString*)timestampentry;
+(NSString*)shortDateFormat:(NSString*)date;
@end

NS_ASSUME_NONNULL_END
