//
//  MSDBQueryBuild.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/8/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//
#import "MSDBQueryResponse.h"
#import "MSDatabaseManager.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSDBQueryBuild : NSObject {
    sqlite3_stmt* response;
}

@property (nonatomic,strong) NSString* currentQuery;
@property (nonatomic,strong) MSDBRESPONSEQUERY dbresponseBlock;
@property (nonatomic,strong) NSMutableArray* resultFields;

-(void)executeQuery:(sqlite3*)db withParams:(NSArray*)array;

-(MSDBQueryResponse*)newResponseWithCode:(NSInteger)code;
@property BOOL useResponse;

@end



NS_ASSUME_NONNULL_END
