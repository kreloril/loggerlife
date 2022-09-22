//
//  MSFeatureDateFormatting.m
//  LoggerLife
//
//  Created by John Mulvey on 8/8/20.
//  Copyright © 2020 John Mulvey. All rights reserved.
//

#import "MSFeatureDateFormatting.h"

@implementation MSFeatureDateFormatting

+(NSString*)formattedTimeStamp:(NSString*)timestamp {
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
    NSDateFormatter* formmatedLogdate = [[NSDateFormatter alloc] init];
    formmatedLogdate = [[NSDateFormatter alloc] init];
    NSString* format = [NSDateFormatter dateFormatFromTemplate:@"EEE hh:mm a MM/dd/yyyy" options:0 locale:[NSLocale currentLocale]];
    format = [format stringByReplacingOccurrencesOfString:@"," withString:@""];
    [formmatedLogdate setDateFormat:format];
    return [formmatedLogdate stringFromDate:date];
}

+(NSString*)headerSortingIndex:(NSString*)timestampentry {
    NSTimeInterval timestamp =  [timestampentry doubleValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMddYYYY"];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
    return [dateFormatter stringFromDate:date];
}

+(NSString*)headerFormattedTime:(NSString*)timestampentry {
    
      NSTimeInterval timestamp =  [timestampentry doubleValue];
     NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp];
     NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"EEE MMM dd, YYYY"];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
    return [dateFormatter stringFromDate:date];
     

}

+(NSTimeInterval)headerFormattedTimeInterval:(NSString*)timestampentry {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd, YYYY"];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
    NSDate* date = [dateFormatter dateFromString:timestampentry];
    return date.timeIntervalSince1970;
}

+(NSString*)formattedTime:(NSString*)timestamp {
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"hh:mm a"];
    
    return [formatter stringFromDate:date];
}

+(NSString*)shortDateFormat:(NSString*)date {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSDate* dateobj = [[NSDate alloc] initWithTimeIntervalSince1970:[date doubleValue]];
    return [formatter stringFromDate:dateobj];
}

@end
