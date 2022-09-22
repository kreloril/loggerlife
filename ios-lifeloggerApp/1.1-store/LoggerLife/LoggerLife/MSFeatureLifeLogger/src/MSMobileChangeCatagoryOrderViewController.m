//
//  MSMobileChangeCatagoryViewController.m
//  LifeLogger
//
//  Created by John Mulvey on 3/19/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

@import GoogleMobileAds;
#import "MSFeatureLifeLogger.h"
#import "MSMobileChangeCatagoryOrderViewController.h"

@interface MSMobileChangeCatagoryOrderViewController ()
@property (nonatomic,strong) NSMutableArray* catagoryArray;
@property (nonatomic,strong) GADBannerView* bannerView;
@end

@implementation MSMobileChangeCatagoryOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    
    self.navigationController.navigationBar.barTintColor = [MSFeatureLifeLoggerVisualSpec navigationBarColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
 
    NSArray* array  = LIFELOGGER_CURRENT_DATABASE.arrayOfCatagories;
    self.catagoryArray = [[NSMutableArray alloc] initWithArray:array];
    self.tableView.editing = true;
    [self.tableView reloadData];
    
    self.bannerView = (GADBannerView*)[[MSFeatureLifeLogger instance] createBannerRequest:self screen:AddBannerScreenChangeOrder];
    
    if (self.bannerView)
        [self addBannerViewToView:self.bannerView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

-(void)close:(id)sender {
    [self.navigationController dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)save:(id)sender {
    
    for (int i = 0; i < self.catagoryArray.count-1 ; i++) {
        MSLifeLoggerCatagory* cat = self.catagoryArray[i];
        [cat.data setObject:[@(i) stringValue] key:CATAGORY_PROPERTY_SORTINGORDER];
        [LIFELOGGER_CURRENT_DATABASE updateLifeloggerCatagory:cat];
    }
    
    [self close:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MSLifeLoggerCatagory* cat = self.catagoryArray[indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = cat.name;
    //  [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.catagoryArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}
-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return false;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    MSLifeLoggerCatagory* cat = self.catagoryArray[indexPath.row];
    
    if ([cat.name isEqualToString:@"Trash"])
        return false;
    return true;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    MSLifeLoggerCatagory* cat = self.catagoryArray[sourceIndexPath.row];
    
    [self.catagoryArray removeObject:cat];
    [self.catagoryArray insertObject:cat atIndex:destinationIndexPath.row];
}
@end
