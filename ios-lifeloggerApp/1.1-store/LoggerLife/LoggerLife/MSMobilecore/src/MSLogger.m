//
//  MSLogger.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/5/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import "MSMobileCore.h"
#import "MSMobileCoreResourceDelegate.h"
#import "MSLogger.h"

@implementation MSLogger
+(void) log:(NSString*)format, ... {
    // do not log messages for production builds
    
    
    // log to console as per usual
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
    
    va_start(args, format);
    NSString* message;
    // also store to buffer, to be accessed by debug view
    message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    if ([[MSMobileCore instance].coreResourceDelegate respondsToSelector:@selector(enableLogging)])
    {
        if (![MSMobileCore instance].coreResourceDelegate.enableLogging)
            return;
    }
    
    @synchronized ([self logs]) {
        
        [[self logs] addObject:message];
        
        NSInteger msg_count = (NSInteger)[self logs].count;
        
        if (msg_count > 400) {
            NSInteger startRange =( msg_count - 400 ) + 50;
            NSRange rangeremove = NSMakeRange(0, startRange);
            [[self logs] removeObjectsInRange:rangeremove];
            
        }
        
    }
    
}

+(NSMutableArray*) logs {
    static NSMutableArray* _logs = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _logs = [NSMutableArray array];
    });
    return _logs;
}

+(NSString*) log {
    NSMutableString* log = [NSMutableString new];
    
    
    
    // capture log information
    for (NSString* string in [self logs]) {
        [log appendFormat:@"%@\n", string];
    }
    return log;
}
@end
