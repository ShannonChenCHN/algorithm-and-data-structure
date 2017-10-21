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
    
    // [1, 2, 3(top)]
    // push: 4
    // [1, 2, 3, 4(top)]
    
    if (newObject) {
        [self.array addObject:newObject];
    }
    
}

- (nullable id)pop {

    // [1, 2, 3(top)]
    // pop
    // [1, 2(top)]
    
    id lastObject = self.array.lastObject;
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    [self.array removeLastObject];
    
    return lastObject;
}


#pragma mark - Getter

- (nullable id)top {
    // [1, 2, 3(top)]
    
    return self.array.lastObject;
}

- (NSUInteger)count {
    return self.array.count;
}

- (BOOL)isEmpty {
    return (self.array.count == 0);
}

#pragma mark - 枚举
- (void)enumerateObjectsUsingBlock:(void (^)(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull))block {
    
    BOOL shouldBreak = NO;
    for (NSInteger idx = 0; idx < self.array.count; idx++) {
       
        if (block) {
            block(self.array[idx], idx, &shouldBreak);
        }
        
        if (shouldBreak) {
            break;
        }
    }
}

#pragma mark  <NSFastEnumeration>
// 实现 NSFastEnumeration 协议，用于 for-in 快速枚举
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id  _Nullable __unsafe_unretained [])buffer count:(NSUInteger)len {
    return [self.array countByEnumeratingWithState:state objects:buffer count:len];
}

@end

@implementation SCStack (Description)

- (NSString *)description {
    NSMutableString *desc = @"[".mutableCopy;
    
    for (id <NSObject> element in self) {
        [desc appendString:element.description];
        
        if (element != self.top) {
            [desc appendString:@", "];
        }
    }
    
    [desc appendString:@"]"];
    
    return desc;
}

@end
