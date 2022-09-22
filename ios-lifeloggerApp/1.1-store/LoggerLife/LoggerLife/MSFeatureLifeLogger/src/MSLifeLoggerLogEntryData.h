//
//  MSLifeLoggerLogEntryData.h
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/31/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

typedef enum {

    LogEntryDataTypeText = 0,
    LogEntryDataTypeVideo,
    LogEntryDataTypeAudio,
    LogEntryDataTypePicture
    
} LogEntryDataType;

NS_ASSUME_NONNULL_BEGIN

@interface MSLifeLoggerLogEntryData : MSObjectStack
@property (readonly) NSString* objid;
@property (readonly) LogEntryDataType logEntryType;
@property (readonly) NSString* logEntryData;
@property (readonly) NSString* ownerid;
+(MSLifeLoggerLogEntryData*)logEntry:(LogEntryDataType)type withLogData:(NSString*)data;

@end

NS_ASSUME_NONNULL_END
