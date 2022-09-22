//
//  MSFeatureScreenBuilder.h
//  LoggerLife
//
//  Created by John Mulvey on 8/8/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSObjectStack.h"
NS_ASSUME_NONNULL_BEGIN

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

@interface MSFeatureScreenBuilder : NSObject

+(UIViewController*)BuildScreenforStack:(nullable MSObjectStack*)stack withNavController:(nullable UINavigationController*)navcontroller screen:(MSLifeLoggerScreen)screen;

@end

NS_ASSUME_NONNULL_END
