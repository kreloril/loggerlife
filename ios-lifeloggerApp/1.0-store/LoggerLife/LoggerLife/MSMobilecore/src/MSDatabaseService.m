//
//  MSDatabaseService.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/8/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSDatabaseManager.h"
#import "MSDatabaseService.h"

@implementation MSDatabaseService
-(NSString*) dbModelClass {
    return [self stringForObject:@"dbModelClass"];
}

-(NSString*) dbType {
    return [self stringForObject:@"dbType"];
}

-(NSString*) dbQueryCreate {
    return [self stringForObject:@"dbQueryCreate"];
}

-(NSArray*) dbFields {
    return [self arrayForObject:@"dbFields"];
}
-(NSArray*) dbQuerySelect {
    return [self arrayForObject:@"dbQuerySelect"];
}

-(NSArray*) dbQueryDelete {
    return [self arrayForObject:@"dbQueryDelete"];
}

-(NSArray*) dbQueryUpdate {
    return [self arrayForObject:@"dbQueryUpdate"];
}
-(NSArray*) dbQueryInsert {
    return [self arrayForObject:@"dbQueryInsert"];
}
-(NSArray*) dbQueryAlter {
    return [self arrayForObject:@"dbQueryAlter"];
}
-(NSArray*)arrayForDBType:(NSInteger)dbtype {
    
    NSArray* resultArray = nil;
    
    
    switch (dbtype) {
        case DB_QUERY_CREATE: {
            resultArray = @[self.dbQueryCreate];
            break;
        }
        case DB_QUERY_SELECT: {
            resultArray = self.dbQuerySelect;
            break;
        }
        case  DB_QUERY_DELETE: {
            resultArray = self.dbQueryDelete;
            break;
        }
        case DB_QUERY_UPDATE: {
            resultArray = self.dbQueryUpdate;
            break;
        }
        case DB_QUERY_INSERT: {
            resultArray = self.dbQueryInsert;
            break;
        }
        case DB_QUERY_ALTER: {
            resultArray = self.dbQueryAlter;
            break;
            
        }
            
    }
    
    return resultArray;
}@end
