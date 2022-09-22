//
//  MSLifeLoggerLogEntry.m
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/31/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSFeatureLifeLogger.h"
#import "MSLifeLoggerLogEntry.h"

@interface MSLifeLoggerLogEntry()
@property (strong,nonatomic) MSObjectStack* _data;
@end

@implementation MSLifeLoggerLogEntry

-(instancetype)initWithDict:(NSDictionary *)data {
    self = [super initWithDict:data];
    
    NSString* dataentry = self.rawdata;
    
    if (dataentry.length > 0) {
        self._data = [[MSObjectStack alloc] initWithJsonString:dataentry];
    } else {

        self._data = [[MSObjectStack alloc] init];
        
    }
    return self;
}
-(instancetype)init {
    self = [super init];
    
    if (self)
    {
        self._data = [[MSObjectStack alloc] init];
    }
    
    return self;
}
-(MSObjectStack*)data {
    return self._data;
}
-(NSString*) objid {
    return [self stringForObject:@"id"];
}
-(NSString*) ownerid {
    return [self stringForObject:@"ownerid"];
}

-(NSString*) timestamp {
     NSString* timestamp = [self stringForObject:@"timestamp"];
    if (!timestamp) {
        NSTimeInterval time = [[NSDate alloc] init].timeIntervalSince1970;
        NSNumber* timeval = [NSNumber numberWithDouble:time];
        timestamp = [timeval stringValue];
        [self setObject:timestamp key:@"timestamp"];
    }
    return timestamp;
}
-(NSString*)rawdata {
    return [self stringForObject:@"data"];
}
-(void)addLogEntryData:(MSLifeLoggerLogEntryData*)entryData {
   
    if (!self.entryData)
        self.entryData = [NSMutableArray new];
    
    [self.entryData addObject:entryData];
}
-(bool) hasImage {
    return false;
}
-(void)setLogEntryState:(MSLifeLoggerEntryLogState)state {
    [self.data setObject:[@(state) stringValue] key:@"logentrystate"];
}
-(MSLifeLoggerEntryLogState)entryState {
    NSString* value = [self.data getObject:@"logentrystate"];
    
    if (!value) {
        [self setLogEntryState:MSLifeLoggerEntryStateNone];
        return MSLifeLoggerEntryStateNone;
    }
    
    return (MSLifeLoggerEntryLogState)value.integerValue;
}

@end
