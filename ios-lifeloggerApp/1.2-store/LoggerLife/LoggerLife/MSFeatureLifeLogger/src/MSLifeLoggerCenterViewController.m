//
//  MSLifeLoggerCenterViewController.m
//  LifeLogger
//
//  Created by John Mulvey on 12/29/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

@import GoogleMobileAds;

#import "MSLifeLoggerCenterViewController.h"
//#import "MMDrawerBarButtonItem.h"
#import "TextViewTableViewCell.h"
#import "CenterTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "MSFeatureLifeLogger.h"

@interface MSLifeLoggerCenterViewController ()
@property (nonatomic,strong) NSArray* objects;
@property(nonatomic, strong) GADBannerView *bannerView;
@end

@implementation MSLifeLoggerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // NSLog(@"%@", self.navigationController.navigationBar);
    [self.tableView registerNib:[CenterTableViewCell nib] forCellReuseIdentifier:@"CenterViewCell"];
    [self.tableView registerNib:[HeaderTableViewCell nib] forCellReuseIdentifier:@"HeaderCell"];
    self.navigationController.navigationBar.barTintColor = [MSFeatureLifeLoggerVisualSpec navigationBarColor];
    [self setupLeftMenuButton];
   
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
   
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self refreshTable];
    
   

    self.bannerView = (GADBannerView*)[[MSFeatureLifeLogger instance] createBannerRequest:self screen:AddBannerScreenMain];
    
    if (self.bannerView)
        [self addBannerViewToView:self.bannerView];
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if ([MSFeatureLifeLogger instance].featureDataBase.activeCatagory) {
        [self setTitle:[NSString stringWithFormat:@"%@",[MSFeatureLifeLogger instance].featureDataBase.activeCatagory.name]];
         self.objects = [MSFeatureLifeLogger instance].featureDataBase.arrayOfActiveCatagoryObjects;
    } else {
        self.objects = nil;
    }
    NSLog(@"%@",self.objects);
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    [self setupRightMenuButton];
    [self.tableView reloadData];
    
}

