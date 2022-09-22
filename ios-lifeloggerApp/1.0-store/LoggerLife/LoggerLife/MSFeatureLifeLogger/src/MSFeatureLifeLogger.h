//
//  MSFeatureLifeLogger.h
//  MSFeatureLifeLogger
//
//  Created by John Mulvey on 5/19/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import "MSFeatureCMKeys.h"
#import "MSFeatureLifeLoggerVisualSpec.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MSMobilecore.h"
#import "MSLifeLoggerCatagory.h"
#import "MSLifeLoggerLogEntryData.h"
#import "MSLifeLoggerLogEntry.h"
#import "MSLifeLoggerUserSettings.h"

#define DATABASE_CATAGORIES      @"catagory"
#define DATABASE_LOGENTRY        @"logentry"
#define DATABASE_LOGENTRY_DATA   @"logentrydata"

#define CATAGORY_DEFAULT_DAILY          @"Daily"
#define CATAGORY_DEFAULT_JUNK           @"Junk"
#define CATAGORY_DEFAULT_TRASH          @"Trash"

typedef enum {
    
    AddBannerScreenAbout,
    AddBannerScreenChangeOrder,
    AddBannerScreenEditCatagory,
    AddBannerScreenEntryScreen,
    AddBannerScreenMain
    
    
} AddBannerScreen;

typedef enum {
    MSLifeLoggerScreenCenterView,
    MSLifeLoggerScreenLeftView,
    MSLifeLoggerScreenAddEditEvent,
    MSLifeLoggerScreenAbout,
    MSLifeLoggerScreenChangeCatagory,
    MSLifeLoggerScreenChangeCatagoryOrder,
    MSLifeLoggerScreenAddEditCatagory,
    MSLifeLoggerScreenExportCatagory,
    MSLifeLoggerScreenCatagoryOptions
} MSLifeLoggerScreen;

#define LIFELOGGER_CURRENT_CATAGORY [MSFeatureLifeLogger instance].activeCatagory

@interface MSFeatureLifeLogger : NSObject<MSMobileCoreResourceDelegate>

+(MSFeatureLifeLogger*) instance;

// query for catagories
-(void)initCatagories;

+(NSString*)formattedTimeStamp:(NSString*)timestamp;

+(NSString*)formattedTime:(NSString*)timestamp;
+(NSString*)headerFormattedTime:(NSString*)timestampentry;

+(NSString*)googleAddSenseIdentification;

+(NSString*)googleAddSenseIntestinal1;

+(UIViewController*)BuildScreenforStack:(MSObjectStack*)stack withNavController:(UINavigationController*)navcontroller screen:(MSLifeLoggerScreen)screen;

// base data;
@property (readonly,nonatomic) NSArray* arrayOfCatagories;
@property (readonly,nonatomic) NSArray* arrayOfActiveCatagoryObjects;
@property (readonly) MSLifeLoggerCatagory* activeCatagory;
@property (readonly) MSLifeLoggerUserSettings* userSettings;


-(UIView*)createBannerRequest:(UIViewController*)viewc screen:(AddBannerScreen)screen;


-(void)updateLifeloggerCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)changeCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)insertLifeLoggerCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)removeCatagory:(MSLifeLoggerCatagory*)catagory;
-(void)moveAllMessagesFromCatagory:(MSLifeLoggerCatagory*)catfrom  to:(MSLifeLoggerCatagory*)catto;
-(MSLifeLoggerCatagory*)findCatagory:(NSString*)name;
-(void)removeAllMessagesFromCatagory:(MSLifeLoggerCatagory*)catagory;

-(void)addEntryToList:(MSLifeLoggerLogEntry*)entry;
-(void)insertLogEntry:(MSLifeLoggerLogEntry*)entry;
-(void)updateLogEntry:(MSLifeLoggerLogEntry*)entry withReload:(bool)reload;
-(void)removeLogEntry:(MSLifeLoggerLogEntry*)entry;
@end
