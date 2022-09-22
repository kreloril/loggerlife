//
//  MSMobilecoreTests.m
//  MSMobilecoreTests
//
//  Created by John Mulvey on 5/18/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSMobilecore.h"

@interface TestsMSSychronizedMutableDict : XCTestCase

@end

@implementation TestsMSSychronizedMutableDict

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMutableDict {
    
    MSObjectStack* stack = [[MSObjectStack alloc] init];
    [stack setObject:@"derp" key:@"Derp"];
    NSLog(@"%@",stack);
    
    NSString* jsonstring = stack.dataWithJSONObject;
    
    NSLog(@"%@",jsonstring);
    
    MSObjectStack* newstack = [[MSObjectStack alloc] init];
    
    [newstack JSONObjectWithData:jsonstring];
    
    NSLog(@"%@",newstack);
    
}


@end
