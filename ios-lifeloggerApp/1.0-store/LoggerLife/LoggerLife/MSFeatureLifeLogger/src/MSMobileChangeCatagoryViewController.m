//
//  MSMobileChangeCatagoryViewController.m
//  LifeLogger
//
//  Created by John Mulvey on 3/19/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//
#import "MSFeatureLifeLogger.h"
#import "MSMobileChangeCatagoryViewController.h"

@interface MSMobileChangeCatagoryViewController ()
@property (nonatomic,weak) MSLifeLoggerLogEntry* entry;
@end

@implementation MSMobileChangeCatagoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableViewItems = [MSFeatureLifeLogger instance].arrayOfCatagories;
    self.entry = [self.stack getObject:@"editentry"];
    [self.tableView reloadData];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MSLifeLoggerCatagory* cat = self.tableViewItems[indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = cat.name;
    //  [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MSLifeLoggerCatagory* cat = self.tableViewItems[indexPath.row];
    
    NSString* idcat = cat.catid;
    [self.entry setObject:idcat key:@"ownerid"];
    [[MSFeatureLifeLogger instance] updateLogEntry:self.entry withReload:YES];
    [self.navigationController popToRootViewControllerAnimated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
