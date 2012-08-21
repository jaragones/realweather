//
//  WeatherViewController.m
//  realweather
//
//  Created by Jordi Aragones Vilella on 8/16/12.
//  Copyright (c) 2012 Universitat Rovira i Virgili. All rights reserved.
//

#import "WeatherViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ICB_WeatherConditions.h"
#import "DayForecast.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

@synthesize lastKnownLocation;
@synthesize celsius;
@synthesize fahrenheit;
@synthesize btnUnits;

@synthesize lblLocation;
@synthesize lblCurrentTemp;
@synthesize lblUnits;
@synthesize lblExplanation;
@synthesize lblWind;
@synthesize lblHumidity;

@synthesize lblDay1Abbr;
@synthesize lblDay1Image;
@synthesize lblDay1Max;
@synthesize lblDay1Min;

@synthesize lblDay2Abbr;
@synthesize lblDay2Image;
@synthesize lblDay2Max;
@synthesize lblDay2Min;

@synthesize lblDay3Abbr;
@synthesize lblDay3Image;
@synthesize lblDay3Max;
@synthesize lblDay3Min;

@synthesize lblDay4Abbr;
@synthesize lblDay4Image;
@synthesize lblDay4Max;
@synthesize lblDay4Min;

@synthesize background;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self updateData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // Do any additional setup after loading the view from its nib.
    
    [self updateData];
}

- (void)updateData {
        
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    NSString *url = [NSString stringWithFormat:@"http://free.worldweatheronline.com/feed/weather.ashx?q=%f,%f&format=xml&num_of_days=4&key=xxxxxxxxxxxx", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    
    // Retrieving data from Global Weather Service
    ICB_WeatherConditions *weather = [[ICB_WeatherConditions alloc] initWithQuery:url];  
    
    // Loading city
    lblLocation.text = [weather.location uppercaseString];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];    
    if ([[prefs stringForKey:@"units"] isEqualToString:@"C"]) {  
        lblUnits.text = @"ºC";
        
        // Information of current date
        DayForecast *current = [[DayForecast alloc] init];
        current = [weather.forecast objectAtIndex:0];

        [self switchBackground:current.tempFeelC];
        
        // Current date 
        lblCurrentTemp.text = [NSString stringWithFormat:@"%d", current.tempFeelC];
        lblExplanation.text = [NSString stringWithFormat:@"%@ & %dºC", current.weatherDesc, current.tempC];    
        lblHumidity.text = [NSString stringWithFormat:@"%d%%", current.humidity];
        lblWind.text = current.windKmh;
        
        // Day 1
        DayForecast* d = [weather.forecast objectAtIndex: 1]; 
        lblDay1Abbr.text = [[self dayAbbreviation:d.date] uppercaseString];
        lblDay1Image.image = [self iconWeather:d.weatherCode];
        lblDay1Max.text = [NSString stringWithFormat:@"%dºC", d.tempMaxC];
        lblDay1Min.text = [NSString stringWithFormat:@"%dºC", d.tempMinC];
        
        // Day 2
        d = [weather.forecast objectAtIndex: 2];
        lblDay2Abbr.text = [[self dayAbbreviation:d.date] uppercaseString];   
        lblDay2Image.image = [self iconWeather:d.weatherCode];
        lblDay2Max.text = [NSString stringWithFormat:@"%dºC", d.tempMaxC];
        lblDay2Min.text = [NSString stringWithFormat:@"%dºC", d.tempMinC];    

        // Day 3
        d = [weather.forecast objectAtIndex: 3];
        lblDay3Abbr.text = [[self dayAbbreviation:d.date] uppercaseString];    
        lblDay3Image.image = [self iconWeather:d.weatherCode];
        lblDay3Max.text = [NSString stringWithFormat:@"%dºC", d.tempMaxC];
        lblDay3Min.text = [NSString stringWithFormat:@"%dºC", d.tempMinC];

        // Day 4
        d = [weather.forecast objectAtIndex: 4];
        lblDay4Abbr.text = [[self dayAbbreviation:d.date] uppercaseString];
        lblDay4Image.image = [self iconWeather:d.weatherCode];
        lblDay4Max.text = [NSString stringWithFormat:@"%dºC", d.tempMaxC];
        lblDay4Min.text = [NSString stringWithFormat:@"%dºC", d.tempMinC];
    } else {
        lblUnits.text = @"ºF";
        
        // Information of current date
        DayForecast *current = [[DayForecast alloc] init];
        current = [weather.forecast objectAtIndex:0];
        
        [self switchBackground:current.tempFeelC];        
        
        // Current date 
        lblCurrentTemp.text = [NSString stringWithFormat:@"%d", current.tempFeelF];
        lblExplanation.text = [NSString stringWithFormat:@"%@ & %dºF", current.weatherDesc, current.tempF];    
        lblHumidity.text = [NSString stringWithFormat:@"%d%%", current.humidity];
        lblWind.text = current.windMph;
        
        // Day 1
        DayForecast* d = [weather.forecast objectAtIndex: 1]; 
        lblDay1Abbr.text = [[self dayAbbreviation:d.date] uppercaseString];
        lblDay1Image.image = [self iconWeather:d.weatherCode];
        lblDay1Max.text = [NSString stringWithFormat:@"%dºF", d.tempMaxF];
        lblDay1Min.text = [NSString stringWithFormat:@"%dºF", d.tempMinF];
        
        // Day 2
        d = [weather.forecast objectAtIndex: 2];
        lblDay2Abbr.text = [[self dayAbbreviation:d.date] uppercaseString];   
        lblDay2Image.image = [self iconWeather:d.weatherCode];
        lblDay2Max.text = [NSString stringWithFormat:@"%dºF", d.tempMaxF];
        lblDay2Min.text = [NSString stringWithFormat:@"%dºF", d.tempMinF];    
        
        // Day 3
        d = [weather.forecast objectAtIndex: 3];
        lblDay3Abbr.text = [[self dayAbbreviation:d.date] uppercaseString];    
        lblDay3Image.image = [self iconWeather:d.weatherCode];
        lblDay3Max.text = [NSString stringWithFormat:@"%dºF", d.tempMaxF];
        lblDay3Min.text = [NSString stringWithFormat:@"%dºF", d.tempMinF];
        
        // Day 4
        d = [weather.forecast objectAtIndex: 4];
        lblDay4Abbr.text = [[self dayAbbreviation:d.date] uppercaseString];
        lblDay4Image.image = [self iconWeather:d.weatherCode];
        lblDay4Max.text = [NSString stringWithFormat:@"%dºF", d.tempMaxF];
        lblDay4Min.text = [NSString stringWithFormat:@"%dºF", d.tempMinF];        
    }
}

