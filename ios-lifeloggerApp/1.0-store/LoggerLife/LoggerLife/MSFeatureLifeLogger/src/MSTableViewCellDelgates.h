//
//  MSTableViewCellDelgates.h
//  LifeLogger
//
//  Created by John Mulvey on 6/11/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#ifndef MSTableViewCellDelgates_h
#define MSTableViewCellDelgates_h

typedef enum {
    MSControlTypeCheckBox,
    MSControlTypeButton,
    MSControlTypeEdit

} MSCellControlType;

typedef enum {
    MSControlActionSelected,
    MSControlActionComplete
    
} MSCellControlAction;


@protocol MSTableViewCellDelegate <NSObject>

@optional
-(void)onCellAction:(MSCellControlType)type action:(MSCellControlAction)action withCell:(UITableViewCell*)cell;

@end


#endif /* MSTableViewCellDelgates_h */
