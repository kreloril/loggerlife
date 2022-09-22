//
//  MSFeatureLifeLogger.m
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/1/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//
#define ENTRY_KEY @"ENTRY_KEY"


//@import GoogleMobileAds;


#import "MSFeatureLifeLogger.h"
#import "MSFeatureLifeLoggerScreens.h"

@interface MSFeatureLifeLogger()
@property (nonatomic,strong) MSObjectStack* currentObjectData;
@property (strong,nonatomic) MSLifeLoggerCatagory* _activeCatagory;
@property (strong,nonatomic) MSLifeLoggerUserSettings* _userSettings;
@property (strong,nonatomic) NSDateFormatter* formmatedLogdate;
@end

@implementation MSFeatureLifeLogger

+(MSFeatureLifeLogger*) instance {
    static MSFeatureLifeLogger* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MSFeatureLifeLogger alloc]  init];
        [MSLogger log:@"MSFeatureLifeLogger started"];
        instance.currentObjectData = [[MSObjectStack alloc] init];
        instance._userSettings = [[MSLifeLoggerUserSettings alloc] init];
     //   [instance initCatagories];
    });
    
    return instance;
}
-(UIView*)createBannerRequest:(UIViewController*)viewc screen:(AddBannerScreen)screen {
   
   /*( if (self.userSettings.hasBannerAdsDisabled == true)
        return nil;
    

   GADBannerView* bannerView =  [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];

    NSString* addBanner = nil;
    
    switch (screen) {
        case AddBannerScreenAbout: {
            addBanner = @"ca-app-pub-5690864134174270/6889821768";
            break;
        }
        case AddBannerScreenChangeOrder: {
            addBanner = @"ca-app-pub-5690864134174270/8842387054";
            break;
        }
        case AddBannerScreenEditCatagory:{
            addBanner = @"ca-app-pub-5690864134174270/6216223718";
            break;
        }
        case AddBannerScreenEntryScreen:{
            addBanner = @"ca-app-pub-5690864134174270/5576740090";
            break;
        }
        case AddBannerScreenMain:{
            addBanner = @"ca-app-pub-5690864134174270/1618503156";
            break;
        }
    }
    
    bannerView.adUnitID = addBanner;
    bannerView.rootViewController = viewc;
    GADRequest* request = [GADRequest request];
#if TARGET_OS_SIMULATOR
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ kGADSimulatorID ];
#endif
    [bannerView loadRequest:request];
    return bannerView; */
    return nil;

}
+(NSString*)googleAddSenseIntestinal1 {
    return @"ca-app-pub-5690864134174270/2292031397";
}
+(NSString*)googleAddSenseIdentification {
    return @"ca-app-pub-5690864134174270~9653299055";
}

-(NSString*)resourceBinding {
    return @"lifeloggerresource";
}
-(bool)enableLogging {
    return true;
}
-(MSLifeLoggerCatagory*)activeCatagory {
    return self._activeCatagory;
}
-(NSString*)persistanceDatabaseName {
    NSString* dbname =  @"lifelogger.sqlite";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:dbname];
    
    return path;
}
-(MSLifeLoggerUserSettings*)userSettings {
    return self._userSettings;
}
-(NSString*)dataBaseEncryptionKey {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}
-(NSString*)databaseInfoFilePath {
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    return [bundle pathForResource:@"MasterDB" ofType:@"plist"];
}

- (nonnull NSString *)contentDatabaseName {
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    return [bundle pathForResource:@"dbcmskeys" ofType:@"db"];
}

- (nonnull NSString *)defaultLanguage {
    return @"en-us";
}

