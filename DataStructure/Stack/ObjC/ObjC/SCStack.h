//
//  SCStack.h
//  ObjC
//
//  Created by ShannonChen on 2017/9/24.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 栈
 */
@interface SCStack<__covariant ObjectType> : NSObject <NSFastEnumeration>


@property (nonatomic, readonly, nullable) ObjectType top;   ///< 最顶部的元素
@property (nonatomic, readonly) BOOL isEmpty;               ///< 是否为空
@property (nonatomic, readonly) NSUInteger count;           ///< 元素个数

// 压栈：push 一个对象到栈中
- (void)push:(nonnull ObjectType)newObject;

// 出栈：执行 pop 操作，如果栈中没有元素，返回 nil
- (nullable ObjectType)pop;

- (void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

@end

NS_ASSUME_NONNULL_END
