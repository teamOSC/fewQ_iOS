//
//  LandingPageViewController.h
//  valet
//
//  Created by Robin Malhotra on 20/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
@interface LandingPageViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end
