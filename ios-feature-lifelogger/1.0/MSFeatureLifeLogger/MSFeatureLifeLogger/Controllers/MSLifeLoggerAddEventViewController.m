//
//  MSLifreLoggerAddEventViewController.m
//  LifeLogger
//
//  Created by John Mulvey on 1/8/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//
@import GoogleMobileAds;


#import "MSLifeLoggerAddEventViewController.h"
#import "TextViewTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "SpacingTableViewCell.h"
#import <MSFeatureLifeLogger/MSFeatureLifeLogger.h>

@interface MSLifeLoggerAddEventViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) MSLifeLoggerLogEntry* entry;
@property bool editMode;
@property bool oneTimeSetCellText;
@property (nonatomic,weak) UITextView* loggingTextView;
@property (nonatomic,strong) UIAlertController* alertController;
@property (nonatomic,strong) GADBannerView* bannerView;
@end

@implementation MSLifeLoggerAddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   [self.tableView registerNib:[TextViewTableViewCell nib] forCellReuseIdentifier:@"TextViewCell"];
   [self.tableView registerNib:[HeaderTableViewCell nib] forCellReuseIdentifier:@"HeaderCell"];
   [self.tableView registerNib:[SpacingTableViewCell nib] forCellReuseIdentifier:@"SpacingCell"];

   
  
 //   [self.entry setObject: [NSString stringWithFormat:@"%f",[NSDate date].timeIntervalSinceReferenceDate] key:@"timestamp"];
    
    self.entry = [self.stack getObject:@"editentry"];
    NSString* buttonText = @"Log";
    if (!self.entry) {
    
        self.entry = [[MSLifeLoggerLogEntry alloc] init];
        [self.entry setObject:@"" key:@"data"];
        [self.entry setObject:[MSFeatureLifeLogger instance].activeCatagory.catid key:@"ownerid"];
      
    
    } else {
        buttonText = @"Edit";
        self.editMode = true;
        self.oneTimeSetCellText = true;
    }
    
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:buttonText style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton:)];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.bannerView = (GADBannerView*)[[MSFeatureLifeLogger instance] createBannerRequest:self screen:AddBannerScreenEntryScreen];
    
    if (self.bannerView)
        [self addBannerViewToView:self.bannerView];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

