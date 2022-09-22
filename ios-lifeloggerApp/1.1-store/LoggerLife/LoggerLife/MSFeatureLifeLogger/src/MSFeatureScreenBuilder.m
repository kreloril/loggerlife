//
//  MSFeatureScreenBuilder.m
//  LoggerLife
//
//  Created by John Mulvey on 8/8/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//


#import "MSFeatureScreenBuilder.h"
#import "MSFeatureLifeLoggerScreens.h"

@implementation MSFeatureScreenBuilder

+(UIViewController*)BuildScreenforStack:(nullable MSObjectStack*)stack withNavController:(nullable UINavigationController*)navcontroller screen:(MSLifeLoggerScreen)screen {
    
    if (!stack)
        stack = MSObjectStack.new;
    
    UIViewController* viewReturn;
    
    switch (screen) {
        case MSLifeLoggerScreenLeftView: {

            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            [stack setObject:[MSContentManager valueForKey:CKEY_TITLE] key:@"title"];
            MSLifeLoggerLeftViewController* leftView =  [[MSLifeLoggerLeftViewController alloc] initWithStack:stack];
            viewReturn = leftView;
            break;
        }
        
        case MSLifeLoggerScreenCenterView: {
            [stack setObject:[MSContentManager valueForKey:CKEY_LOGS] key:@"title"];
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            MSLifeLoggerCenterViewController* centerView = [[MSLifeLoggerCenterViewController alloc] initWithStack:stack];
            viewReturn = centerView;
            break;
        }
            
        case MSLifeLoggerScreenAddEditEvent: {
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            MSLifeLoggerAddEventViewController* addevent = [[MSLifeLoggerAddEventViewController alloc] initWithStack:stack];
            viewReturn = addevent;
            break;
        }
            
        case MSLifeLoggerScreenAbout: {
            [stack setObject:@"About" key:@"title"];
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            MSLifeLoggerAboutViewController* aboutView = [[MSLifeLoggerAboutViewController alloc] initWithStack:stack];
            viewReturn = aboutView;
            break;
        }
            
        case MSLifeLoggerScreenChangeCatagory:{
            
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
            [stack setObject:@"Select Catagory" key:@"title"];
             MSMobileChangeCatagoryViewController* changeCat = [[MSMobileChangeCatagoryViewController alloc] initWithStack:stack];
            viewReturn = changeCat;
            break;
        }
            
        case MSLifeLoggerScreenChangeCatagoryOrder: {
           
            [stack setObject:@"Change Order" key:@"title"];
             [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
             
             MSMobileChangeCatagoryOrderViewController* changeorder = [[MSMobileChangeCatagoryOrderViewController alloc] initWithStack:stack];
            viewReturn = changeorder;

            break;
        }
            
        case MSLifeLoggerScreenAddEditCatagory: {
            [stack setObject:[MSFeatureLifeLoggerVisualSpec backgroundViewColor] key:@"bkViewColor"];
             MSLifeLoggerEditCatagoryViewController* controller = [[MSLifeLoggerEditCatagoryViewController alloc] initWithStack:stack];
            viewReturn = controller;
            break;
        }
            
        case MSLifeLoggerScreenExportCatagory: {
             [stack setObject:@"Export Catagory" key:@"title"];
            MSLifeLoggerExportLogViewController* exportView = [[MSLifeLoggerExportLogViewController alloc] initWithStack:stack];
            viewReturn = exportView;
            break;
        }

        case MSLifeLoggerScreenCatagoryOptions: {
            [stack setObject:@"Options" key:@"title"];
            MSLifeLoggerCatagoryOptionsViewController* optionsController = [[MSLifeLoggerCatagoryOptionsViewController alloc] initWithStack:stack];
            viewReturn = optionsController;
            break;
        }
            
        default:
            break;
    }
    // if theres a nav controller return with nav controller, otherwise return object
    if (!navcontroller) {
        UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:viewReturn];
        return controller;
    }
    
    return viewReturn;
}
@end
