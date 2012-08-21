//
//  DayForecast.h
//  realweather
//
//  Created by Jordi Aragones Vilella on 8/16/12.
//  Copyright (c) 2012 Universitat Rovira i Virgili. All rights reserved.
//
//  Object to store forecast of the day
//

#import <Foundation/Foundation.h>

@interface DayForecast : NSObject {
    NSString *date;
    NSString *location;
    NSString *weatherDesc;
    NSString *windKmh;
    NSString *windMph;
    
    NSInteger weatherCode;
    NSInteger tempMaxC;
    NSInteger tempMaxF;
    NSInteger tempMinC;
    NSInteger tempMinF;
    NSInteger tempC;
    NSInteger tempF;
    NSInteger humidity;
    
    NSInteger tempFeelC;
    NSInteger tempFeelF;
    
}

@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *weatherDesc;
@property (nonatomic, retain) NSString *windKmh;
@property (nonatomic, retain) NSString *windMph;

@property (nonatomic, assign) NSInteger weatherCode;
@property (nonatomic, assign) NSInteger tempMaxC;
@property (nonatomic, assign) NSInteger tempMaxF;
@property (nonatomic, assign) NSInteger tempMinC;
@property (nonatomic, assign) NSInteger tempMinF;
@property (nonatomic, assign) NSInteger tempC;
@property (nonatomic, assign) NSInteger tempF;
@property (nonatomic, assign) NSInteger humidity;

@property (nonatomic, assign) NSInteger tempFeelC;
@property (nonatomic, assign) NSInteger tempFeelF;

@end
