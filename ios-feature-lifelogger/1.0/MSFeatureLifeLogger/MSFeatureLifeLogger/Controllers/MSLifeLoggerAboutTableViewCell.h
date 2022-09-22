//
//  MSLifeLoggerAboutTableViewCell.h
//  LifeLogger
//
//  Created by John Mulvey on 8/30/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#import <MSMobilecore/MSMobilecore.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSLifeLoggerAboutTableViewCell : MSMobileCoreTableViewCell
@property (weak, nonatomic) IBOutlet GADBannerView *bannerview;
@property (weak, nonatomic) IBOutlet UIButton *buttonBannerButton;

@end

NS_ASSUME_NONNULL_END
