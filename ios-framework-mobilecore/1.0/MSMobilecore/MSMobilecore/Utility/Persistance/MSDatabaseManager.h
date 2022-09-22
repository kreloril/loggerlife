//
//  MSDatabaseManager.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/8/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSDBQueryResponse.h"

#import <sqlite3.h>

#define ERROR_DBNOT_FOUND @"DBQuery Engine Unable to find service."

#define ERROR_DB_AMBIGUIS @"DBQuery for service contains multiple entries."
#define ERROR_DB_QUERY_INDEX_ERROR @"DBQuery index > available"

#define ERROR_DBNOT_FOUND_ID   (-1)
#define ERROR_DB_AMBIGUIS_ID   (-2)
#define ERROR_DB_QUERY_INDEX_ERROR_ID (-3)

typedef enum {
    
    DB_QUERY_CREATE,
    DB_QUERY_SELECT,
    DB_QUERY_DELETE,
    DB_QUERY_UPDATE,
    DB_QUERY_INSERT,
    DB_QUERY_ALTER
    
} MSDatabaseQueryType;

typedef void (^MSDBRESPONSEQUERY)(MSDBQueryResponse* _Nullable query, NSError* _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface MSDatabaseManager : MSObjectStack {
    sqlite3* activeDatabase;
}

@property (nonatomic,strong) NSMutableArray* databaseServices;
@property NSInteger dbCountingSync;

-(void)executeQuery:(MSDatabaseQueryType) queryType withArgs:(nullable NSArray*)argarray withName:(NSString*)queryname withQueryIndex:(NSInteger)index onCompletion:(nullable MSDBRESPONSEQUERY)response;

-(void)loadService:(NSString*)fileName;
-(void)openDBEngine:(NSString*)dbpath;
-(void)closeDBEngine;
-(void)removeDatabase;


@property (nonatomic) NSString* encryptionKey;

@end

NS_ASSUME_NONNULL_END
