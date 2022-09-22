//
//  MSLifeLoggerAboutViewController.m
//  LifeLogger
//
//  Created by John Mulvey on 8/30/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

@import GoogleMobileAds;

#import "MSLifeLoggerAboutTableViewCell.h"
#import <MSFeatureLifeLogger/MSFeatureLifeLogger.h>
#import "MSLifeLoggerAboutViewController.h"


@interface MSLifeLoggerAboutViewController ()
@property(nonatomic, strong) GADBannerView *bannerView;
@property BOOL buttonTargetCrested;
@end

@implementation MSLifeLoggerAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [MSFeatureLifeLoggerVisualSpec navigationBarColor];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close:)];
    [self.tableView registerNib:[MSLifeLoggerAboutTableViewCell nib] forCellReuseIdentifier:@"cell"];
    self.tableView.scrollEnabled = false;
    
    self.bannerView = (GADBannerView*)[[MSFeatureLifeLogger instance] createBannerRequest:self screen:AddBannerScreenAbout];
  
    self.tableView.allowsSelection = false;
    
    if (self.bannerView)
        [self addBannerViewToView:self.bannerView];
   
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return UIView.new;
}

-(void)close:(id)sender {
    [self.navigationController dismissViewControllerAnimated:nil completion:nil];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSLifeLoggerAboutTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if ( [MSFeatureLifeLogger instance].userSettings.hasBannerAdsDisabled ) {
        cell.buttonBannerButton.hidden = true;
    } else {
    
        if (!self.buttonTargetCrested) {
            self.buttonTargetCrested = false;
            [cell.buttonBannerButton addTarget:self action:@selector(onTapButtonAdsoff:) forControlEvents:UIControlEventTouchUpInside];
        }
    
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 //   CGFloat windowsize = self.tableView.frame.size.height-self.bottomViewSpace-50;
    
    return 356;
}
-(void)onTapButtonAdsoff:(id)sender {
    
    UIAlertController* controller = [UIAlertController alertControllerWithTitle:@"Remove Banner Ads" message:@"Removiung banner Ads, will enable full screen Ads for a brief period of time; Are you sure you want to do this?" preferredStyle:UIAlertControllerStyleAlert];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        [[MSFeatureLifeLogger instance].userSettings toggleBannerAds];
        
        if (self.bannerView) {
            [self removeBannerView:self.bannerView];
            self.bannerView = nil;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
         
    }]];
    

    [self.navigationController presentViewController:controller animated:YES completion:nil];
    
}
@end
