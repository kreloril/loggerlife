//
//  MSSychronizedMutableDictionary.m
//  MSMobilecore
//
//  Created by John Mulvey on 5/18/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MSSychronizedMutableDictionary.h"
#import "MSLogger.h"

@interface MSSychronizedMutableDictionary()
@property (atomic, strong) NSMutableDictionary<NSString *, id> *dictionary;
@end

@implementation MSSychronizedMutableDictionary
- (instancetype) init {
    
    self = [super init];
    
    if (self) {
        [self msSynchronizedMutableDictionaryInit];
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<id, id> *)otherDictionary {
    
    self = [self init];
    
    if (self) {
        [self.dictionary setDictionary:otherDictionary];
    }
    
    return self;
}
-(NSDictionary*)rawDictionary {
    return self.dictionary;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    MSSychronizedMutableDictionary * copy = [[[self class] allocWithZone:zone] init];
    [copy.dictionary setDictionary:self.dictionary];
    
    return copy;
}
- (void) msSynchronizedMutableDictionaryInit {
    self.dictionary = [NSMutableDictionary new];
}

- (nullable id)objectForKey:(id)aKey {
    @synchronized(self) {
        return [self.dictionary objectForKey:aKey];
    }
}
- (NSArray<NSString *> *) allKeys {
    @synchronized(self) {
        return self.dictionary.allKeys;
    }
}
- (NSMutableDictionary*) getBackingDictionary {
    @synchronized(self) {
        return self.dictionary;
    }
}

- (NSString *) description {
    @synchronized(self) {
        return [NSString stringWithFormat:@"%@\n%@", super.description, self.dictionary.description];
    }
}
- (nullable id)valueForKey:(NSString *)key {
    @synchronized(self) {
        return [self.dictionary valueForKey:key];
    }
}

- (void)removeAllObjects {
    @synchronized(self) {
        [self.dictionary removeAllObjects];
    }
}
- (void)removeObjectForKey:(NSString*)aKey {
    @synchronized(self) {
        [self.dictionary removeObjectForKey:aKey];
    }
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    @synchronized(self) {
        [self.dictionary setObject:anObject forKey:aKey];
    }
}
-(BOOL)containsObject:(NSString*)key {
    @synchronized (self) {
        return  [self.dictionary objectForKey:key] == nil ? FALSE : TRUE;
    }
}

@end
