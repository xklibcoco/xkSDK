//
//  NSArray+xk.m
//  XKSDK
//
//  Created by xklibcoco.github.io on 2016/5/20.
//  Copyright © 2017年 kyle. All rights reserved.
//

#import "NSArray+xk.h"

@implementation NSArray (xk)

- (id)objectAtIndexCheck:(NSUInteger)index{
    if (index < self.count) {
        return self[index];
    } else {
        //越界返回nil
        return nil;
    }
}

- (BOOL)isAClass{
    return [self isKindOfClass:[NSArray class]];
}

- (NSString *)jsonStr{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:NULL] encoding:NSUTF8StringEncoding];
}

- (NSString *)combinStr{
    return [self componentsJoinedByString:@","];
}

- (NSArray *)sortbyKey:(NSString *)key asc:(BOOL)ascend{
    return [self sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascend]]];
}

- (BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array{
    NSSet *set1 = [NSSet setWithArray:self];
    NSSet *set2 = [NSSet setWithArray:array];
    return [set1 isEqualToSet:set2];
}

- (NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray{
    NSMutableArray *intersectionArray = [NSMutableArray array];
    if (self.count == 0) {
        return nil;
    }
    if (otherArray == nil) {
        return nil;
    }
    //遍历
    for (id obj in self) {
        if (![otherArray containsObject:obj]) {
            continue;
        }
        [intersectionArray addObject:obj];
    }
    
    return intersectionArray;
}

- (NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray{
    if (self == nil) {
        return nil;
    }
    if (otherArray == nil) {
        return self;
    }
    NSMutableArray *minusArray = [NSMutableArray arrayWithArray:self];
    for (id obj in otherArray) {
        if (![self containsObject:obj]) {
            continue;
        }
        [minusArray removeObject:obj];
    }
    return minusArray;
}
@end
