//
//  MSMobilecore.h
//  MSMobilecore
//
//  Created by John Mulvey on 5/18/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#pragma once

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// support

#import "MSLogger.h"
#import "MSObjectStack.h"
#import "MSMobileCoreResourceDelegate.h"
#import "MSSychronizedMutableDictionary.h"
#import "MSDatabaseManager.h"
#import "MSContentManager.h"

// views
#import "MSTableView.h"
// supported controllers
#import "MSMobileCoreBaseViewController.h"
#import "MSMobleCoreTableViewController.h"
#import "MSMobileCoreTableViewCell.h"

// libs
#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

#define IS_IPAD [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad
#define IS_IPHONE [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone

@interface MSMobileCore : NSObject

+(MSMobileCore*)instance;

@property (nonatomic,weak) id<MSMobileCoreResourceDelegate> coreResourceDelegate;
@property (nonatomic,strong) MSDatabaseManager* dbManager;

-(void)startMobileCore;

@end
