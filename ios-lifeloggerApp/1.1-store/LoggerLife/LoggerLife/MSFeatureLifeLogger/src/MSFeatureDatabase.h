//
//  MSFeatureDatabase.h
//  LoggerLife
//
//  Created by John Mulvey on 8/9/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSLifeLoggerCatagory.h"
#import "MSLifeLoggerLogEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSFeatureDatabase : NSObject

-(void)initCatagories;
-(void)updateLifeloggerCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)changeCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)insertLifeLoggerCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)removeCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)moveAllMessagesFromCatagory:(MSLifeLoggerCatagory*)catfrom  to:(MSLifeLoggerCatagory*)catto;
-(MSLifeLoggerCatagory*)findCatagory:(NSString*)name;
-(void)removeAllMessagesFromCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)insertLogEntry:(MSLifeLoggerLogEntry*)entry;
-(void)updateLogEntry:(MSLifeLoggerLogEntry*)entry withReload:(bool)reload;
-(void)removeLogEntry:(MSLifeLoggerLogEntry*)entry;

@property (strong,nonatomic) NSArray* arrayOfCatagories;
@property (strong,nonatomic) NSArray* arrayOfActiveCatagoryObjects;
@property (strong,nonatomic) MSLifeLoggerCatagory* activeCatagory;
@property (strong,nonatomic) NSMutableArray<MSLifeLoggerSortingIndex*> *currentObjectData;

@end

NS_ASSUME_NONNULL_END