-(void)processEditOptions {

    UIAlertController* controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    self.alertController = controller;
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.alertController = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.entry.entryData[0] setObject:self.loggingTextView.text key:@"logEntryData"];
            [[MSFeatureLifeLogger instance] updateLogEntry:self.entry withReload:true];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.alertController = nil;
      
        dispatch_async(dispatch_get_main_queue(), ^{
        
        [[MSFeatureLifeLogger instance] removeLogEntry:self.entry];
        [self.navigationController popViewControllerAnimated:YES];
         });
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Set Finished" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.entry.entryState == MSLifeLoggerEntryStateFlagged) {
            [self.entry setLogEntryState:MSLifeLoggerEntryStateNone];
        } else {
            [self.entry setLogEntryState:MSLifeLoggerEntryStateFlagged];
        }
        
         [[MSFeatureLifeLogger instance] updateLogEntry:self.entry withReload:false];
        
    }]];

    [controller addAction:[UIAlertAction actionWithTitle:@"Set Unfinished" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.entry.entryState == MSLifeLoggerEntryLogStateUnFlagged) {
            [self.entry setLogEntryState:MSLifeLoggerEntryStateNone];
        } else {
            [self.entry setLogEntryState:MSLifeLoggerEntryLogStateUnFlagged];
        }
        
         [[MSFeatureLifeLogger instance] updateLogEntry:self.entry withReload:false];
        
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"Move to Catagory.." style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MSObjectStack* stack2 = [MSObjectStack new];
        [stack2 setObject:self.entry key:@"editentry"];
        [self.navigationController pushViewController:[MSFeatureLifeLogger BuildScreenforStack:stack2 withNavController:self.navigationController screen:MSLifeLoggerScreenChangeCatagory] animated:YES];
        
    }]];

    
     if (IS_IPHONE) {
         [controller addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
             self.alertController = nil;

         }]];
     
         [self presentViewController:controller animated:NO completion:nil];
         return;
     }
    
    UIPopoverPresentationController *popPresenter = [controller
                                                     popoverPresentationController];
    if (popPresenter) {
        popPresenter.barButtonItem = self.navigationItem.rightBarButtonItem;
        popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp;
        popPresenter.sourceView = self.view;
    }
 
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)onRightButton:(id)sender {
    if (self.editMode) {
        [self processEditOptions];
        return;
    }
    
    
    [self.entry addLogEntryData:[MSLifeLoggerLogEntryData logEntry:LogEntryDataTypeText withLogData:self.loggingTextView.text]];
    
    NSLog(@"%@",self.entry);
    
    [[MSFeatureLifeLogger instance] insertLogEntry:self.entry];
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    HeaderTableViewCell* cell =  [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];

    if (section == 0) {
    
        cell.textLabel.text = [MSFeatureLifeLogger formattedTimeStamp:self.entry.timestamp];
        NSLog(@"%@ %@",[MSFeatureLifeLogger formattedTimeStamp:self.entry.timestamp],self.entry.timestamp);
        cell.textLabel.textColor = [ UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *singleTapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [singleTapRecogniser setDelegate:self];
        singleTapRecogniser.numberOfTouchesRequired = 1;
        singleTapRecogniser.numberOfTapsRequired = 1;
        [cell addGestureRecognizer:singleTapRecogniser];

    }
    
    return cell;
}
-(NSTimeInterval)stripTime:(NSTimeInterval)time {
    return time;
}
- (void) handleGesture:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"handleGesture:");
    
    __block UIDatePicker* datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    NSLocale *locale = [NSLocale currentLocale];
    [datePicker setLocale:locale];
    datePicker.calendar = [locale objectForKey:NSLocaleCalendar];
    
    NSTimeInterval newtime = [self.entry.timestamp doubleValue];
    newtime = [self stripTime:newtime];
  ////  NSString* str = [@([self stripTime:datePicker.date.timeIntervalSinceReferenceDate]) stringValue];
  //  NSLog(@"%@ %@",[MSFeatureLifeLogger formattedTimeStamp:str],[MSFeatureLifeLogger formattedTimeStamp:self.entry.timestamp]);
    [datePicker setDate:[NSDate dateWithTimeIntervalSince1970:newtime]];

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n" message:nil    preferredStyle: UIAlertControllerStyleActionSheet ];
    
    [alert.view addSubview:datePicker];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        self.alertController = nil;

        NSTimeInterval timint = [self stripTime:datePicker.date.timeIntervalSince1970];
        NSNumber* time = [NSNumber numberWithDouble:timint];
        
        [self.entry setObject:[time stringValue]  key:@"timestamp"];
        
        [self.tableView reloadData];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        self.alertController = nil;
        
    }]];
    
 
    if (IS_IPAD) {
        [alert.popoverPresentationController setPermittedArrowDirections:0];
        CGRect rect = self.view.frame;
        rect.origin.x = 0;//(self.view.frame.size.width  - 320) /2;
        rect.origin.y = 0;//(self.view.frame.size.height  )/ 200;
        alert.popoverPresentationController.sourceView = self.tableView;


        alert.popoverPresentationController.sourceRect = rect;
        
        ///[self.navigationController popToViewController:alert animated:NO];
    
       

    }
    self.alertController = alert;
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator

{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    if (self.alertController) {
    
        [self.alertController dismissViewControllerAnimated:false completion:nil];
        self.alertController = nil;
    }
}
-(void)showSelectedDate:(id)sender {

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

   // if (section == 0)
       // return 0;
    
    return 44;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return [[UIView alloc] initWithFrame:CGRectZero];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  if (indexPath.section == 0)
     //   return 0;
    
    return 400;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MSMobileCoreTableViewCell* cell = nil;
    
    if (indexPath.section == 0) {
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell"];
        self.loggingTextView = ((TextViewTableViewCell*)cell).textView;
        ((TextViewTableViewCell*)cell).textView.delegate = self;
        ((TextViewTableViewCell*)cell).textView.textColor = [UIColor blackColor];
        if (self.oneTimeSetCellText) {
            self.oneTimeSetCellText = false;
            self.loggingTextView.text = self.entry.entryData[0].logEntryData;
        }
    } else {
     
        cell = [tableView dequeueReusableCellWithIdentifier:@"SpacingCell"];
    }
    
    return cell;
}

- (void)textViewDidEndEditing:(UITextView *)textView {

    [textView resignFirstResponder];
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