-(void)refreshTable {
    
    self.tableViewItems = [MSFeatureLifeLogger instance].featureDataBase.arrayOfCatagories;
    
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
        
        [[MSFeatureLifeLogger instance].featureDataBase changeCatagory:self.tableViewItems[foundInteger]];
        
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    HeaderTableViewCell* cell =  [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    
    MSLifeLoggerSortingIndex* entry = self.objects[section];
    NSString* entryDate = entry.headerString;// [MSFeatureLifeLogger headerFormattedTime:  entry.allKeys[0]];
    
    cell.textLabel.text = entryDate;
    cell.textLabel.textColor = [ UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    // if (section == 0)
    // return 0;
    
    return 22;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.objects)
        return 0;
    
    MSLifeLoggerSortingIndex* entry = self.objects[section];
    NSArray* all = entry.entryLogs;
    
    return all.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.objects == nil ? 0 : self.objects.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSLifeLoggerLogEntry* logentry = [self logEntryForIndex:indexPath];
    MSLifeLoggerLogEntryData* data = logentry.entryData[0];
    
    NSString* string = data.logEntryData;
    CGSize sizeFrame = CGSizeMake(self.tableView.frame.size.width-20, INT_MAX);
    CGRect frame = [string boundingRectWithSize:sizeFrame options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];

    return frame.size.height+50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CenterTableViewCell* cell = nil;

    MSLifeLoggerLogEntry* logentry = [self logEntryForIndex:indexPath];
    MSLifeLoggerLogEntryData* data = logentry.entryData[0];
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"CenterViewCell"];
    cell.textLogLabel.text = data.logEntryData;
    cell.timeStampLabel.text = [MSFeatureDateFormatting formattedTime:logentry.timestamp];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    switch (logentry.entryState) {
        case MSLifeLoggerEntryLogStateUnFlagged:
        {
            cell.imageViewDone.hidden = false;
            [cell.imageViewDone setImage:[UIImage imageNamed:@"cancel"]];
            break;
        }
            
        case MSLifeLoggerEntryStateFlagged: {
            cell.imageViewDone.hidden = false;
            [cell.imageViewDone setImage:[UIImage imageNamed:@"done"]];
            break;
        }
        case MSLifeLoggerEntryStateNone: {
            cell.imageViewDone.hidden = true;
            break;
        }
        default:
            break;
    }
    
    return cell;
}
-(MSLifeLoggerLogEntry*)logEntryForIndex:(NSIndexPath*)indexPath {
    
    MSLifeLoggerSortingIndex* entry = self.objects[indexPath.section];
    NSArray* all = entry.entryLogs;
    return all[indexPath.row];
}
-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
-(void)setupRightMenuButton {
    
    
    NSMutableArray* array = NSMutableArray.new;
    if ([LIFELOGGER_CURRENT_CATAGORY.name isEqualToString:CATAGORY_DEFAULT_TRASH] == FALSE) {
        UIBarButtonItem* addbuttom = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"outline_add_white"] style:UIBarButtonItemStylePlain target:self action:@selector(onActionAddButton:)];
        [array addObject:addbuttom];
        
         UIBarButtonItem* trashdeleteall = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baseline_delete_move"] style:UIBarButtonItemStylePlain target:self action:@selector(onActionDeleteAllMessages:)];
        [array addObject:trashdeleteall];
    } else {
        UIBarButtonItem* trashdeleteall = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"baseline_delete"] style:UIBarButtonItemStylePlain target:self action:@selector(onActionDeleteAllMessages:)];
        [array addObject:trashdeleteall];
    }
    
    self.navigationItem.rightBarButtonItems = array;
}
-(void)onActionDeleteAllMessages:(id)sender {
    
    
   
    __block bool istrash = [LIFELOGGER_CURRENT_CATAGORY.name isEqualToString:CATAGORY_DEFAULT_TRASH] == TRUE;
    NSString* title = @"Move all messages to Trash?";
    
    if (istrash)
        title = @"Permanatly Delete all mesaages?";
    
    if (self.objects.count == 0)
        title = @"No Logs to Delete";
    
    UIAlertController* controller = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    
    if (self.objects.count > 0) {
    
    [controller addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    [controller addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        if (istrash) {
            [LIFELOGGER_CURRENT_DATABASE removeAllMessagesFromCatagory:LIFELOGGER_CURRENT_CATAGORY];
        } else {
            [LIFELOGGER_CURRENT_DATABASE moveAllMessagesFromCatagory:LIFELOGGER_CURRENT_CATAGORY to: [LIFELOGGER_CURRENT_DATABASE findCatagory:CATAGORY_DEFAULT_TRASH]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [LIFELOGGER_CURRENT_DATABASE changeCatagory:LIFELOGGER_CURRENT_CATAGORY];
            self.objects = LIFELOGGER_CURRENT_DATABASE.currentObjectData;
            [self.tableView reloadData];
        });
    }]];
        
    } else {
        [controller addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    }
    
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}
-(void)onActionAddButton:(id)sender {

    if (LIFELOGGER_CURRENT_DATABASE.activeCatagory == nil) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        return;
    }
    
    MSObjectStack* stack2 = [MSObjectStack new];
    [stack2 setObject:[MSContentManager valueForKey:@"Add Log"] key:@"title"];
  
    [self.navigationController pushViewController:[MSFeatureScreenBuilder BuildScreenforStack:stack2 withNavController:self.navigationController screen:MSLifeLoggerScreenAddEditEvent] animated:YES];
}
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MSLifeLoggerLogEntry* entry = [self logEntryForIndex:indexPath];
 
    if (entry) {
        MSObjectStack* stack2 = [MSObjectStack new];
  
        [stack2 setObject:[MSContentManager valueForKey:@"Edit Log"] key:@"title"];
        [stack2 setObject:entry key:@"editentry"];

        [self.navigationController pushViewController:[MSFeatureScreenBuilder BuildScreenforStack:stack2 withNavController:self.navigationController screen:MSLifeLoggerScreenAddEditEvent] animated:YES];
        
    }
}

@end
