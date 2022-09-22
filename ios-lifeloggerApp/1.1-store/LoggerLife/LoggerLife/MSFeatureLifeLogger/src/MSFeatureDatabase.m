//
//  MSFeatureDatabase.m
//  LoggerLife
//
//  Created by John Mulvey on 8/9/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//

#import "MSFeatureLifeLogger.h"

@implementation MSFeatureDatabase

-(id)init {
    self = [super init];
    self.currentObjectData  = [[NSMutableArray alloc] init];
    return self;
}

-(void)initCatagories {
     __block NSInteger catagoryCount = 0;
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_SELECT withArgs:@[] withName:DATABASE_CATAGORIES withQueryIndex:1 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
       
        catagoryCount = [self processObjectCount:query withString:@"count(id)"];
        
    }];
    
    [[MSFeatureLifeLogger instance].userSettings setObject:@"1" key:MSHasCreatedInitialCatagories];
    
    NSArray* defaultCatagories = @[CATAGORY_DEFAULT_DAILY,CATAGORY_DEFAULT_JUNK,CATAGORY_DEFAULT_TRASH];
    
    for (int i = 0; i < defaultCatagories.count;i++) {
    
        NSString* name = defaultCatagories[i];
        
        if ([self findCatagory:name])
            continue;
        
        MSLifeLoggerCatagory* newCatgory = [[MSLifeLoggerCatagory alloc] initWithCatagoryName:name];
        
        [newCatgory.data setObject:[@(i) stringValue] key:CATAGORY_PROPERTY_SORTINGORDER];
      //  newCatgory.
        
        switch (i) {
            case 0:
            {
                 [newCatgory.data setObject:@"0" key:CATAGORY_PROPERTY_ALLOWDELETE];
            }
            break;
           
            case 1:
            {
                [newCatgory.data setObject:@"0" key:CATAGORY_PROPERTY_ALLOWDELETE];
            }
            break;
           
            case 2:
            {
                [newCatgory.data setObject:@"0" key:CATAGORY_PROPERTY_ALLOWREAD];
                [newCatgory.data setObject:@"999999" key:CATAGORY_PROPERTY_SORTINGORDER];
                [newCatgory.data setObject:@"0" key:CATAGORY_PROPERTY_ALLOWDELETE];
            }
            break;

  
        }
        
        [self insertLifeLoggerCatagory:newCatgory];
        
    }
    
}

-(NSInteger)processObjectCount:(MSDBQueryResponse*)query withString:(NSString*)ssumstring {
    
    NSInteger blockResult = 0;
    
    if (query.resultCode == 0 && [query.arrayResults count] > 0) {
        
        NSDictionary* dictIDCount = [query.arrayResults objectAtIndex:0];
        NSString* valueID = [dictIDCount objectForKey:ssumstring];
        blockResult = [valueID integerValue];
    }
    
    return blockResult;
}
-(NSArray*)arrayOfCatagories {
    
    __block NSMutableArray* returnArray = [NSMutableArray new];
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_SELECT withArgs:nil withName:DATABASE_CATAGORIES withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
        
        if (!error && query.arrayResults.count > 0) {
            
            for (NSDictionary* result in query.arrayResults) {
                
                MSLifeLoggerCatagory* cat = [[MSLifeLoggerCatagory alloc] initWithDict:result];
                
                [returnArray addObject:cat];
                
                
            }
            
        }
        
    }];
    
    [returnArray sortUsingComparator:^NSComparisonResult(MSLifeLoggerCatagory* obj1, MSLifeLoggerCatagory* obj2) {
        
        return [obj2 compare:obj1];
        
    }];
    
    return returnArray;
    
}

-(void)updateLifeloggerCatagory:(MSLifeLoggerCatagory*)catagory {
    
    NSString* entryJson = [catagory.data dataWithJSONObject];
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_UPDATE withArgs:@[catagory.name,entryJson,catagory.catid] withName:DATABASE_CATAGORIES withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
        
        
    }];
    
}

