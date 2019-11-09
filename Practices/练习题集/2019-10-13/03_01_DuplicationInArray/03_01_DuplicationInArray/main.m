//
//  main.m
//  03_01_DuplicationInArray
//
//  Created by ShannonChen on 2019/10/13.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>


// 扫描数组，并将每个元素保存到一个新的数组中去，如果发现这个新数组中已经有了，就说明重复了
// 时间复杂度 O(n^2)，空间复杂度 O(n)
NSInteger findDuplicateNumsInArray_1(NSArray <NSNumber *> *numbers) {
    NSInteger result = NSNotFound;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSNumber *aNumber in numbers) {
        // O(n)
        if (![tempArray containsObject:aNumber]) {  // O(n)
            [tempArray addObject:aNumber];
        } else {
            result = aNumber.integerValue;
            break;
        }
    }
    
    return result;
}

// 扫描数组，并将每个元素保存到一个新的字典中去，如果发现这个字典中已经有了，就说明重复了
// 时间复杂度 O(n)，空间复杂度 O(n)
NSInteger findDuplicateNumsInArray_2(NSArray <NSNumber *> *numbers) {
    NSInteger result = NSNotFound;
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    for (NSNumber *aNumber in numbers) {
        // O(n)
        if (![tempDic.allValues containsObject:aNumber]) {  // O(1)
            [tempDic setObject:aNumber forKey:aNumber];
        } else {
            result = aNumber.integerValue;
            break;
        }
    }
    
    return result;
    
}


// 先对数组进行排序，然后再扫描数组
// 时间复杂度：O(n(logn))，空间复杂度 O(n)
NSInteger findDuplicateNumsInArray_3(NSArray <NSNumber *> *numbers) {
    __block NSInteger result = NSNotFound;
    
    // O(n(logn))
    NSArray *tempArray = [numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 < obj2;
    }];
    
    // O(n)
    [tempArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != obj.integerValue) {
            result = obj.integerValue;
            *stop = YES;
        }
    }];
    
    return result;
}

/*
{2, 3, 1, 0, 2, 5, 3}
{0, 3, 1, 2, 2, 5, 3}
{0, 2, 1, 3, 2, 5, 3}
{0, 1, 2, 3, 2, 5, 3}
{0, 1, 2, 3, 2, 5, 3}
*/

// 理论上每个元素应该跟它的下标是一一对应的，所以我们扫描整个数组，
// 扫描的下标和值不相等时，就将该值跟其对应的下标的值进行调换，直到发现有一样的值
// 时间复杂度：O(n)，空间复杂度 O(1)
NSInteger findDuplicateNumsInArray_4(NSMutableArray <NSNumber *> *numbers) {
    __block NSInteger result = NSNotFound;
    
    // 都循环嵌套了，为什么是 O(n)
    [numbers enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         
        while (obj.integerValue != idx) {
            if (obj.integerValue == numbers[idx].integerValue) {
                result = obj.integerValue;
                break;
                *stop = YES;
            } else {
                [numbers exchangeObjectAtIndex:idx withObjectAtIndex:obj.integerValue];
            }
        }
    }];
    
    return result;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *numbers = @[@2, @3, @1, @0, @2, @5, @3].mutableCopy;
        
        NSInteger duplicate = findDuplicateNumsInArray_4(numbers);
        if (duplicate != NSNotFound) {
            NSLog(@"重复的数字是：%@\n\n", @(duplicate));
        } else {
            NSLog(@"没有找到重复的数字。\n\n");
        }
        
    }
    return 0;
}


/*
 
 
 总结：
    1. 查找操作，字典比数组更快；
    2. 要充分利用好问题本身的特殊条件；
 
 */
