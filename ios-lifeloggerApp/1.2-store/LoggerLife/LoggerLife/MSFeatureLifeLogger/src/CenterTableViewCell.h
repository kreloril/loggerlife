//
//  CenterTableViewCell.h
//  LifeLogger
//
//  Created by John Mulvey on 2/25/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//


#import "MSMobilecore.h"
NS_ASSUME_NONNULL_BEGIN

@interface CenterTableViewCell : MSMobileCoreTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLogLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage;

@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTimeStamp;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightImage;
@property (weak, nonatomic) IBOutlet UIView *viewCellContent;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewDone;



@end

NS_ASSUME_NONNULL_END