+(NSString*)formattedTimeStamp:(NSString*)timestamp {
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
    MSFeatureLifeLogger* instance = [MSFeatureLifeLogger instance];
    if (!instance.formmatedLogdate) {
    
        instance.formmatedLogdate = [[NSDateFormatter alloc] init];
        NSString* format = [NSDateFormatter dateFormatFromTemplate:@"EEE hh:mm a MM/dd/yyyy" options:0 locale:[NSLocale currentLocale]];
        format = [format stringByReplacingOccurrencesOfString:@"," withString:@""];
        [instance.formmatedLogdate setDateFormat:format];
    }
        
    return [instance.formmatedLogdate stringFromDate:date];
}
+(NSString*)headerFormattedTime:(NSString*)timestampentry {
    
      NSTimeInterval timestamp =  [timestampentry doubleValue];
     NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp];
     NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"EEE MMM dd, YYYY"];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
    return [dateFormatter stringFromDate:date];
     

}
+(NSTimeInterval)headerFormattedTimeInterval:(NSString*)timestampentry {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd, YYYY"];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
    NSDate* date = [dateFormatter dateFromString:timestampentry];
    return date.timeIntervalSince1970;
}
+(NSString*)formattedTime:(NSString*)timestamp {
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"hh:mm a"];
    
    return [formatter stringFromDate:date];
}
-(void)initCatagories {
     __block NSInteger catagoryCount = 0;
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_SELECT withArgs:@[] withName:DATABASE_CATAGORIES withQueryIndex:1 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
       
        catagoryCount = [self processObjectCount:query withString:@"count(id)"];
        
    }];
    
     [self._userSettings setObject:@"1" key:MSHasCreatedInitialCatagories];
    
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
    
    [self addEntryToList:entry];
    [self changeCatagory:[MSFeatureLifeLogger instance].activeCatagory];
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
-(void)addEntryToList:(MSLifeLoggerLogEntry*)entry {
    
    if (!self.currentObjectData)
        self.currentObjectData = [[MSObjectStack alloc] init];
    
    NSString* timestampentry = entry.timestamp;
    NSMutableArray* arrayObjects = nil;
    
    NSString* tempTime = [MSFeatureLifeLogger headerFormattedTime:timestampentry];
//    NSTimeInterval timeint  = [MSFeatureLifeLogger headerFormattedTimeInterval:tempTime];
    tempTime = timestampentry; //[[NSNumber numberWithDouble:timeint] stringValue];
    
    arrayObjects = [self.currentObjectData getObject:tempTime];
 
    if (!arrayObjects)
        arrayObjects = [[NSMutableArray alloc] init];
    
    [arrayObjects addObject:entry];
    
    [self.currentObjectData setObject:arrayObjects key:tempTime];
    
   // NSLog(@"date = %@\n%@",dateFormmatted,self.currentObjectData);
    
}
-(NSString*)shortDateFormat:(NSString*)date {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSDate* dateobj = [[NSDate alloc] initWithTimeIntervalSince1970:[date doubleValue]];
    return [formatter stringFromDate:dateobj];
}
-(NSArray*)arrayOfActiveCatagoryObjects {
    
    NSDictionary* dict = self.currentObjectData.rawDictionary;
    NSArray*  arrayKeys = dict.allKeys;
    
     NSArray* arraySorted = [arrayKeys sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
    
      //  NSString* srtobj1 = [self shortDateFormat:obj1];
      //  NSString* srtobj2 = [self shortDateFormat:obj2];
         
         
        NSDate* srtobj1 = [[NSDate alloc] initWithTimeIntervalSince1970:[obj1 doubleValue]];
        NSDate* srtobj2 = [[NSDate alloc] initWithTimeIntervalSince1970:[obj2 doubleValue]];
         NSLog(@"obj2 = %@, obj1 = %@",srtobj2,srtobj1);
         
         return [srtobj2 compare:srtobj1];
      
         /*NSTimeInterval timeobj1 = [MSFeatureLifeLogger headerFormattedTimeInterval:obj1];
         NSTimeInterval timeobj2 = [MSFeatureLifeLogger headerFormattedTimeInterval:obj2];
         
         if (timeobj1 == timeobj2)
             return NSOrderedSame;
         
         if (timeobj1 > timeobj2)
             return NSOrderedDescending;
         
         return NSOrderedAscending;*/
    }];
    
    NSMutableArray* finalArray = [[NSMutableArray alloc] init];
    
    for (NSString* key in arraySorted) {
        
        NSMutableArray* datalogs = [dict objectForKey:key];
        
        NSArray* sorted = [datalogs sortedArrayUsingComparator:^NSComparisonResult(MSLifeLoggerLogEntry* obj1, MSLifeLoggerLogEntry* obj2) {
            return [obj1.timestamp compare:obj2.timestamp];
        }];
     
        datalogs = [[NSMutableArray alloc] initWithArray:sorted];
        NSDictionary* entry = @{key:datalogs};
        
        [finalArray addObject:entry];
    }
    
    return finalArray;
    
}

