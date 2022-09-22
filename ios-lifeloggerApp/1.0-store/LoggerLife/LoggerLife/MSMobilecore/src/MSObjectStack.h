//
//  MSObjectStack.h
//  MSMobilecore
//
//  Created by John Mulvey on 5/20/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MSObjectStackTypeApplication, // global things for application
    MSObjectStackTypeModel,    // application datagoes here.
    MSObjectStackTypeService, // service info goes here
    MSObjectStackTypeDatabaseStack // db querys/info goes here
    
} MSObjectStackType;

@interface MSObjectStack : NSObject

// stack type manipulation
+(void)initialize;
+(void)setObjectStack:(MSObjectStackType)stack name:(NSString*)name object:(id)object;
+(id)objectForStack:(MSObjectStackType)stack name:(NSString*)name;
+(void)removeObjectForStack:(MSObjectStackType)stack name:(NSString*)name;
+(void)resetAllStacks;
+(MSObjectStack*)objectStack:(MSObjectStackType)stack;


// objects
-(instancetype)init;
-(instancetype)initWithDict:(NSDictionary*)data;
-(instancetype)initWithJsonString:(NSString*)jsondata;
-(bool)containtObject:(NSString*)object;
-(void)setObject:(id)object key:(NSString*)key;
-(id)getObject:(NSString*)key;
-(NSString*)stringForObject:(NSString*)object;
-(NSArray*)arrayForObject:(NSString*)object;
-(NSInteger)integerForObject:(NSString*)object;
-(bool)boolForObject:(NSString*)object;
-(void)removeObjects;

// json conversion
-(NSString*)dataWithJSONObject;
-(bool)JSONObjectWithData:(NSString*)data;
-(NSString*)description;

@property (readonly) NSDictionary* rawDictionary;

@end
