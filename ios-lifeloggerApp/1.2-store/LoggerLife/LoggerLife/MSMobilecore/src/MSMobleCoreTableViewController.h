//
//  MSMobleCoreTableViewController.h
//  MSMobilecore
//
//  Created by John Mulvey on 12/29/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface MSMobleCoreTableViewController : MSMobileCoreBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray* tableViewItems;
@property (nonatomic,strong) MSTableView* tableView;
@property (readonly) CGFloat bottomViewSpace;
- (void)addBannerViewToView:(UIView *)bannerView;
- (void)removeBannerView:(UIView *)bannerView;
@end

NS_ASSUME_NONNULL_END
