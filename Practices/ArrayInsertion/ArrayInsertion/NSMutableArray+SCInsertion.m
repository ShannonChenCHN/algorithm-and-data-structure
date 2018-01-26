//
//  NSMutableArray+SCInsertion.m
//  ArrayInsertion
//
//  Created by ShannonChen on 2018/1/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import "NSMutableArray+SCInsertion.h"

@implementation NSMutableArray (SCInsertion)

- (void)sc_insertObjects:(NSArray *)objects atIndexes:(NSArray<NSNumber *> *)indexes {
    NSAssert(objects && indexes, @"参数不能为 nil");
    NSAssert(objects.count == indexes.count, @"数组元素个数必须一致");
    
    if (objects == nil || indexes == nil) {
        return;
    }
    
    if (objects.count != indexes.count) {
        return;
    }
    
    // 1. 遍历 objects 数组，将每个 object 和对应的 target index 捆绑后再存到新数组中
    // --------------------------
    //  objects           indexes
    // ---------------------------
    // object_0 <-------> index_0
    // object_1 <-------> index_1
    // ...
    NSMutableArray <NSDictionary *> *combinedDataArray = [NSMutableArray array];
    [objects enumerateObjectsUsingBlock:^(id  _Nonnull anObject, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary <NSString *, id> *combinedObject = @{@"object" : anObject,
                                                          @"index"  : indexes[idx]
                                                          };
        [combinedDataArray addObject:combinedObject];
    }];
    
    // 2. 按索引大小从大到小排序
    NSArray <NSDictionary *> *sortedCombinedDataArray = [combinedDataArray sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *combinedObj1, NSDictionary *combinedObj2) {
        NSInteger index1 = [combinedObj1[@"index"] integerValue];
        NSInteger index2 = [combinedObj2[@"index"] integerValue];
        if (index1 < index2) {
            return NSOrderedDescending;
        } else if (index1 == index2){
            return NSOrderedSame;
        } else {
            return NSOrderedAscending;
        }
    }];
    
    // 3. 按索引大小顺序从大到小将 object 插入到数组中
    [sortedCombinedDataArray enumerateObjectsUsingBlock:^(NSDictionary *combinedObj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger locationToInsert = [combinedObj[@"index"] integerValue];
        id objToInsert = combinedObj[@"object"];
        
        if (locationToInsert >= 0 && locationToInsert < self.count) {
            [self insertObject:objToInsert atIndex:locationToInsert];
        }
    }];
    
}

@end
