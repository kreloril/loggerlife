//
//  MSMObileCoreBaseViewController.m
//  MSMobilecore
//
//  Created by John Mulvey on 12/29/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//


#import "MSMobileCore.h"

@interface MSMobileCoreBaseViewController ()

@end

@implementation MSMobileCoreBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 /*(   if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } */
    if (self.stack)  {
     
        NSString* title = [self.stack stringForObject:@"title"];
        
        if (title && self.navigationItem)
            self.navigationItem.title = title;
        
    }
    
    // Do any additional setup after loading the view.
}

-(id)initWithPresenter:(MSMobileCorePresenter *)presenter stack:(MSObjectStack *)stack {
    self = [super init];
    self.stack = stack;
    self.presenter = presenter;
    return self;
}
-(id)initWithStack:(MSObjectStack*)stack {
 
    self = [super init];
    self.stack = stack;
    return self;
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
