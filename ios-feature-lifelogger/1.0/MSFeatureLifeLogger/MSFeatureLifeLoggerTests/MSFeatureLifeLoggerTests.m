//
//  MSFeatureLifeLoggerTests.m
//  MSFeatureLifeLoggerTests
//
//  Created by John Mulvey on 5/19/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <MSFeatureLifeLogger/MSFeatureLifeLogger.h>
#import <XCTest/XCTest.h>

@interface MSFeatureLifeLoggerTests : XCTestCase

@end

@implementation MSFeatureLifeLoggerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDate {
    
    NSLog(@"%@",[MSFeatureLifeLogger formattedTimeStamp:@"1551349401325"]);
    
}

@end
