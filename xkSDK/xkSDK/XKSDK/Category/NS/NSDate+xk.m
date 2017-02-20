//
//  NSDate+xk.m
//  XKSDK
//
//  Created by xklibcoco.github.io on 2016/5/20.
//  Copyright © 2017年 kyle. All rights reserved.
//

#import "NSDate+xk.h"

@implementation NSDate (xk)

- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

- (BOOL)isYesterday {
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

- (BOOL)isToday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

- (NSString *)timeStampStr {
    return [@([self timeIntervalSince1970]).stringValue copy];
}

- (double)timeStamp{
    return [self timeIntervalSince1970];
}

- (NSDateComponents *)components {
    //创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //定义成分
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self];
}

- (BOOL)calWithValue:(NSInteger)value {
    
    //得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents = self.ymdDate.components;
    
    //得到当前时间的处理后的时间的components
    NSDateComponents *nowComponents = [NSDate date].ymdDate.components;
    
    //比较
    BOOL res = dateComponents.year == nowComponents.year && dateComponents.month == nowComponents.month && (dateComponents.day + value) == nowComponents.day;
    
    return res;
}

- (NSDate *)ymdDate {
    
    //定义fmt
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    //设置格式:去除时分秒
    fmt.dateFormat = @"yyyy-MM-dd";
    
    //得到字符串格式的时间
    NSString *dateString = [fmt stringFromDate:self];
    
    //再转为date
    NSDate *date = [fmt dateFromString:dateString];
    
    return date;
}

+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay is in the past");
        return 2;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

+ (NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    //创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //直接计算
    NSDateComponents *components = [calendar components:unit fromDate:fromDate toDate:toDate options:0];
    
    return components;
}

+ (NSDate *)dateWithYear:(NSUInteger)year
                   Month:(NSUInteger)month
                     Day:(NSUInteger)day
                    Hour:(NSUInteger)hour
                  Minute:(NSUInteger)minute
                  Second:(NSUInteger)second {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddHHmmss {
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    
    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMdd {
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"YYYY.MM.dd"];
    }
    
    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMdd__ {
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmss__;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss__) {
        staticDateFormatterWithFormatYYYYMMddHHmmss__ = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss__ setDateFormat:@"YYYY-MM-dd"];
    }
    
    return staticDateFormatterWithFormatYYYYMMddHHmmss__;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddHHmm {
    static NSDateFormatter *staticDateFormatterWithFormatMMddHHmm;
    if (!staticDateFormatterWithFormatMMddHHmm) {
        staticDateFormatterWithFormatMMddHHmm = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddHHmm setDateFormat:@"MM-dd HH:mm"];
    }
    
    return staticDateFormatterWithFormatMMddHHmm;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatHHmm {
    static NSDateFormatter *staticDateFormatterWithFormatHHmm;
    if (!staticDateFormatterWithFormatHHmm) {
        staticDateFormatterWithFormatHHmm = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatHHmm setDateFormat:@"HH:mm"];
    }
    
    return staticDateFormatterWithFormatHHmm;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatYYYYMMddHHmmInChinese {
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmssInChines;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmssInChines) {
        staticDateFormatterWithFormatYYYYMMddHHmmssInChines = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmssInChines setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    }
    
    return staticDateFormatterWithFormatYYYYMMddHHmmssInChines;
}

+ (NSDateFormatter *)defaultDateFormatterWithFormatMMddHHmmInChinese {
    static NSDateFormatter *staticDateFormatterWithFormatMMddHHmmInChinese;
    if (!staticDateFormatterWithFormatMMddHHmmInChinese) {
        staticDateFormatterWithFormatMMddHHmmInChinese = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddHHmmInChinese setDateFormat:@"MM月dd日 HH:mm"];
    }
    
    return staticDateFormatterWithFormatMMddHHmmInChinese;
}

- (NSDateComponents *)componentsOfDay {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
}

- (NSUInteger)year {
    return [self componentsOfDay].year;
}

- (NSUInteger)month {
    return [self componentsOfDay].month;
}

- (NSUInteger)day {
    return [self componentsOfDay].day;
}

- (NSUInteger)hour {
    return [self componentsOfDay].hour;
}

- (NSUInteger)minute {
    return [self componentsOfDay].minute;
}

- (NSUInteger)second {
    return [self componentsOfDay].second;
}

- (NSUInteger)weekday {
    return [self componentsOfDay].weekday;
}

- (NSUInteger)weekOfDayInYear {
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}

- (NSDate *)workBeginTime {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:9];
    [components setMinute:30];
    [components setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)workEndTime {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:18];
    [components setMinute:0];
    [components setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)oneHourLater {
    return [NSDate dateWithTimeInterval:3600 sinceDate:self];
}