-(void)insertLifeLoggerCatagory:(MSLifeLoggerCatagory*)catagory {
    
    
     NSString* entryJson = [catagory.data dataWithJSONObject];
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_INSERT withArgs:@[catagory.name,entryJson] withName:DATABASE_CATAGORIES withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
       
        if (error)
            NSLog(@"error = %@",error);
    }];
    
}
-(MSLifeLoggerCatagory*)findCatagory:(NSString*)name {
    
    __block MSLifeLoggerCatagory* searchedCat=nil;
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_SELECT withArgs:@[name] withName:DATABASE_CATAGORIES withQueryIndex:2 onCompletion:^(MSDBQueryResponse * _Nullable query, NSError * _Nullable error) {
        
        if (query.arrayResults.count > 0) {
            
            for (NSDictionary* data in query.arrayResults) {
                MSLifeLoggerCatagory* cat = [[MSLifeLoggerCatagory alloc] initWithDict:data];
                if ([searchedCat.name caseInsensitiveCompare:name] == NSOrderedSame) {
                    searchedCat = cat;
                    break;
                }
            }
            
        }
        
    }];
    
    return searchedCat;
}

-(void)removeAllMessagesFromCatagory:(MSLifeLoggerCatagory*)catagory {
    
    NSMutableArray* entryids = NSMutableArray.new;
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_SELECT withArgs:@[catagory.catid] withName:DATABASE_LOGENTRY withQueryIndex:2 onCompletion:^(MSDBQueryResponse * _Nullable query, NSError * _Nullable error) {
       
        if (query.arrayResults.count > 0) {
            
            for (NSDictionary* data in query.arrayResults) {
                [entryids addObject:data[@"ownerid"]];
            }
            
        }
        
    }];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    queue.qualityOfService = NSQualityOfServiceBackground;
  
    
    for (NSString* ownerids in entryids) {
        
    
        [queue addOperationWithBlock:^{
            
            [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_DELETE withArgs:@[ownerids] withName:DATABASE_LOGENTRY withQueryIndex:0 onCompletion:nil];
        
            [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_DELETE withArgs:@[ownerids] withName:DATABASE_LOGENTRY_DATA withQueryIndex:1 onCompletion:nil];
            
            }];
    
    }
    
    [queue waitUntilAllOperationsAreFinished];

}

-(void)removeCatagory:(MSLifeLoggerCatagory*)catagory {
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_DELETE withArgs:@[catagory.catid] withName:DATABASE_CATAGORIES withQueryIndex:0 onCompletion:nil];
}

-(void)moveAllMessagesFromCatagory:(MSLifeLoggerCatagory*)catfrom  to:(MSLifeLoggerCatagory*)catto {
    
    NSString* catfromid = catfrom.catid;
    NSString* cattoid = catto.catid;
    
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_UPDATE withArgs:@[cattoid,catfromid] withName:DATABASE_CATAGORIES withQueryIndex:1 onCompletion:nil];
}

-(void)insertLogEntry:(MSLifeLoggerLogEntry*)entry {
    // insert log entry
    NSString* timestamp = entry.timestamp;
    
    NSArray* arrayArgs = @[entry.ownerid,entry.data == nil ? @"" : [entry.data dataWithJSONObject],entry.timestamp];
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_INSERT withArgs:arrayArgs withName:DATABASE_LOGENTRY withQueryIndex:0 onCompletion:nil];
    // query for id
    __block NSString* idref = @"";
   
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_SELECT withArgs:@[timestamp] withName:DATABASE_LOGENTRY withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
        if (!error && query.arrayResults.count > 0) {
            
            NSDictionary* result = query.arrayResults[0];
            idref = result[@"id"];
            [entry setObject:idref key:@"id"];
        }
    }];
    // insert entry data

    for (MSLifeLoggerLogEntryData* entrydata in entry.entryData) {
        
        [entrydata setObject:idref key:@"ownerid"];
        [self insertLogEntryData:entrydata];
    }
    
    
    [self changeCatagory:self.activeCatagory];
}

-(void)insertLogEntryData:(MSLifeLoggerLogEntryData*)entrydata {
    NSString* oid = entrydata.ownerid;
    NSString* logdata = entrydata.logEntryData;
    NSArray* array = @[oid,[@(entrydata.logEntryType) stringValue],logdata];
   
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_INSERT withArgs:array withName:DATABASE_LOGENTRY_DATA withQueryIndex:0 onCompletion:^(MSDBQueryResponse * _Nullable query, NSError * _Nullable error) {
       
        if (error)
            NSLog(@"%@",error);
    }];
    
}

