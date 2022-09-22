//
//  MSObjectStack.h
//  MSMobilecore
//
//  Created by John Mulvey on 5/20/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MSObjectStackTypeApplication,
    MSObjectStackTypeModel,
    MSObjectStackTypeService,
    MSObjectStackTypeDatabaseStack
    
} MSObjectStackType;

@interface MSObjectStack : NSObject

// stack type manipulation
+(void)initialize;
+(void)setObjectStack:(MSObjectStackType)stack name:(NSString*)name object:(id)object;
+(id)objectForStack:(MSObjectStackType)stack name:(NSString*)name;
+(void)removeObjectForStack:(MSObjectStackType)stack name:(NSString*)name;
+(void)resetAllStacks;
+(MSObjectStack*)objectStack:(MSObjectStackType)stack;




-(instancetype)init;
-(instancetype)initWithDict:(NSDictionary*)data;
@end
