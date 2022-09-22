//
//  Catagory.h
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 12/30/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//




#define CATAGORY_PROPERTY_ISSECURE      @"issecure"
#define CATAGORY_PROPERTY_SORTINGORDER  @"sortingorder"
#define CATAGORY_PROPERTY_ALLOWREAD     @"allowad"
#define CATAGORY_PROPERTY_ALLOWDELETE   @"allowdelete"



NS_ASSUME_NONNULL_BEGIN

@interface MSLifeLoggerCatagory : MSObjectStack

@property (nonatomic,readonly) NSString* catid;
@property (nonatomic,readonly) NSString* name;
@property (nonatomic,readonly) NSString* rawdata;
@property (readonly) MSObjectStack* data;

@property (readonly) NSInteger sortingOrder;
@property (readonly) bool issecure;
@property (readonly) bool allowAddEvent;
@property (readonly) bool alloweDelete;

-(MSLifeLoggerCatagory*)initWithCatagoryName:(NSString*)name;
-(NSComparisonResult)compare:(MSLifeLoggerCatagory*)obj2;
-(void)updateDataProperties;
@end

NS_ASSUME_NONNULL_END
