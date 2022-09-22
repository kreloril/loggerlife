//
//  TextViewTableViewCell.h
//  LifeLogger
//
//  Created by John Mulvey on 1/8/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#import "MSMobilecore.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextViewTableViewCell : MSMobileCoreTableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

NS_ASSUME_NONNULL_END
