//
//  MSMobileCoreTableViewCell.h
//  MSMobilecore
//
//  Created by John Mulvey on 1/8/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface MSMobileCoreTableViewCell : UITableViewCell

@property (nonatomic,strong) MSObjectStack* stack;
+(UINib*)nib;
@end

NS_ASSUME_NONNULL_END
