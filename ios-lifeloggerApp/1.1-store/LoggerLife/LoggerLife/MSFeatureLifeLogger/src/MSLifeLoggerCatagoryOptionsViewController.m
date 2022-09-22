//
//  MSLifeLoggerCatagoryOptionsViewController.m
//  LoggerLife
//
//  Created by John Mulvey on 10/18/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#import "MSFeatureLifeLogger.h"
#import "MSLifeLoggerCatagoryOptionsViewController.h"

@interface MSLifeLoggerCatagoryOptionsViewController ()
@property bool isNew;
@end

@implementation MSLifeLoggerCatagoryOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNew = [self.stack boolForObject:@"isNew"];
    if (!self.isNew)  {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Export" style:UIBarButtonItemStylePlain target:self action:@selector(onSelectExportLog:)];
    }
    
    
    // Do any additional setup after loading the view.
}
-(void) onSelectExportLog:(id)sender {
    MSObjectStack* stack = MSObjectStack.new;
    UIViewController* controller = [MSFeatureScreenBuilder BuildScreenforStack:stack withNavController:self.navigationController screen:MSLifeLoggerScreenExportCatagory];
    
    [self.navigationController pushViewController:controller animated:YES];
}



@end
