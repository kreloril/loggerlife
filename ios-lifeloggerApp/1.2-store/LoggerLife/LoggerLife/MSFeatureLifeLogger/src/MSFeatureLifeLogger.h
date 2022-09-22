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
#import "MSLifeLoggerSortingIndex.h"
#import "MSFeatureScreenBuilder.h"
#import "MSFeatureDateFormatting.h"
#import "MSFeatureDatabase.h"

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

#define LIFELOGGER_CURRENT_CATAGORY [MSFeatureLifeLogger instance].featureDataBase.activeCatagory
#define LIFELOGGER_CURRENT_DATABASE [MSFeatureLifeLogger instance].featureDataBase

@interface MSFeatureLifeLogger : NSObject<MSMobileCoreResourceDelegate>

// user settings

@property (strong,nonatomic) MSLifeLoggerUserSettings* userSettings;

+(MSFeatureLifeLogger*) instance;

// ads
+(NSString*)googleAddSenseIdentification;
+(NSString*)googleAddSenseIntestinal1;
-(UIView*)createBannerRequest:(UIViewController*)viewc screen:(AddBannerScreen)screen;

// this where data is stored
@property (nonatomic,strong) MSFeatureDatabase *featureDataBase;

@end
