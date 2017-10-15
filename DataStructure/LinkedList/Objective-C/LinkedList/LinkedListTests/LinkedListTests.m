//
//  LinkedListTests.m
//  LinkedListTests
//
//  Created by ShannonChen on 2017/10/15.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCLinkedList.h"

@interface LinkedListTests : XCTestCase

@end

@implementation LinkedListTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    SCLinkedList <NSString *> *list = [[SCLinkedList alloc] init];
    [list map:^NSString * _Nonnull(NSString * _Nonnull value) {
        return value.lowercaseString;
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
