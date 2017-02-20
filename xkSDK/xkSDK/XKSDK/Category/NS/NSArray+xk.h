//
//  NSArray+xk.h
//  XKSDK
//
//  Created by xklibcoco.github.io on 2016/5/20.
//  Copyright © 2017年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (xk)

///检查是否越界和NSNull，如果是返回nil
- (id)objectAtIndexCheck:(NSUInteger)index;

///是否真是数组
@property(nonatomic,assign,readonly)BOOL isAClass;

///数组转为JsonStr
@property(nonatomic,copy,readonly)NSString *jsonStr;

///根据一个字符串将数组连接成一个新的字符串，这里用的逗号
@property(nonatomic,copy,readonly)NSString *combinStr;

///请接收返回的数组 按字段给数组排序
- (NSArray *)sortbyKey:(NSString *)key asc:(BOOL)ascend;

///数组比较
- (BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array;

///数组计算交集
- (NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

///数组计算差集
- (NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray;

@end
