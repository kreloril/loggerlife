//
//  MSLifeLoggerRightViewController.m
//  LifeLogger
//
//  Created by John Mulvey on 12/30/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import "MSLifeLoggerLeftViewController.h"
#import <MSFeatureLifeLogger/MSFeatureLifeLogger.h>

@interface MSLifeLoggerLeftViewController ()
@property (nonatomic,strong) NSString* catagoryName;
@property (nonatomic,strong) NSArray* objects;
@end

@implementation MSLifeLoggerLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [MSFeatureLifeLoggerVisualSpec navigationBarColor];
   
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baseline_settings_white"] style:UIBarButtonItemStylePlain target:self action:@selector(onSelectOptions:)];
 
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.tableView.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"refreshcatagories" object:nil];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshTable];
}

-(void)refreshTable {
 
    self.tableViewItems = [MSFeatureLifeLogger instance].arrayOfCatagories;
    
    if (self.tableViewItems.count > 0) {
        
        NSInteger lastIndex = [MSFeatureLifeLogger instance].userSettings.lastCatagorySelectedIndex;
        NSInteger foundInteger = 0;
        
        for (int i = 0; i < self.tableViewItems.count;i++) {
        
            MSLifeLoggerCatagory* cat = self.tableViewItems[i];
            if ([cat catid].integerValue == lastIndex) {
                foundInteger = i;
                break;
            }
            
        }
      
         [[MSFeatureLifeLogger instance] changeCatagory:self.tableViewItems[foundInteger]];
      
        [self.tableView reloadData];
    }
    
}
-(void)onSelectOptions:(id)sender {
    UIAlertController* controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:[MSContentManager valueForKey:CKEY_ADD_CATAGORY] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addCatagory];
    }]];
    
    if ([MSFeatureLifeLogger instance].activeCatagory) {
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Edit Current Category" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MSObjectStack* stack = [MSObjectStack new];
        [stack setObject:@"Edit Catagory" key:@"title"];
        
        [stack setObject:LIFELOGGER_CURRENT_CATAGORY key:@"currentcatagory"];
        
        UINavigationController* nav = (UINavigationController*)[MSFeatureLifeLogger BuildScreenforStack:stack withNavController:nil screen:MSLifeLoggerScreenAddEditCatagory];
        
        UIPopoverPresentationController *popPresenter = [nav.viewControllers.firstObject popoverPresentationController];
        if (popPresenter) {
            popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp;
            popPresenter.sourceView = self.view;
        }
      
        if (IS_IPAD) {
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
        } else {
            nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
        }
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }]];
        
    }
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Change Category Order" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MSObjectStack* stack = [MSObjectStack new];
        UINavigationController* nav = (UINavigationController*)[MSFeatureLifeLogger BuildScreenforStack:stack withNavController:nil screen:MSLifeLoggerScreenChangeCatagoryOrder];
        
        UIPopoverPresentationController *popPresenter = [nav.viewControllers.firstObject popoverPresentationController];
    
        if (popPresenter) {
            popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp;
            popPresenter.sourceView = self.view;
        }
        
        if (IS_IPAD) {
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
        } else {
             nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
         }
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }]];
    
    
    [controller addAction:[UIAlertAction actionWithTitle:@"About" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MSObjectStack* stack = [MSObjectStack new];
        UINavigationController* nav = (UINavigationController*)[MSFeatureLifeLogger BuildScreenforStack:stack withNavController:nil screen:MSLifeLoggerScreenAbout];
        
        if (IS_IPAD) {
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
        } else {
             nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
        }
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
    }]];
 
    UIPopoverPresentationController *popPresenter = [controller
                                                     popoverPresentationController];
    if (popPresenter) {
        popPresenter.barButtonItem = self.navigationItem.leftBarButtonItem;
        popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp;
        popPresenter.sourceView = self.view;
    }
    
    if (IS_IPHONE) {
        [controller addAction:[UIAlertAction actionWithTitle:[MSContentManager valueForKey:CKEY_CANCEL] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
    }
    [self.navigationController presentViewController:controller animated:NO completion:nil];

}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return UIView.new;
}
-(void)addCatagory {
    
    MSObjectStack* stack = [MSObjectStack new];
    [stack setObject:@"Add Catagory" key:@"title"];
    [stack setObject:@"1" key:@"isNew"];
    
    UINavigationController* nav = (UINavigationController*)[MSFeatureLifeLogger BuildScreenforStack:stack withNavController:nil screen:MSLifeLoggerScreenAddEditCatagory];
        
    UIPopoverPresentationController *popPresenter = [nav.viewControllers.firstObject popoverPresentationController];
    if (popPresenter) {
        popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp;
        popPresenter.sourceView = self.view;
    }
    if (IS_IPAD) {
        nav.modalPresentationStyle = UIModalPresentationFormSheet;
    } else {
        nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    self.catagoryName = textField.text;
    
    if (self.catagoryName) {
        [textField resignFirstResponder];
    }
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   return [self textFieldShouldEndEditing:textField];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSLifeLoggerCatagory* cat = self.tableViewItems[indexPath.row];
    if (cat.name.length == 0)
        return 6;
    return 44;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MSLifeLoggerCatagory* cat = self.tableViewItems[indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = cat.name;
    

    
    if (cat == LIFELOGGER_CURRENT_CATAGORY) {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor darkGrayColor];
    } else  if (cell.textLabel.text.length == 0) {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MSLifeLoggerCatagory* cat = self.tableViewItems[indexPath.row];
    
    if (!cat)
        return;
    
    [[MSFeatureLifeLogger instance] changeCatagory:cat];
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

    UINavigationController* controller = (UINavigationController*)self.mm_drawerController.centerViewController;
    
     [controller.visibleViewController viewDidAppear:TRUE];
}

@end
