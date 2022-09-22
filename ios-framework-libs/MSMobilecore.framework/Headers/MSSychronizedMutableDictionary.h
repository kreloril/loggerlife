//
//  MSSychronizedMutableDictionary.h
//  MSMobilecore
//
//  Created by John Mulvey on 5/18/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//



@interface MSSychronizedMutableDictionary : NSObject<NSCopying>


- (void)removeAllObjects;
- (void)removeObjectForKey:(NSString*)aKey;
- (void)setObject:(id)anObject forKey:(NSString* )aKey;
- (instancetype)initWithDictionary:(NSDictionary*)otherDictionary;
- (nullable id)valueForKey:(NSString *)key;

@property (readonly, copy) NSArray<NSString* > *allKeys;
@end
