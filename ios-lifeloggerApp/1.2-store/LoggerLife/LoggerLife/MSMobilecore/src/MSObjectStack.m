//
//  MSObjectStack.m
//  MSMobilecore
//
//  Created by John Mulvey on 5/20/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSObjectStack.h"
#import "MSSychronizedMutableDictionary.h"

/*
 
 MSObjectStackTypeGApplication,
 MSObjectStackTypeModel,
 MSObjectStackTypeService
 
 */

static MSObjectStack*  g_ApplicationStack = nil;
static MSObjectStack*  g_ServiceStack = nil;
static MSObjectStack*  g_DataBaseStack = nil;
static MSObjectStack* g_ObjectStack = nil;
static MSSychronizedMutableDictionary*  g_objectStack = nil;

@interface MSObjectStack()
@property (atomic,strong) MSSychronizedMutableDictionary* modelData;
@end

@implementation MSObjectStack
+(void)initialize {
    
    g_ApplicationStack = [ MSObjectStack new];
    g_ServiceStack = [MSObjectStack new];
    g_DataBaseStack = [MSObjectStack new];
    g_ObjectStack = [MSObjectStack new];
    g_objectStack = [MSSychronizedMutableDictionary new];
    
}


+(void)setObjectStack:(MSObjectStackType)stack name:(NSString*)name object:(id)object {
    
    MSObjectStack* objstack = [self objectStack:stack];
    
    if (objstack && name && object) {
        [objstack.modelData setObject:object forKey:name];
    }
    
}
+(id)objectForStack:(MSObjectStackType)stack name:(NSString*)name {
    MSObjectStack* objstack = [self objectStack:stack];
    id result = nil;
    if (objstack && name) {
       result =  [objstack.modelData valueForKey:name];
    }
    
    return result;
}
+(void)removeObjectForStack:(MSObjectStackType)stack name:(NSString*)name {
     MSObjectStack* objstack = [self objectStack:stack];
    
     if (objstack && name) {
         [objstack.modelData removeObjectForKey:name];
     }
}
+(void)resetAllStacks {
    [self initialize];
    
}
+(MSObjectStack*)objectStack:(MSObjectStackType)stack {
    
    MSObjectStack* retstack = nil;
    
    switch (stack) {
        case MSObjectStackTypeApplication: {
            retstack = g_ApplicationStack;
            break;
        }
        case MSObjectStackTypeModel: {
            retstack = g_ObjectStack;
            break;
        }
        case MSObjectStackTypeService: {
            retstack =  g_ServiceStack;
            break;
        }
        case MSObjectStackTypeDatabaseStack: {
            retstack = g_DataBaseStack;
            break;
        }
            
    }
    
    return retstack;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        self.modelData = [MSSychronizedMutableDictionary new];
        
    }
    
    return self;
}

-(instancetype)initWithJsonString:(NSString*)jsondata {
    
    self = [super init];
    
    if (self) {
        
        if (jsondata) {
            [self JSONObjectWithData:jsondata];
        } else {
            self.modelData = [MSSychronizedMutableDictionary new];
        }
        
    }
    
    return self;
}


-(instancetype)initWithDict:(NSDictionary*)data {
   // self = [super init];
    
    if (self = [super init]) {
        self.modelData = [[MSSychronizedMutableDictionary alloc] initWithDictionary:data];
    }
    
    return self;
}

-(void)removeObjects {
    [self.modelData removeAllObjects];
}

-(NSString*)stringForObject:(NSString*)object {
    return [self.modelData valueForKey: object];
}
-(NSArray*)arrayForObject:(NSString*)object {
    return [self.modelData valueForKey:object];
}
-(bool)containtObject:(NSString*)object {
    return [self.modelData containsObject:object];
    
}
-(void)setObject:(id)object key:(NSString*)key {
    [self.modelData setObject:object forKey:key];
}
-(id)getObject:(NSString*)key {
     return [self.modelData valueForKey:key];
}
-(NSInteger)integerForObject:(NSString*)object {
    return [[self.modelData valueForKey:object] integerValue];
}
-(bool)boolForObject:(NSString*)object {
    return [[self.modelData valueForKey:object] boolValue];
}
-(NSString*)dataWithJSONObject {
    NSError * err  = nil;;
    NSData* jsonData = [NSJSONSerialization  dataWithJSONObject:self.modelData.rawDictionary options:0 error:&err];
    NSString* returnstring = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
    return returnstring;
}
-(bool)JSONObjectWithData:(NSString*)data {
   
    if (!data)
        return false;
    
    NSData *objdata =[data dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!objdata)
        return false;
    NSError * err = nil;
    NSDictionary* obj =  (NSDictionary *)[NSJSONSerialization JSONObjectWithData:objdata options:NSJSONReadingMutableContainers error:&err];
    
    if (!obj || err)
        return false;
    self.modelData = [[MSSychronizedMutableDictionary alloc] initWithDictionary:obj];
  
    return true;
}

-(NSString*)description {
    return [self.modelData.rawDictionary description];
}
-(NSDictionary*) rawDictionary {
 
    return self.modelData.rawDictionary;
    
}
@end
