//
//  ICB_WeatherConditions.h
//  realweather
//
//  Created by Jordi Aragones Vilella on 8/16/12.
//  Copyright (c) 2012 Universitat Rovira i Virgili. All rights reserved.
//

@interface ICB_WeatherConditions : NSObject {
    NSString *location;
    NSMutableArray *forecast;
}

@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSMutableArray *forecast;

- (ICB_WeatherConditions *)initWithQuery:(NSString *)query;

@end
