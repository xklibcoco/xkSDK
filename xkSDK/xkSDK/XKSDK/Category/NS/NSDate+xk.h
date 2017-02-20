//
//  NSDate+xk.h
//  XKSDK
//
//  Created by xklibcoco.github.io on 2016/5/20.
//  Copyright © 2017年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (xk)

///判断是否为今年
- (BOOL)isThisYear;

///判断是否为昨天
- (BOOL)isYesterday;

///判断是否为今天
- (BOOL)isToday;

///字符串时间戳
@property(nonatomic,copy,readonly)NSString *timeStampStr;

///长型时间戳
@property(nonatomic,assign,readonly)double timeStamp;

///时间成分
@property(nonatomic,strong,readonly)NSDateComponents *components;

///比较两个日期的大小 0：相同 1：oneDay 大 2： anotherDay 大
+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

///两个时间比较
+ (NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

///根据年、月、日、小时、分钟、秒返回NSDate
+ (NSDate *)dateWithYear:(NSUInteger)year
                   Month:(NSUInteger)month
                     Day:(NSUInteger)day
                    Hour:(NSUInteger)hour
                  Minute:(NSUInteger)minute
                  Second:(NSUInteger)second;

///实现dateFormatter单例方法
+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddHHmmss;
+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMdd;
+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddHHmm;

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddHHmmInChinese;
+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddHHmmInChinese;

///获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
- (NSDateComponents *)componentsOfDay;

///获得NSDate对应的年份
- (NSUInteger)year;

///获得NSDate对应的月份
- (NSUInteger)month;

///获得NSDate对应的日期
- (NSUInteger)day;

///获得NSDate对应的小时数
- (NSUInteger)hour;

///获得NSDate对应的分钟数
- (NSUInteger)minute;

///获得NSDate对应的秒数
- (NSUInteger)second;

///获得NSDate对应的星期
- (NSUInteger)weekday;

///获取当天是当年的第几周
- (NSUInteger)weekOfDayInYear;

///获得一般当天的工作开始时间
- (NSDate *)workBeginTime;

///获得一般当天的工作结束时间
- (NSDate *)workEndTime;

///获取一小时后的时间
- (NSDate *)oneHourLater;

///获得某一天的这个时刻
- (NSDate *)sameTimeOfDate;

///判断与某一天是否为同一天
- (BOOL)sameDayWithDate:(NSDate *)otherDate;

///判断与某一天是否为同一周
- (BOOL)sameWeekWithDate:(NSDate *)otherDate;

///判断与某一天是否为同一月
- (BOOL)sameMonthWithDate:(NSDate *)otherDate;

///多久以前呢 ？ 1分钟内 X分钟前 X天前
- (NSString *)whatTimeAgo;

///前段时间日期的描述 上午？？ 星期二 下午？？
- (NSString *)whatTimeBefore;

///今天星期几
- (NSString *)whatDayTheWeek;

///YYYY-MM-dd HH:mm:ss
- (NSString *)xk_YYYYMMddHHmmss;

///YYYY.MM.dd
- (NSString *)xk_YYYYMMdd;

///YYYY-MM-dd
- (NSString *)xk_YYYYMMdd__;

///HH:mm
- (NSString *)xk_HHmm;

- (NSString *)MMddHHmm;
- (NSString *)YYYYMMddHHmmInChinese;
- (NSString *)MMddHHmmInchinese;
@end
