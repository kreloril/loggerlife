//
//  MSSychronizedMutableDictionary.h
//  MSMobilecore
//
//  Created by John Mulvey on 5/18/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//



@interface MSSychronizedMutableDictionary : NSObject<NSCopying>


- (void)removeAllObjects;
- (void)removeObjectForKey:(NSString*_Nonnull)aKey;
- (void)setObject:(id _Nullable)anObject forKey:(NSString*_Nonnull)aKey;
- (instancetype _Nullable)initWithDictionary:(NSDictionary*_Nonnull)otherDictionary;
- (nullable id)valueForKey:(NSString *_Nonnull)key;
-(BOOL)containsObject:(NSString*_Nonnull)key;
-(NSDictionary* _Nullable)rawDictionary;
@property (readonly, copy) NSArray<NSString* > * _Nullable allKeys;
@end
