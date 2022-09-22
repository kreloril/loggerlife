//
//  MSLifeLoggerLogEntryData.m
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/31/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSFeatureLifeLogger.h"
#import "MSLifeLoggerLogEntryData.h"

@implementation MSLifeLoggerLogEntryData


-(LogEntryDataType) logEntryType {
    NSString* datatype = [self stringForObject:@"logEntryType"];
    
    return (LogEntryDataType)[datatype integerValue];
}
-(NSString*)logEntryData {
    return [self stringForObject:@"logEntryData"];
}
-(NSString*)ownerid {
    return [self stringForObject:@"ownerid"];
}
+(MSLifeLoggerLogEntryData*)logEntry:(LogEntryDataType)type withLogData:(NSString*)data
{
    MSLifeLoggerLogEntryData* entry =  [[MSLifeLoggerLogEntryData alloc] initWithDict:@{@"logEntryType":[NSString stringWithFormat:@"%d",type],@"logEntryData":data}];
    
    return entry;
}
-(NSString*) objid {
    return [self stringForObject:@"id"];
}
@end