- (void) switchBackground:(NSInteger) temp {
    if (temp < 20) {
        background.image = [UIImage imageNamed:@"blue.png"];
    } else {
        if (temp < 25) {
            background.image = [UIImage imageNamed:@"yellow.png"];    
        } else {
            if (temp < 35) {
                background.image = [UIImage imageNamed:@"orange.png"];    
            } else {
                background.image = [UIImage imageNamed:@"red.png"];    
            }
        }
    }
}

- (UIImage *)iconWeather:(NSInteger)code {
    switch (code) {
        case 113:
            return [UIImage imageNamed:@"sun.png"];
            break;
        case 116:
            return [UIImage imageNamed:@"cloudSun.png"];
            break;
        case 119:
        case 122:
            return [UIImage imageNamed:@"cloud.png"];            
            break;
        case 143:
        case 248:
        case 260:    
            return [UIImage imageNamed:@"fog.png"];  
            break;
        case 176:
            return [UIImage imageNamed:@"cloudRainSun.png"];  
            break;
        case 179:
        case 182:
        case 320:
        case 323:
        case 326:
        case 329:
        case 332:
        case 335:
        case 338:
            return [UIImage imageNamed:@"cloudSnowSun.png"];    
            break;
        case 185:
        case 350:
            return [UIImage imageNamed:@"cloudDrizzleSun.png"];  
            break;
        case 200:
        case 386:
        case 389:
        case 392:
        case 395:
            return [UIImage imageNamed:@"cloudLightining.png"];  
            break;
        case 227:
        case 230:
        case 365:
        case 368:
        case 371:
        case 374:
        case 377:
            return [UIImage imageNamed:@"cloudSnow.png"];  
            break;
        case 263:
        case 266:
        case 281:    
            return [UIImage imageNamed:@"cloudDrizzleSun.png"];  
            break;
        case 284:    
            return [UIImage imageNamed:@"cloudDrizzle.png"];  
            break;
        case 293:
        case 296:
        case 299:
        case 302:
        case 305:
        case 308:
        case 311:
        case 314:
        case 317:
        case 353:
        case 356:
        case 359:
        case 362:
            return [UIImage imageNamed:@"cloudRain.png"];  
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)dayAbbreviation:(NSString *)date {
    NSString *dateStr = date;
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date2 = [dateFormat dateFromString:dateStr];     
    NSDateFormatter *weekdayFormatter = [[NSDateFormatter alloc] init];
    [weekdayFormatter setDateFormat: @"EE"];
    NSString *weekday = [weekdayFormatter stringFromDate: date2];
    
    return weekday;
}

- (NSString *)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    return theLocation;
}

- (void)viewDidUnload
{
    lblLocation = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)changeUnits:(UIButton *)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    NSString *currentUnit = [prefs stringForKey:@"units"];
    
    if ([currentUnit isEqualToString:@"C"]) currentUnit = @"F";
    else currentUnit = @"C";
    
    [prefs setObject:currentUnit forKey:@"units"];
    
    [self updateData];
}
@end
