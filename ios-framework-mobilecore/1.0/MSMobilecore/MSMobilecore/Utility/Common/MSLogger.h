//
//  MSLogger.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/5/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSLogger : NSObject
+(void) log:(NSString*)format, ...;
+(NSString*) log;
+(NSMutableArray*) logs;
@end

NS_ASSUME_NONNULL_END
