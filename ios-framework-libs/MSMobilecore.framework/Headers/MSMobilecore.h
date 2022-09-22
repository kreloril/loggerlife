//
//  MSMobilecore.h
//  MSMobilecore
//
//  Created by John Mulvey on 5/18/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "MSSychronizedMutableDictionary.h"
#import "MSObjectStack.h"
#import "MSMobileCoreResourceDelegate.h"



@interface MSMobileCore : NSObject

+(id)instance;
@property (nonatomic,weak) id<MSMobileCoreResourceDelegate> coreResourceDelegate;
@end
