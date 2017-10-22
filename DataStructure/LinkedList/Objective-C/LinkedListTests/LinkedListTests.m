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
    
    SCLinkedList <NSString *> *linkedList = [[SCLinkedList alloc] init];
    XCTAssertTrue(linkedList.isEmpty);
    XCTAssertNil(linkedList.first);
    XCTAssertNil(linkedList.last);
    
    
    [linkedList appendNodeWithValue:@"Shannon"];
    XCTAssertFalse(linkedList.isEmpty);
    XCTAssertEqual(linkedList.first.value, @"Shannon");
    XCTAssertEqual(linkedList.last.value, @"Shannon");


    [linkedList appendNodeWithValue:@"Michael"];
    XCTAssertEqual(linkedList.first.value, @"Shannon");
    XCTAssertEqual(linkedList.last.value, @"Michael");
    
    XCTAssertNil(linkedList.first.previous);
    XCTAssertNotNil(linkedList.first.next.value);
    XCTAssertNotNil(linkedList.last.previous.value);
    XCTAssertNil(linkedList.last.next);
    
    XCTAssertEqual([linkedList nodeAtIndex:0].value, @"Shannon");
    XCTAssertEqual([linkedList nodeAtIndex:1].value, @"Michael");
    XCTAssertNil([linkedList nodeAtIndex:2]);
    
    XCTAssertEqual(linkedList[0].description, @"Shannon");
    XCTAssertEqual(linkedList[1].description, @"Michael");
//    XCTAssertNil(linkedList[2]);  // crash
    
    
    [linkedList insertNodeWithValue:@"Lisa" atIndex:1];
    XCTAssertEqual(linkedList[0].description, @"Shannon");
    XCTAssertEqual(linkedList[1].description, @"Lisa");
    XCTAssertEqual(linkedList[2].description, @"Michael");


}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
