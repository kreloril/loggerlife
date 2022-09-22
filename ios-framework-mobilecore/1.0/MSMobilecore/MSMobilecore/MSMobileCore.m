//
//  MSMobileCore.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/1/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import "MSMobilecore.h"


@interface MSMobileCore()



@end

@implementation MSMobileCore

+(MSMobileCore*) instance {
    static MSMobileCore* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MSMobileCore alloc]  init];
        instance.dbManager = [[MSDatabaseManager alloc] init];
        
        // [MSLogger log:@"MSMobileCore started"];
    });
    
    return instance;
}
-(void)startMobileCore {
    
    if (self.dbManager) {
        [self.dbManager loadService:self.coreResourceDelegate.databaseInfoFilePath];
        [self.dbManager openDBEngine:self.coreResourceDelegate.persistanceDatabaseName];
    }
    
    
}

@end