- (NSDate *)sameTimeOfDate {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:[[NSDate date] hour]];
    [components setMinute:[[NSDate date] minute]];
    [components setSecond:[[NSDate date] second]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (BOOL)sameDayWithDate:(NSDate *)otherDate {
    if (self.year == otherDate.year && self.month == otherDate.month && self.day == otherDate.day) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)sameWeekWithDate:(NSDate *)otherDate {
    if (self.year == otherDate.year && self.month == otherDate.month && self.weekOfDayInYear == otherDate.weekOfDayInYear) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)sameMonthWithDate:(NSDate *)otherDate {
    if (self.year == otherDate.year && self.month == otherDate.month) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)whatTimeAgo {
    if (self == nil) {
        return @"";
    }
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"1分钟内"];
    } else if ((temp = timeInterval / 60) < 60) {
        result = [NSString stringWithFormat:@"%ld分钟前", temp];
    } else if ((temp = temp / 60) < 24) {
        result = [NSString stringWithFormat:@"%ld小时前", temp];
    } else if ((temp = temp / 24) < 30) {
        result = [NSString stringWithFormat:@"%ld天前", temp];
    } else if ((temp = temp / 30) < 12) {
        result = [NSString stringWithFormat:@"%ld个月前", temp];
    } else {
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%ld年前", temp];
    }
    return result;
}

- (NSString *)whatTimeBefore {
    if (self == nil) {
        return @"";
    }
    NSDate *yesterday = [[NSDate date] dateByAddingTimeInterval:-(24 * 60 * 60)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = /*NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitHour |NSCalendarUnitMinute | */ NSCalendarUnitDay;
    NSDateComponents *Compareday = [calendar components:unitFlags fromDate:self];
    NSDateComponents *Yesterday = [calendar components:unitFlags fromDate:yesterday];
    NSDateComponents *Today = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSDateFormatter *F_Mon_Day = [[NSDateFormatter alloc] init];
    [F_Mon_Day setDateFormat:@"MM-dd"];
    NSDateFormatter *F_H_M = [[NSDateFormatter alloc] init];
    [F_H_M setDateFormat:@"HH:mm"];
    NSString *S_H = [[F_H_M stringFromDate:self] substringWithRange:NSMakeRange(0, 2)];
    NSString *S_M = [[F_H_M stringFromDate:self] substringWithRange:NSMakeRange(3, 2)];
    NSString *sunormoon = @"";
    NSInteger Hour = [S_H integerValue];
    
    if (Hour >= 3 && Hour < 6) {
        sunormoon = @"凌晨";
    } else if (Hour >= 6 && Hour < 8) {
        sunormoon = @"早上";
    } else if (Hour >= 8 && Hour < 11) {
        sunormoon = @"上午";
    } else if (Hour >= 11 && Hour < 14) {
        sunormoon = @"中午";
    } else if (Hour >= 14 && Hour < 19) {
        sunormoon = @"下午";
    } else if (Hour >= 19 /*&& Hour < 23*/) {
        sunormoon = @"晚上";
    } else if (Hour >= 0 && Hour < 3) {
        sunormoon = @"深夜";
    }
    
    if (Hour > 12) {
        Hour = Hour - 12;
    }
    
    NSString *Mon_Day = [F_Mon_Day stringFromDate:self];
    NSString *Hou_Min = [NSString stringWithFormat:@"%@ %d:%@", sunormoon, (int) Hour, S_M];
    NSString *Week = [self whatDayTheWeek];
    NSTimeInterval oldtime = [self timeIntervalSince1970];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    if ([[[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitYear fromDate:self] year] != [[[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]] year]) {
        [F_Mon_Day setDateFormat:@"YYYY-MM-dd"];
        Mon_Day = [F_Mon_Day stringFromDate:self];
    }
    
    if ([Today day] == [Compareday day]) {
        return [NSString stringWithFormat:@"%@", Hou_Min];
    }
    
    if ([Yesterday day] == [Compareday day]) {
        return [NSString stringWithFormat:@"昨天  %@", Hou_Min];
    }
    
    if ((nowTime - oldtime) / 60 / 60 / 24 >= 7) {
        return [NSString stringWithFormat:@"%@   %@", Mon_Day, Hou_Min];
    }
    
    if ((nowTime - oldtime) / 60 / 60 / 24 < 7) {
        return [NSString stringWithFormat:@"%@  %@", Week, Hou_Min];
    }
    
    return [NSString stringWithFormat:@"%@   %@", Mon_Day, Hou_Min];
}

- (NSString *)whatDayTheWeek {
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    int weekday = (int) [componets weekday]; //a就是星期几，1代表星期日，2代表星期一，后面依次
    switch (weekday) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
            
        default:
            break;
    }
    
    return @"";
}

- (NSString *)WT_YYYYMMddHHmmss {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMddHHmmss] stringFromDate:self];
}

- (NSString *)WT_YYYYMMdd {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMdd] stringFromDate:self];
}
- (NSString *)WT_YYYYMMdd__ {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMdd__] stringFromDate:self];
}
- (NSString *)MMddHHmm {
    return [[NSDate defaultDateFormatterWithFormatMMddHHmm] stringFromDate:self];
}

- (NSString *)WT_HHmm {
    return [[NSDate defaultDateFormatterWithFormatHHmm] stringFromDate:self];
}

- (NSString *)YYYYMMddHHmmInChinese {
    return [[NSDate defaultDateFormatterWithFormatYYYYMMddHHmmInChinese] stringFromDate:self];
}

- (NSString *)MMddHHmmInChinese {
    return [[NSDate defaultDateFormatterWithFormatMMddHHmmInChinese] stringFromDate:self];
}

@end
