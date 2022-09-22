//
//  MSLifeLoggerLogEntry.h
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/31/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

typedef enum {
    
    MSLifeLoggerEntryStateNone=0,
    MSLifeLoggerEntryStateFlagged,
    MSLifeLoggerEntryLogStateUnFlagged
    
} MSLifeLoggerEntryLogState;



NS_ASSUME_NONNULL_BEGIN
@class MSLifeLoggerLogEntryData;
@interface MSLifeLoggerLogEntry : MSObjectStack


@property (strong,nonatomic) NSMutableArray<MSLifeLoggerLogEntryData*>* entryData;

@property (readonly) NSString* objid;
@property (readonly) NSString* ownerid;
@property (readonly) NSString* timestamp;
@property (readonly) NSString* rawdata;
@property (readonly) bool hasImage;

-(void)addLogEntryData:(MSLifeLoggerLogEntryData*)entryData;
-(void)setLogEntryState:(MSLifeLoggerEntryLogState)state;
-(MSLifeLoggerEntryLogState)entryState;
-(MSObjectStack*)data;
@end

NS_ASSUME_NONNULL_END
