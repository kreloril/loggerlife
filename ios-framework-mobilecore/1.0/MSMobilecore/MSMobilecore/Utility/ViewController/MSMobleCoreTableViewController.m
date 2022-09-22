//
//  MSMobleCoreTableViewController.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/29/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <MSMobilecore/MSMobilecore.h>

@interface MSMobleCoreTableViewController ()
@property (nonatomic,strong) NSLayoutConstraint* topConstraint;
@property (nonatomic,strong) NSLayoutConstraint* botConstraint;
@property CGFloat tableHeightBottomSpace;
@end

@implementation MSMobleCoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rectbounds = self.view.bounds;
    CGRect rectSpace = CGRectZero;
    self.tableHeightBottomSpace = 0;
    if (self.stack) {
        
        NSArray* array = [self.stack arrayForObject:@"tableViewItems"];
        if (array)
            self.tableViewItems = array;
        
        UIColor* color = [self.stack getObject:@"bkViewColor"];
        
        if (color)
        {
            UIView *backView = [[UIView alloc] init];
            [backView setBackgroundColor:color];
            [self.tableView setBackgroundView:backView];
        }
        
        UIColor* viewBkColor = [self.stack getObject:@"viewBkColor"];
        if (viewBkColor)
            self.view.backgroundColor = viewBkColor;
        else
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.tableHeightBottomSpace = [[self.stack stringForObject:@"spaceFromBottom"] floatValue];
        rectbounds.size.height += self.tableHeightBottomSpace;
    }

    self.tableView = [[MSTableView alloc] initWithFrame:rectbounds];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
  //  [self.tableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    NSLayoutConstraint* topConst = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    self.topConstraint = topConst;
    
    NSLayoutConstraint* rightConst = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:rectSpace.origin.x];
    
    NSLayoutConstraint* leftConst = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:rectSpace.size.width];
    
    NSLayoutConstraint* botConst = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:rectSpace.size.height + self.tableHeightBottomSpace];
    self.botConstraint = botConst;
     topConst.active = true;
    rightConst.active = true;
    leftConst.active = true;
    botConst.active = true;
    
    [self.view addConstraint:topConst];
    [self.view addConstraint:rightConst];
    [self.view addConstraint:leftConst];
    [self.view addConstraint:botConst];
     
     self.tableView.delegate = self;
     self.tableView.dataSource = self;
     
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
     
     self.tableViewItems = @[];
    
   
    

}
-(CGFloat)bottomViewSpace {
    return self.tableHeightBottomSpace;
}
- (void)addBannerViewToView:(UIView *)bannerView {
    
    // create the space for banner.
    
    self.tableHeightBottomSpace = -(bannerView.frame.size.height + 45);
    
    self.botConstraint.constant = self.tableView.bounds.size.height + self.tableHeightBottomSpace;
    CGRect tabeframe = self.tableView.frame;
    tabeframe.size.height = tabeframe.size.height + self.tableHeightBottomSpace;
    self.tableView.frame = tabeframe;
    
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view bringSubviewToFront:bannerView];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.bottomLayoutGuide
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}

- (void)removeBannerView:(UIView *)bannerView {
    
    [bannerView removeFromSuperview];
    self.tableHeightBottomSpace = 0;
    self.botConstraint.constant = self.tableView.bounds.size.height + self.tableHeightBottomSpace;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString* text = self.tableViewItems[indexPath.row];

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = text;
  //  [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewItems.count;
}


@end
