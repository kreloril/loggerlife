//
//  MSContentManager.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/16/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSLogger.h"
#import "MSObjectStack.h"
#import "MSDatabaseManager.h"
#import "MSMobilecore.h"
#import "MSContentManager.h"

@interface MSContentManager()

@property (nonatomic,strong) MSDatabaseManager* dbEngine;
@property (nonatomic,strong) MSObjectStack* infoStack;
@property (nonatomic,strong) NSString* currentLanguage;
@end
@implementation MSContentManager

+(MSContentManager*) instance {
    static MSContentManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MSContentManager alloc]  init];
        [MSLogger log:@"MSContentManager started"];
        instance.infoStack = [[MSObjectStack alloc] init];
        instance.currentLanguage = @"en-us";
        
        
        if ([[MSMobileCore instance].coreResourceDelegate respondsToSelector:@selector(contentDatabaseName)]) {
        
            instance.dbEngine = [[MSDatabaseManager alloc] init];
            NSBundle* bundle = [NSBundle bundleForClass:[self class]];
            NSString* path = [bundle pathForResource:@"cmdbinfo" ofType:@"plist"];
            [instance.dbEngine loadService:path];
            [instance.dbEngine openDBEngine:[MSMobileCore instance].coreResourceDelegate.contentDatabaseName];
            
        }
    });
    
    return instance;
}
+(NSString*)valueForKey:(NSString*)key {
    return [[self instance] contentForKey:key];
}
-(NSString*)contentForKey:(NSString*)key {
    return [self contentForKey:key withLang:self.currentLanguage];
}
-(NSString*)contentForKey:(NSString*)key withLang:(NSString*)lang {
    
    if ([self.infoStack containtObject:key])
        return [self.infoStack stringForObject:key];
    
   __block NSString* value = key;
    
    [self.dbEngine executeQuery:DB_QUERY_SELECT withArgs:@[key,self.currentLanguage] withName:@"cmskeys" withQueryIndex:0 onCompletion:^(MSDBQueryResponse *query, NSError *error) {
        
        if (query.arrayResults.count > 0) {
            NSDictionary* valuedict = query.arrayResults[0];
            value = valuedict[@"value"];
            [self.infoStack setObject:value key:key];
        
        }
    }];
    
    return value;
}
-(BOOL)changeLang:(NSString*)lang {
    self.currentLanguage = lang;
    [self.infoStack removeObjects];
    return true;
}

@end
