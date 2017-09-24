//
//  SCStack.h
//  ObjC
//
//  Created by ShannonChen on 2017/9/24.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCStack<__covariant ObjectType> : NSObject <NSFastEnumeration>

@property (nonatomic, readonly, nullable) ObjectType top;
@property (nonatomic, readonly) BOOL isEmpty;
@property (nonatomic, readonly) NSUInteger count;

// Push a new object into stack
- (void)push:(nonnull ObjectType)newObject;

// If the stack is empty, returns nil.
- (nullable ObjectType)pop;


@end
