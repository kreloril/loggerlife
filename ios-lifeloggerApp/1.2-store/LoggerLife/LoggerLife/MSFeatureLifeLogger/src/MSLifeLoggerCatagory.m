//
//  Catagory.m
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/30/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSFeatureLifeLogger.h"
#import "MSLifeLoggerCatagory.h"


@interface MSLifeLoggerCatagory()
@property (nonatomic,strong) MSObjectStack* _data;
@end

@implementation MSLifeLoggerCatagory


-(MSLifeLoggerCatagory*)initWithCatagoryName:(NSString*)name {
    return [self initWithDict:@{@"name":name,@"data":@""}];
}
-(instancetype)initWithDict:(NSDictionary *)data {
    self = [super initWithDict:data];
    
    NSString* rawdata = [self stringForObject:@"data"];
   
    if (rawdata.length > 0) {
        self._data = [[MSObjectStack alloc] initWithJsonString:rawdata];
    } else {
        self._data = [[MSObjectStack alloc] init];
        [self initDataDefaults];
    }
    
    [self updateDataProperties];
    
    return self;
}
-(NSString*)description {
    return [NSString stringWithFormat:@"%@ %@",self.rawDictionary,self.data.rawDictionary];
}
-(void)initDataDefaults {

    [self._data setObject:@"-1" key:CATAGORY_PROPERTY_SORTINGORDER];
    [self._data setObject:@"0" key:CATAGORY_PROPERTY_ISSECURE];
    [self._data setObject:@"1" key:CATAGORY_PROPERTY_ALLOWREAD];
    [self._data setObject:@"1" key:CATAGORY_PROPERTY_ALLOWDELETE];

}

-(void)updateDataProperties {
    
    NSArray* properties = @[CATAGORY_PROPERTY_SORTINGORDER,CATAGORY_PROPERTY_ISSECURE,CATAGORY_PROPERTY_ALLOWREAD,CATAGORY_PROPERTY_ALLOWDELETE];
    
    NSArray* propdefaults = @[@"-1",@"0",@"1",@"1"];
    NSArray* propprimarys =  @[@"-1",@"0",@"1",@"0"];
    
    bool isDefault = [self isProtectedObject];
    
    for (int i = 0; i < properties.count; i++) {
        NSString* propname = properties[i];
        NSString* prop = isDefault ? propprimarys[i] : propdefaults[i];
        
        if (![self._data containtObject:propname]) {
            [self._data setObject:prop key:propname];
        }
        
    }
    
}
-(bool)isProtectedObject {

    NSArray* defaultCatagories = @[CATAGORY_DEFAULT_DAILY,CATAGORY_DEFAULT_JUNK,CATAGORY_DEFAULT_TRASH];
    
    for (NSString* name in defaultCatagories) {
        if ([self.name caseInsensitiveCompare:name] ==  NSOrderedSame) {
            return true;
        }
    }
    
    return FALSE;
}
-(MSObjectStack*)data {
    return self._data;
}
-(NSString*) catid {
    return [self stringForObject:@"id"];
}
-(NSString*) name {
    return [self stringForObject:@"name"];
}

-(BOOL)alloweDelete {
    return [self.data boolForObject:CATAGORY_PROPERTY_ALLOWDELETE];
}
-(NSString*)rawData {
    return [self stringForObject:@"data"];
}
-(NSInteger)sortingOrder {
    return [self._data integerForObject:CATAGORY_PROPERTY_SORTINGORDER ];
}
-(BOOL)issecure {
    return [self._data boolForObject:CATAGORY_PROPERTY_ISSECURE];
}
-(BOOL)allowAddEvent {
    return [self._data boolForObject:CATAGORY_PROPERTY_ALLOWREAD];
}


/*
 NSOrderedAscending = -1L,
 NSOrderedSame,
 NSOrderedDescending
 */
-(NSComparisonResult)compare:(MSLifeLoggerCatagory*)obj2 {
    
    NSInteger soself = self.sortingOrder;
    NSInteger soobj2 = obj2.sortingOrder;
    
    if (soself == soobj2)
        return [obj2.name compare:self.name];
    
    if (soself > soobj2)
        return NSOrderedAscending;
    
    return NSOrderedDescending;
        
}

@end
