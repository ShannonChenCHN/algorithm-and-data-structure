//
//  ViewController.m
//  LinkedList
//
//  Created by ShannonChen on 2017/10/15.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "ViewController.h"
#import "SCLinkedList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SCLinkedList *linkedList = [[SCLinkedList alloc] init];
    [linkedList appendNodeWithValue:@"Shannon"];
    [linkedList appendNodeWithValue:@"Michael"];
    [linkedList insertNodeWithValue:@"Lisa" atIndex:1];
    
    NSLog(@"%li\n", linkedList.count);
    NSLog(@"%@\n", linkedList[0]);
    NSLog(@"%@\n", linkedList[1]);
    NSLog(@"%@\n", linkedList[2]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
