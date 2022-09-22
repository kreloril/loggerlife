//
//  MSMObileCoreBaseViewController.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/29/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#include "MSMobileCorePresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSMobileCoreBaseViewController : UIViewController

-(id)initWithStack:(MSObjectStack*)stack;
-(id)initWithPresenter:(MSMobileCorePresenter *)presenter stack:(MSObjectStack *)stack;

@property (nonatomic,strong) MSObjectStack *stack;
@property (nonatomic,strong) MSMobileCorePresenter *presenter;

@end

NS_ASSUME_NONNULL_END
