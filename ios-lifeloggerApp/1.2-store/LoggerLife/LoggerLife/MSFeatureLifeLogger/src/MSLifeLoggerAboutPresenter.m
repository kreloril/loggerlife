//
//  MSLifeLoggerAboutPresenter.m
//  LoggerLife
//
//  Created by John Mulvey on 8/12/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//

#import "MSMobileCore.h"
#import "MSFeatureLifeLogger.h"
#import "MSLifeLoggerAboutPresenter.h"

@implementation MSLifeLoggerAboutPresenter
-(NSString *)navigationTitle {
    return [MSContentManager valueForKey:CKEY_ABOUT_TITLE];
}

-(NSString *)buttonCloseText {
    return [MSContentManager valueForKey:CKEY_CLOSE];
}

@end
