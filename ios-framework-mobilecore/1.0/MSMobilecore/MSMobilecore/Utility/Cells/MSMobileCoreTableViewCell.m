//
//  MSMobileCoreTableViewCell.m
//  MSMobilecore
//
//  Created by John Mulvey on 1/8/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#import <MSMobilecore/MSMobilecore.h>


@implementation MSMobileCoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(UINib*)nib {
    return [UINib nibWithNibName:[[self class] description]  bundle:[NSBundle bundleForClass:[self class]]];
}

@end
