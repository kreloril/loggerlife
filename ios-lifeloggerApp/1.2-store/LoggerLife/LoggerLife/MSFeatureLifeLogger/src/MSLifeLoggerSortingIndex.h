//
//  MSLifeLoggerSortingIndex.h
//  LoggerLife
//
//  Created by John Mulvey on 8/8/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSLifeLoggerSortingIndex : NSObject
@property (nonatomic,strong) NSString *headerString;
@property (nonatomic,strong) NSMutableArray *entryLogs;
@property (nonatomic,strong) NSString *sortingHeader;
@end

NS_ASSUME_NONNULL_END
