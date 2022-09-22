//
//  MSLifeLoggerEditCatagoryTableViewCell.h
//  LifeLogger
//
//  Created by John Mulvey on 4/4/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#import "MSMobilecore.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSLifeLoggerEditCatagoryTableViewCell : MSMobileCoreTableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textViewCatagoryName;
- (IBAction)buttonEditCatagory:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonDeleteCategory;
@property (weak, nonatomic) IBOutlet UIButton *butttonOptions;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTextView;
@property (weak, nonatomic) IBOutlet UIButton *buttonStartEdit;
@property bool buttonOptionsActionSelectorSet;
@end

NS_ASSUME_NONNULL_END
