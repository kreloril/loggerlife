//
//  MSMObileCoreBaseViewController.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/29/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//




NS_ASSUME_NONNULL_BEGIN

@interface MSMobileCoreBaseViewController : UIViewController

-(id)initWithStack:(MSObjectStack*)stack;

@property (nonatomic,strong) MSObjectStack* stack;

@end

NS_ASSUME_NONNULL_END