-(void)changeCatagory:(MSLifeLoggerCatagory*)catagory {
    
    if (!catagory)
        return;
    
    self.activeCatagory = catagory;
    [[MSFeatureLifeLogger instance].userSettings setObject:catagory.catid key:MSLifeLoggerSettingLastCatagory];
    
    NSMutableArray* logentrys = [[NSMutableArray alloc] init];
    self.currentObjectData = [[NSMutableArray alloc] init];
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_SELECT withArgs:@[catagory.catid] withName:DATABASE_LOGENTRY withQueryIndex:1 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
       
        if (query.arrayResults.count > 0) {
            
            for (NSDictionary* data in query.arrayResults) {
                
                MSLifeLoggerLogEntry* entry = [[MSLifeLoggerLogEntry alloc] initWithDict:data];
                [logentrys addObject:entry];
                
            }
            
        }
        
    }];
    
    for (MSLifeLoggerLogEntry* entry in logentrys) {
        
        [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_SELECT withArgs:@[entry.objid] withName:DATABASE_LOGENTRY_DATA withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
           
            if (query.arrayResults.count > 0) {
                
                for (NSDictionary* entrydat in query.arrayResults) {
                    
                    MSLifeLoggerLogEntryData* entryData = [[MSLifeLoggerLogEntryData alloc] initWithDict:entrydat];
                    [entry addLogEntryData:entryData];
                }
                
            }
            
        }];

    }
    
    NSMutableDictionary *dictEntrys = [[NSMutableDictionary alloc] init];

    for (MSLifeLoggerLogEntry *entry in logentrys) {
        
        NSString *date = [MSFeatureDateFormatting headerSortingIndex:entry.timestamp];
        
        MSLifeLoggerSortingIndex *index = dictEntrys[date];
        
        if (!index) {
            index = [[MSLifeLoggerSortingIndex alloc] init];
            index.sortingHeader = date;
            index.headerString = [MSFeatureDateFormatting headerFormattedTime:entry.timestamp];
            dictEntrys[date] = index;
        }
        NSLog(@"%@ %@",date,entry.entryData[0]);
        [index.entryLogs addObject:entry];
        
    }
 
    
    for (MSLifeLoggerSortingIndex* index in dictEntrys.allValues) {
        [index.entryLogs sortUsingComparator:^NSComparisonResult(MSLifeLoggerLogEntry*  _Nonnull obj1, MSLifeLoggerLogEntry*  _Nonnull obj2) {
            
            return [obj1.timestamp compare:obj2.timestamp];
        }];
        [self.currentObjectData addObject:index];
    }
    

    [self.currentObjectData sortUsingComparator:^NSComparisonResult(MSLifeLoggerSortingIndex*  _Nonnull obj1, MSLifeLoggerSortingIndex*  _Nonnull obj2) {
    
        return [obj2.sortingHeader compare:obj1.sortingHeader];
        
    }];
    
    self.arrayOfActiveCatagoryObjects = self.currentObjectData;
}

-(void)updateLogEntry:(MSLifeLoggerLogEntry*)entry withReload:(bool)reload {
    
    // for now update time.
    
    NSString* entryJson = entry.data == nil ? @"" : [entry.data dataWithJSONObject];
    
    NSArray* array = @[entry.timestamp,entry.objid,entryJson,entry.ownerid];
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_UPDATE withArgs:array withName:DATABASE_LOGENTRY withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
        
    }];
    
    for (MSLifeLoggerLogEntryData* data in entry.entryData) {
        
        [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_UPDATE withArgs:@[data.logEntryData,data.objid] withName:DATABASE_LOGENTRY_DATA withQueryIndex:0 onCompletion:nil];
    }
    
    if (reload)
        [self changeCatagory:self.activeCatagory];
}

-(void)removeLogEntry:(MSLifeLoggerLogEntry*)entry {
    
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_DELETE withArgs:@[entry.objid] withName:DATABASE_LOGENTRY withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
        
    }];
    
    for (MSLifeLoggerLogEntryData* data in entry.entryData) {
        
        [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_DELETE withArgs:@[data.objid] withName:DATABASE_LOGENTRY_DATA withQueryIndex:0 onCompletion:nil];
    }
    
    [self changeCatagory:self.activeCatagory];
    
}

@end
