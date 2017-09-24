//
//  SCStack.m
//  ObjC
//
//  Created by ShannonChen on 2017/9/24.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "SCStack.h"

@interface SCStack ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation SCStack

#pragma mark - Life Cycle
- (instancetype)init {
    
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Operation
- (void)push:(id)newObject {
    
    if (newObject) {
        [self.array addObject:newObject];
    }
    
}

- (nullable id)pop {
    
    id lastObject = self.array.lastObject;
    
    [self.array removeLastObject];
    
    return lastObject;
}


#pragma mark - Getter

- (nullable id)top {
    return self.array.lastObject;
}

- (NSUInteger)count {
    return self.array.count;
}

- (BOOL)isEmpty {
    return (self.array.count == 0);
}

#pragma mark - NSFastEnumeration

//- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)len {
//    
//}

@end
