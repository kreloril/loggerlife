//
//  MSDBQueryResponse.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/8/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import "MSObjectStack.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSDBQueryResponse : MSObjectStack
@property NSInteger resultCode;
@property (strong, nonatomic) NSMutableArray* arrayResults;
@end

NS_ASSUME_NONNULL_END
