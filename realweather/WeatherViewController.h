//
//  WeatherViewController.h
//  realweather
//
//  Created by Jordi Aragones Vilella on 8/16/12.
//  Copyright (c) 2012 Universitat Rovira i Virgili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "ICB_WeatherConditions.h"

@class ICB_WeatherConditions;

@interface WeatherViewController : UIViewController {
    CLLocationManager *locationManager;

    UILabel *lblLocation;
    UILabel *lblCurrentTemp;
    UILabel *lblUnits;
    UILabel *lblExplanation;
    UILabel *lblWind;
    UILabel *lblHumidity;
    
    UILabel *lblDay1Abbr;
    UIImageView *lblDay1Image;
    UILabel *lblDay1Max;
    UILabel *lblDay1Min;
    
    UILabel *lblDay2Abbr;
    UIImageView *lblDay2Image;
    UILabel *lblDay2Max;
    UILabel *lblDay2Min;
    
    UILabel *lblDay3Abbr;
    UIImageView *lblDay3Image;
    UILabel *lblDay3Max;
    UILabel *lblDay3Min;
    
    UILabel *lblDay4Abbr;
    UIImageView *lblDay4Image;
    UILabel *lblDay4Max;
    UILabel *lblDay4Min;
    
    BOOL celsius;
    BOOL fahrenheit;
    
    UIButton *btnUnits;
    UIImageView *background;
}

@property (nonatomic, retain) CLLocation *lastKnownLocation;
@property (nonatomic, assign) BOOL celsius;
@property (nonatomic, assign) BOOL fahrenheit;

@property (nonatomic, strong) IBOutlet UIButton *btnUnits;

@property (nonatomic, strong) IBOutlet UILabel *lblLocation;
@property (nonatomic, strong) IBOutlet UILabel *lblCurrentTemp;
@property (nonatomic, strong) IBOutlet UILabel *lblUnits;
@property (nonatomic, strong) IBOutlet UILabel *lblExplanation;
@property (nonatomic, strong) IBOutlet UILabel *lblWind;
@property (nonatomic, strong) IBOutlet UILabel *lblHumidity;

@property (nonatomic, strong) IBOutlet UILabel *lblDay1Abbr;
@property (nonatomic, strong) IBOutlet UIImageView *lblDay1Image;
@property (nonatomic, strong) IBOutlet UILabel *lblDay1Max;
@property (nonatomic, strong) IBOutlet UILabel *lblDay1Min;

@property (nonatomic, strong) IBOutlet UILabel *lblDay2Abbr;
@property (nonatomic, strong) IBOutlet UIImageView *lblDay2Image;
@property (nonatomic, strong) IBOutlet UILabel *lblDay2Max;
@property (nonatomic, strong) IBOutlet UILabel *lblDay2Min;

@property (nonatomic, strong) IBOutlet UILabel *lblDay3Abbr;
@property (nonatomic, strong) IBOutlet UIImageView *lblDay3Image;
@property (nonatomic, strong) IBOutlet UILabel *lblDay3Max;
@property (nonatomic, strong) IBOutlet UILabel *lblDay3Min;

@property (nonatomic, strong) IBOutlet UILabel *lblDay4Abbr;
@property (nonatomic, strong) IBOutlet UIImageView *lblDay4Image;
@property (nonatomic, strong) IBOutlet UILabel *lblDay4Max;
@property (nonatomic, strong) IBOutlet UILabel *lblDay4Min;

@property (nonatomic, strong) IBOutlet UIImageView *background;

- (IBAction)changeUnits:(UIButton *)sender;

@end
