//
//  MSLifeLoggerRightViewController.h
//  LifeLogger
//
//  Created by John Mulvey on 12/30/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//
#import <MSFeatureLifeLogger/MSFeatureLifeLogger.h>
#import <MSMobilecore/MSMobilecore.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSLifeLoggerLeftViewController : MSMobleCoreTableViewController<UITextFieldDelegate>
-(void)refreshTable;
@end

NS_ASSUME_NONNULL_END
