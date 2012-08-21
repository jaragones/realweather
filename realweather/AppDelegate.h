//
//  AppDelegate.h
//  realweather
//
//  Created by Jordi Aragones Vilella on 8/14/12.
//  Copyright (c) 2012 Universitat Rovira i Virgili. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WeatherViewController *weatherViewController;

@end
