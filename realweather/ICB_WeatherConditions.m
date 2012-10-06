//
//  ICB_WeatherConditions.m
//  realweather
//
//  Created by Jordi Aragones Vilella on 8/16/12.
//  Copyright (c) 2012 Universitat Rovira i Virgili. All rights reserved.
//

#import "ICB_WeatherConditions.h"
#import "DayForecast.h"
#import "TouchXML.h"

@implementation ICB_WeatherConditions
@synthesize location, forecast; 

// Method to read from an URL a XML file and load its data into Dayforecast object
-(ICB_WeatherConditions *) initWithQuery:(NSString *)query {
    
    if (self = [super init]) {
        CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:query] options:0 error:nil];
        
        forecast = [[NSMutableArray alloc] init];
        self.location = [[[parser nodesForXPath:@"/data/request/query" error:nil] objectAtIndex:0] stringValue];
                 
        DayForecast *current = [[DayForecast alloc] init];
        current.weatherDesc = [[[parser nodesForXPath:@"/data/current_condition/weatherDesc" error:nil] objectAtIndex:0] stringValue]; 
        current.weatherCode = [[[[parser nodesForXPath:@"/data/current_condition/weatherCode" error:nil] objectAtIndex:0] stringValue] intValue]; 
        current.tempC = [[[[parser nodesForXPath:@"/data/current_condition/temp_C" error:nil] objectAtIndex:0] stringValue] intValue]; 
        current.tempF = [[[[parser nodesForXPath:@"/data/current_condition/temp_F" error:nil] objectAtIndex:0] stringValue] intValue];         
        current.humidity = [[[[parser nodesForXPath:@"/data/current_condition/humidity" error:nil] objectAtIndex:0] stringValue] intValue];    

        NSString *direction = [[[parser nodesForXPath:@"/data/current_condition/winddir16Point" error:nil] objectAtIndex:0] stringValue];  
        NSString *speedKmh = [[[parser nodesForXPath:@"/data/current_condition/windspeedKmph" error:nil] objectAtIndex:0] stringValue];  
        NSString *speedMph = [[[parser nodesForXPath:@"/data/current_condition/windspeedMiles" error:nil] objectAtIndex:0] stringValue];  
        
        current.windKmh = [NSString stringWithFormat:@"%@ at %@kmph", direction, speedKmh];
        current.windMph = [NSString stringWithFormat:@"%@ at %@mph", direction, speedMph];
        
        current.tempFeelF = 35.74 + (0.6215 * current.tempF) - (35.75 * pow([speedMph intValue],0.16)) + (0.4275 * current.tempF * pow([speedMph intValue],0.16));
        current.tempFeelC = 13.72 + (0.6215 * current.tempC) - (11.37 * pow([speedKmh intValue],0.16)) + (0.3965 * current.tempC * pow([speedKmh intValue],0.16));
        
        [forecast addObject:current];
        
        // Returns all nodes in an array    
        DayForecast *day;
        NSArray *nodes = [parser nodesForXPath:@"/data/weather" error:nil];
        for (CXMLNode *itemNode in nodes) {
            if ([[itemNode name] isEqualToString:@"weather"]) {
                day = [[DayForecast alloc] init];
                for (CXMLNode *childNode in [itemNode children]) {
                    if ([[childNode name] isEqualToString:@"date"]) day.date = [childNode stringValue];
                    if ([[childNode name] isEqualToString:@"tempMaxC"]) day.tempMaxC = [[childNode stringValue] intValue];
                    if ([[childNode name] isEqualToString:@"tempMaxF"]) day.tempMaxF = [[childNode stringValue] intValue];
                    if ([[childNode name] isEqualToString:@"tempMinC"]) day.tempMinC = [[childNode stringValue] intValue];
                    if ([[childNode name] isEqualToString:@"tempMinF"]) day.tempMinF = [[childNode stringValue] intValue];
                    if ([[childNode name] isEqualToString:@"weatherDesc"]) day.weatherDesc = [childNode stringValue];
                    if ([[childNode name] isEqualToString:@"weatherCode"]) day.weatherCode = [[childNode stringValue] intValue];
                }
                [forecast addObject:day];                
            }
        }
        
        return self;
    }
}



@end
