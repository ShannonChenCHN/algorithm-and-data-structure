//
//  SCLinkedListNode.m
//  LinkedList
//
//  Created by ShannonChen on 2017/10/15.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCLinkedListNode.h"

@implementation SCLinkedListNode

- (instancetype)initWithValue:(id)value {

    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (NSString *)description {
    return self.value;
}

@end
