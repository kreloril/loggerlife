//
//  MSLifeLoggerExportLogViewController.m
//  LifeLogger
//
//  Created by John Mulvey on 8/30/19.
//  Copyright © 2019 mulvsoft. All rights reserved.
//

#import "CenterTableViewCell.h"
#import "TextViewTableViewCell.h"
#import "MSLifeLoggerExportLogViewController.h"
#import <MSFeatureLifeLogger/MSFeatureLifeLogger.h>

@interface MSLifeLoggerExportLogViewController ()
@property (nonatomic,strong) NSArray* objects;
@property (nonatomic,strong) NSMutableString* exportText;
@end

@implementation MSLifeLoggerExportLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[CenterTableViewCell nib] forCellReuseIdentifier:@"CenterViewCell"];
    
    if ([MSFeatureLifeLogger instance].activeCatagory) {
           [self setTitle:[NSString stringWithFormat:@"%@",[MSFeatureLifeLogger instance].activeCatagory.name]];
            self.objects = [MSFeatureLifeLogger instance].arrayOfActiveCatagoryObjects;
       } else {
           self.objects = nil;
       }
    NSLog(@"%@",self.objects);
       
    self.exportText = NSMutableString.new;
  //  [self.exportText appendString:[self.objects description]];
    [self.exportText appendString:@"\n\n"];
    for ( int i = 0; i < self.objects.count ; i++) {
        NSDictionary* objectEntry = self.objects[i];
        NSArray* arrayEntrys = objectEntry.allValues;
        [self.exportText appendString:[MSFeatureLifeLogger formattedTime:objectEntry.allKeys[i]]];
        [self.exportText appendString:@"\n\n"];
        for (int l = 0; i < arrayEntrys.count;i++) {
           // MSLifeLoggerLogEntry* entry = objectEntry.v
            MSLifeLoggerLogEntryData* data = arrayEntrys[l];

            [self.exportText appendString:data.logEntryData];
            [self.exportText appendString:@"\n\n"];
            
        }
      //  cell.textLogLabel.text = data.logEntryData;
        //   cell.timeStampLabel.text = [MSFeatureLifeLogger formattedTime:logentry.timestamp];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(onButtonShare:)];
   
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
-(void)onButtonShare:(id)sender {
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return UIView.new;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* string = self.exportText;
      CGSize sizeFrame = CGSizeMake(self.tableView.frame.size.width-20, INT_MAX);
      CGRect frame = [string boundingRectWithSize:sizeFrame options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];

      return frame.size.height+50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CenterTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CenterViewCell"];
    cell.textLogLabel.text = self.exportText;

    cell.textLabel.text= self.exportText;
   // cell.textLogLabel.hidden = true;
   // cell.textLogLabel.text = @"";
    return cell;
}
@end
