//
//  MSContentManager.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/16/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSContentManager : NSObject
+(MSContentManager*) instance;
+(NSString*)valueForKey:(NSString*)key;

-(NSString*)contentForKey:(NSString*)key;
-(NSString*)contentForKey:(NSString*)key withLang:(NSString*)lang;
-(BOOL)changeLang:(NSString*)lang;
@end

NS_ASSUME_NONNULL_END
