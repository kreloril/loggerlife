//
//  MSDBQueryBuild.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/8/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSLogger.h"
#import "MSDBQueryBuild.h"

@implementation MSDBQueryBuild
-(void)executeQuery:(sqlite3*)db withParams:(NSArray*)array {
    
    
    if (db == nil || self.currentQuery == nil || [self.currentQuery isKindOfClass:[NSNull class]]) {
        self.dbresponseBlock([self newResponseWithCode:-1],nil);
        return;
    }
    
    if (array != nil) {
        
        for (int ir = 0; ir < [array count];ir++ ) {
            
            NSString* arg0 = [array objectAtIndex:ir];
            NSString* searchString = [NSString stringWithFormat:@"{$%d}",ir+1];
            self.currentQuery = [self.currentQuery stringByReplacingOccurrencesOfString:searchString withString:arg0];
            
        }
        
    }
    
    const char * errMsg=nil;
    NSInteger dbresult = 0;
#if TARGET_OS_SIMULATOR
     NSLog(@"query string = %@",self.currentQuery);
#endif
    if (self.currentQuery == nil ||  self.currentQuery.length == 0 )
        return;
    
    if (self.useResponse == false) {
        
        dbresult = sqlite3_exec(db, [self.currentQuery UTF8String] ,NULL,NULL, (char**)&errMsg);
        
        if (errMsg != nil  && strlen(errMsg) > 0) {
            NSLog(@"Error Executing Query %@, error = %s",self.currentQuery,errMsg);
        }
        
    } else {
        
        // [ Logger log:@"query string = %@",self.currentQuery];
        
        
        dbresult = sqlite3_prepare_v2(db, [self.currentQuery UTF8String], -1, &response,&errMsg);
        
        
        if (errMsg != nil && strlen(errMsg) > 0) {
            
            [MSLogger log:@"Error Executing Query %@, error = %s",self.currentQuery,errMsg];
        }
        
        self.resultFields = [[NSMutableArray alloc] init];
        
        if (dbresult == SQLITE_OK) {
            
            while (sqlite3_step(response) != SQLITE_DONE) {
                
                NSMutableDictionary* dictResponse = [[NSMutableDictionary alloc] init];
                
                
                NSInteger columnCount = sqlite3_column_count(response);
                
                
                for (int i = 0; i < columnCount;i++) {
                    NSString* coloumnName  = [[NSString alloc] initWithUTF8String: sqlite3_column_name(response, i)];
                    
                    
                    char* columnDataRaw = (char*)sqlite3_column_text(response, i);
                    
                    if (columnDataRaw != NULL) {
                        
                        NSString* columnData = [[NSString alloc] initWithUTF8String:columnDataRaw];
                        
                        [dictResponse setObject:columnData forKey:coloumnName];
                        
                    } else {
                        dictResponse = nil;
                        break;
                    }
                    
                }
                
                if (dictResponse != nil)
                    [self.resultFields addObject:dictResponse];
            }
            
            
        }
        
        
        sqlite3_finalize(response);
        response =nil;
    }
    
    if (dbresult == SQLITE_OK)
        self.dbresponseBlock([self newResponseWithCode:0],nil);
    else {
        self.dbresponseBlock([self newResponseWithCode:-2],nil);
        
    }
}

-(MSDBQueryResponse*)newResponseWithCode:(NSInteger)code {
    
    MSDBQueryResponse* responseQuery = [MSDBQueryResponse new];
    responseQuery.resultCode = code;
    responseQuery.arrayResults =  self.resultFields != nil  ? [[NSMutableArray alloc] initWithArray:self.resultFields] : nil;
    return responseQuery;
}@end
