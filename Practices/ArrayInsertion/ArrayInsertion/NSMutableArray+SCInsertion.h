//
//  NSMutableArray+SCInsertion.h
//  ArrayInsertion
//
//  Created by ShannonChen on 2018/1/26.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType> (SCInsertion)


/// 城市指南广告插入算法：按照给定的位置插入对应的 object，index 一定不能大于 objects 数组元素个数
///
/// 注：该方法与 Apple 的 -insertObjects:atIndexes: 方法的算法不同
///
/// 例如，分别在给定数组 @[@"one", @"two", @"three", @"four"] 中的第 3 位、第 1 位、第 2 位插入字符串 @"a", @"b", @"c":
/// @code
/// NSMutableArray *array = [NSMutableArray arrayWithObjects: @"one", @"two", @"three", @"four", nil];
/// NSArray *newAdditions = [NSArray arrayWithObjects: @"a", @"b", @"c", nil];
/// NSArray *indexes = [NSMutableArray arrayWithObjects:@(3), @(1), @(2), nil];
/// [array sc_insertObjects:newAdditions atIndexes:indexes];
/// NSLog(@"array: %@", array);
///
/// // Output: array: (one, b, two, c, three, a, four)
/// @endcode
- (void)sc_insertObjects:(NSArray<ObjectType> *)objects atIndexes:(NSArray<NSNumber *> *)indexes;

@end

NS_ASSUME_NONNULL_END
