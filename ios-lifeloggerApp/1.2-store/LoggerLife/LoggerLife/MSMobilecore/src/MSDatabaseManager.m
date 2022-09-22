//
//  MSDatabaseManager.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/8/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import "MSMobileCore.h"
#import "MSDBQueryBuild.h"
#import "MSDatabaseService.h"
#import "MSDatabaseManager.h"

@interface MSDatabaseManager ()

@property (nonatomic,strong) NSMutableArray* arrayQueryQueue;
@property BOOL tablesCreatedThisSession;
@property (nonatomic,strong) NSString* dbName;
@end

@implementation MSDatabaseManager
-(void)loadService:(NSString*)fileName; {
    

    
    NSAssert(fileName.length != 0, @"DatabaseManager %@ loadService: service name cannot be nil or empty", NSStringFromClass([self class]));
    
    self.databaseServices = [[NSMutableArray alloc] init];
    
    
    NSDictionary* dictService = [[NSDictionary alloc] initWithContentsOfFile:fileName];
    NSAssert(dictService != nil, @"DatabaseManager %@ loadService: service %@ not found", NSStringFromClass([self class]), fileName);
    
    NSDictionary* serviceApi = [dictService objectForKey:@"dbService"];
    NSAssert(serviceApi != nil, @"%@ loadService: service %@ missing api key", NSStringFromClass([self class]), fileName);
    
    for (NSDictionary* newservice in serviceApi) {
        MSDatabaseService* serviceTemp = [[MSDatabaseService alloc] initWithDict:newservice];
        [self.databaseServices addObject:serviceTemp];
    }
    self.dbCountingSync = 0;
    activeDatabase = nil;
}

-(void)executeQuery:(MSDatabaseQueryType) queryType withArgs:(nullable NSArray*)argarray withName:(NSString*)queryname withQueryIndex:(NSInteger)index onCompletion:(nullable MSDBRESPONSEQUERY)response {
    
    
    
    
    NSPredicate* predService = [NSPredicate predicateWithFormat:@"self.dbModelClass = %@",queryname];
    NSArray* arrayObject = [self.databaseServices filteredArrayUsingPredicate:predService];
    
    if (arrayObject.count == 0) {
        NSError* error = [NSError errorWithDomain:ERROR_DBNOT_FOUND code:ERROR_DBNOT_FOUND_ID userInfo:nil];
        response(nil,error);
        return;
    } else if (arrayObject.count > 2) {
        NSError* error = [NSError errorWithDomain:ERROR_DB_AMBIGUIS code:ERROR_DB_AMBIGUIS_ID userInfo:nil];
        response(nil,error);
    }
    
    
    MSDatabaseService* service = (MSDatabaseService*)[arrayObject objectAtIndex:0];
    
    MSDBQueryBuild* dBuild = [[MSDBQueryBuild alloc] init];
    
    NSArray* dbquerys = [service arrayForDBType:queryType];
    
    if (index > dbquerys.count) {
        response(nil,[NSError errorWithDomain:ERROR_DB_QUERY_INDEX_ERROR code:ERROR_DB_QUERY_INDEX_ERROR_ID userInfo:nil]);
        return;
    }
    
    dBuild.currentQuery = (NSString*)[dbquerys objectAtIndex:index];
    dBuild.dbresponseBlock = ^(MSDBQueryResponse* query, NSError* error) {
        
        self.dbCountingSync--;
        
        if (self.dbCountingSync <= 0) {
            self.dbCountingSync = 0;
            [self closeDBEngine];
        }
        
        if (response) {
            response(query,error);
           
        }
    };
    
    dBuild.useResponse = queryType == DB_QUERY_SELECT ? true : false;
    
    
    
    @synchronized(self) {
        
        if (self.dbCountingSync <= 0) {
            self.dbCountingSync = 1;
            [self openDBEngine:self.dbName];
        }
        self.dbCountingSync++;
        
        [dBuild executeQuery:activeDatabase withParams:argarray];
    }
}

-(void)openDBEngine:(NSString*)dbpath {
    
   // NSString* dbfilename = [MSMobileCore instance].coreResourceDelegate.persistanceDatabaseName;
    
    NSAssert(dbpath.length != 0, @"DatabaseManager %@ openDBEngine: service name cannot be nil or empty", NSStringFromClass([self class]));
    
    if (activeDatabase != nil) {
        return;
    }
    
    
    self.dbName = dbpath;
    
  //  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   // NSString *documentsDirectory = [paths objectAtIndex:0];
   // NSString *path = [documentsDirectory stringByAppendingPathComponent:dbfilename];
    
    
    NSFileManager* fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:dbpath])
        self. tablesCreatedThisSession = false;
    
    NSLog(@"path for db = %@",dbpath);
    
    if (sqlite3_open_v2([dbpath cStringUsingEncoding:NSUTF8StringEncoding], &activeDatabase,SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE,NULL) == SQLITE_OK) {
        
        if (self.tablesCreatedThisSession == false)
            [self createAllDBTables];
        
        return;
        
    }
    
    //  NSLog(@"database failed to open");
    
}
-(void)closeDBEngine {
    
    
    if (activeDatabase != nil) {
        sqlite3_close(activeDatabase);
        activeDatabase = nil;
        self.dbCountingSync = 0;
    }
    
}
-(void)removeDatabase {
    
    [self closeDBEngine];
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:self.dbName error:nil];

    self.tablesCreatedThisSession = false;
    self.dbCountingSync = 0;
    
    //[[MSMobileCore instance] openDBEngine:self.dbName];
   
}

-(NSString*)encryptionKey {
    
    NSString* key = @"nickisaretarddeletedhashkey";
    
    if ([[MSMobileCore instance].coreResourceDelegate respondsToSelector:@selector(dataBaseEncryptionKey)])
        key = [MSMobileCore instance].coreResourceDelegate.dataBaseEncryptionKey;
    
    return key;
}

-(void)createAllDBTables {
    
    self.tablesCreatedThisSession = true;
    
    //    NSLog(@"creating all dbTables");
    
    for (MSDatabaseService* dbservice in self.databaseServices) {
        
        [self executeQuery:DB_QUERY_CREATE withArgs:nil withName:dbservice.dbModelClass withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
            
            NSInteger alterCount = [dbservice arrayForDBType:DB_QUERY_ALTER].count;
            
            if (alterCount > 0 ) {
                for (NSInteger acount = 0; acount < alterCount; acount++) {
                    
                    [self executeQuery:DB_QUERY_ALTER withArgs:nil withName:dbservice.dbModelClass withQueryIndex:(NSInteger)acount onCompletion:nil];
                }
            }
        }];
        
        
    }
    
    
}@end
