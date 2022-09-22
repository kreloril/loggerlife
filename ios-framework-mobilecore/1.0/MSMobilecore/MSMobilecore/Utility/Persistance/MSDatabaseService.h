//
//  MSDatabaseService.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/8/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <MSMobilecore/MSMobilecore.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSDatabaseService : MSObjectStack
@property (readonly) NSString* dbModelClass;
@property (readonly) NSString* dbQueryCreate;
@property (readonly) NSArray* dbQuerySelect;
@property (readonly) NSArray* dbQueryDelete;
@property (readonly) NSArray* dbQueryUpdate;
@property (readonly) NSArray* dbQueryInsert;
@property (readonly) NSArray* dbQueryAlter;

-(NSArray*)arrayForDBType:(NSInteger)dbtype;

@end

NS_ASSUME_NONNULL_END
