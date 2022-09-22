//
//  MSLifeLoggerSortingIndex.m
//  LoggerLife
//
//  Created by John Mulvey on 8/8/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//

#import "MSLifeLoggerSortingIndex.h"

@implementation MSLifeLoggerSortingIndex

-(id) init {
    self = [super init];
    self.entryLogs = [[NSMutableArray alloc] init];
    return self;
}

@end