-(void)changeCatagory:(MSLifeLoggerCatagory*)catagory {
    
    if (!catagory)
        return;
    
    self._activeCatagory = catagory;
    [self._userSettings setObject:catagory.catid key:MSLifeLoggerSettingLastCatagory];
    
    NSMutableArray* logentrys = [[NSMutableArray alloc] init];
    self.currentObjectData = nil;
    
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
        
        [self addEntryToList:entry];
        
    }
    
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
        [self changeCatagory:self._activeCatagory];
}
-(void)removeLogEntry:(MSLifeLoggerLogEntry*)entry {
    
    
    [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_DELETE withArgs:@[entry.objid] withName:DATABASE_LOGENTRY withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
        
    }];
    
    for (MSLifeLoggerLogEntryData* data in entry.entryData) {
        
        [[MSMobileCore instance].dbManager executeQuery:DB_QUERY_DELETE withArgs:@[data.objid] withName:DATABASE_LOGENTRY_DATA withQueryIndex:0 onCompletion:nil];
    }
    
    [self changeCatagory:self._activeCatagory];
    
}

+(UIViewController*)BuildScreenforStack:(MSObjectStack*)stack withNavController:(UINavigationController*)navcontroller screen:(MSLifeLoggerScreen)screen {
    
    if (!stack)
        stack = MSObjectStack.new;
    
    UIViewController* viewReturn;
    
    switch (screen) {
        case MSLifeLoggerScreenLeftView: {

            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            [stack setObject:[MSContentManager valueForKey:CKEY_TITLE] key:@"title"];
            MSLifeLoggerLeftViewController* leftView =  [[MSLifeLoggerLeftViewController alloc] initWithStack:stack];
            viewReturn = leftView;
            break;
        }
        
        case MSLifeLoggerScreenCenterView: {
            [stack setObject:[MSContentManager valueForKey:CKEY_LOGS] key:@"title"];
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            MSLifeLoggerCenterViewController* centerView = [[MSLifeLoggerCenterViewController alloc] initWithStack:stack];
            viewReturn = centerView;
            break;
        }
            
        case MSLifeLoggerScreenAddEditEvent: {
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            MSLifeLoggerAddEventViewController* addevent = [[MSLifeLoggerAddEventViewController alloc] initWithStack:stack];
            viewReturn = addevent;
            break;
        }
            
        case MSLifeLoggerScreenAbout: {
            [stack setObject:@"About" key:@"title"];
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            MSLifeLoggerAboutViewController* aboutView = [[MSLifeLoggerAboutViewController alloc] initWithStack:stack];
            viewReturn = aboutView;
            break;
        }
            
        case MSLifeLoggerScreenChangeCatagory:{
            
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            [stack setObject:@"Select Catagory" key:@"title"];
             MSMobileChangeCatagoryViewController* changeCat = [[MSMobileChangeCatagoryViewController alloc] initWithStack:stack];
            viewReturn = changeCat;
            break;
        }
            
        case MSLifeLoggerScreenChangeCatagoryOrder: {
           
            [stack setObject:@"Change Order" key:@"title"];
             [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
             
             MSMobileChangeCatagoryOrderViewController* changeorder = [[MSMobileChangeCatagoryOrderViewController alloc] initWithStack:stack];
            viewReturn = changeorder;

            break;
        }
            
        case MSLifeLoggerScreenAddEditCatagory: {
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
             MSLifeLoggerEditCatagoryViewController* controller = [[MSLifeLoggerEditCatagoryViewController alloc] initWithStack:stack];
            viewReturn = controller;
            break;
        }
            
        case MSLifeLoggerScreenExportCatagory: {
             [stack setObject:@"Export Catagory" key:@"title"];
            MSLifeLoggerExportLogViewController* exportView = [[MSLifeLoggerExportLogViewController alloc] initWithStack:stack];
            viewReturn = exportView;
            break;
        }

        case MSLifeLoggerScreenCatagoryOptions: {
            [stack setObject:@"Options" key:@"title"];
            MSLifeLoggerCatagoryOptionsViewController* optionsController = [[MSLifeLoggerCatagoryOptionsViewController alloc] initWithStack:stack];
            viewReturn = optionsController;
            break;
        }
            
        default:
            break;
    }
    // if theres a nav controller return with nav controller, otherwise return object
    if (!navcontroller) {
        UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:viewReturn];
        return controller;
    }
    
    return viewReturn;
}

@end
