//
//  MSLifeLoggerEditCatagoryViewController.m
//  LifeLogger
//
//  Created by John Mulvey on 4/1/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//
@import GoogleMobileAds;

#import "MSFeatureLifeLogger.h"
#import "MSLifeLoggerEditCatagoryViewController.h"
#import "MSLifeLoggerEditCatagoryTableViewCell.h"
#import "MSLifeLoggerLeftViewController.h"


@interface MSLifeLoggerEditCatagoryViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) MSLifeLoggerCatagory* activeCatagory;
@property (nonatomic,strong) GADBannerView* bannerView;
@property (weak,nonatomic) UITextField* textFieldName;
@property bool isNew;
@property bool hasSetAction;
@end

@implementation MSLifeLoggerEditCatagoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [MSFeatureLifeLoggerVisualSpec navigationBarColor];
    
    self.activeCatagory = [self.stack getObject:@"currentcatagory"];
    self.isNew = [self.stack boolForObject:@"isNew"];
    
    if (self.activeCatagory == nil && self.isNew) {
        MSLifeLoggerCatagory* newCat = [[MSLifeLoggerCatagory alloc] initWithCatagoryName:@"New Catagory"];
        self.activeCatagory  = newCat;
        self.isNew = true;
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: self.isNew ? @"Cancel" : @"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerNib:[MSLifeLoggerEditCatagoryTableViewCell nib] forCellReuseIdentifier:@"MSLifeLoggerEditCatagoryTableViewCell"];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.tableView.scrollEnabled = false;
    
    self.bannerView = (GADBannerView*)[[MSFeatureLifeLogger instance] createBannerRequest:self screen:AddBannerScreenEditCatagory];
    
    if (self.bannerView)
        [self addBannerViewToView:self.bannerView];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.activeCatagory = nil;
    self.isNew= false;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    float size =  self.tableView.frame.size.height-100;
    
    return size;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cellreturn = nil;
    
    if (indexPath.row == 0) {
        MSLifeLoggerEditCatagoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MSLifeLoggerEditCatagoryTableViewCell" forIndexPath:indexPath];
        cell.textViewCatagoryName.text = self.activeCatagory.name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.heightTextView.constant = 45;
        cell.textViewCatagoryName.delegate = self;
        self.textFieldName = cell.textViewCatagoryName;
        
        if ( self.hasSetAction == false)
            self.hasSetAction = true;
        
        if ( self.activeCatagory.alloweDelete == true || self.isNew == true) {
            
            if (self.isNew == false)
                [cell.buttonDeleteCategory addTarget:self action:@selector(deleteall:) forControlEvents:UIControlEventAllEvents];
            else {
                cell.buttonDeleteCategory.hidden = true;
            }
            
            cell.buttonStartEdit.hidden = false;
            
        } else {

            cell.buttonStartEdit.hidden = true;
            cell.buttonDeleteCategory.hidden = true;
            

        }
        
  /*      if (!cell.buttonOptionsActionSelectorSet) {
            [cell.butttonOptions addTarget:self action:@selector(onSelectActionOptions:) forControlEvents:UIControlEventTouchUpInside];
            cell.buttonOptionsActionSelectorSet = false;
        }*/
    
        cellreturn = cell;
    }
    
    
    
    return cellreturn;
    
}
-(void)onSelectActionOptions:(id)sender {
    MSObjectStack* optionStack = MSObjectStack.new;
    [optionStack setObject:@(self.isNew) key:@"isNew"];
   
    [self.navigationController pushViewController:[MSFeatureScreenBuilder BuildScreenforStack:optionStack withNavController:self.navigationController screen:MSLifeLoggerScreenCatagoryOptions] animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self.activeCatagory setObject:textField.text key:@"name"];
    return true;
}
-(void)close:(id)sender {
   
    [self.navigationController dismissViewControllerAnimated:TRUE completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshcatagories" object:nil];
    }];
    /*
    if (!self.isNew) {
      
    } else {
        self.mm_drawerController.rightDrawerViewController
    }*/
}
-(void)save:(id)sender {
   
    [self textFieldShouldReturn:self.textFieldName];
    
    if (!self.isNew) {
        [LIFELOGGER_CURRENT_DATABASE updateLifeloggerCatagory:self.activeCatagory];
    } else {
        [LIFELOGGER_CURRENT_DATABASE insertLifeLoggerCatagory:self.activeCatagory];
    }
    [self close:nil];
}

-(void)deleteall:(id)sender {
    UIAlertController* controller = [UIAlertController alertControllerWithTitle:@"Delete Catagory?" message:@"Deleting this catagory will move all logs to the Trash" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSelectorOnMainThread:@selector(performDeleteMove) withObject:nil waitUntilDone:NO];
    }]];
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
    
}


-(void)performDeleteMove {
    
    MSLifeLoggerCatagory* trashCat = [LIFELOGGER_CURRENT_DATABASE findCatagory:CATAGORY_DEFAULT_TRASH];
    MSLifeLoggerCatagory* currentCat = LIFELOGGER_CURRENT_DATABASE.activeCatagory;
    
    if (trashCat && currentCat) {
        [LIFELOGGER_CURRENT_DATABASE moveAllMessagesFromCatagory:currentCat to:trashCat];
        [LIFELOGGER_CURRENT_DATABASE removeCatagory:currentCat];
    }
    
    [LIFELOGGER_CURRENT_DATABASE changeCatagory:[LIFELOGGER_CURRENT_DATABASE findCatagory:CATAGORY_DEFAULT_DAILY]];
    [self close:nil];
}
@end
