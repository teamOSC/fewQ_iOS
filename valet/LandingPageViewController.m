//
//  LandingPageViewController.m
//  valet
//
//  Created by Robin Malhotra on 20/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "LandingPageViewController.h"
#define UUID @"6470FCEB-0F6B-4609-AA4C-2D0F92F0FB2E"
static NSString * treasureId = @"rdvApp.directionTest";
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface LandingPageViewController ()

@end

@implementation LandingPageViewController

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
    [self.navigationItem setHidesBackButton:YES];
    
    NSUUID * uid = [[NSUUID alloc] initWithUUIDString:UUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid identifier:treasureId];
    // When set to YES, the location manager sends beacon notifications when the user turns on the display and the device is already inside the region.
    [self.beaconRegion setNotifyEntryStateOnDisplay:YES];
    [self.beaconRegion setNotifyOnEntry:YES];
    [self.beaconRegion setNotifyOnExit:YES];
    
    [self configureReceiver];
    // Do any additional setup after loading the view.
}


-(void)configureReceiver {
    // Location manager.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}


-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    [beacons sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"rssi" ascending:YES]]];
    if ([beacons count]>0)
    {
        CLBeacon *closestBeacon=[beacons objectAtIndex:0];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *email=[defaults objectForKey:@"emailID"];
        NSString *cid=[NSString stringWithFormat:@"%@,%@,%@",[closestBeacon.proximityUUID UUIDString],closestBeacon.major,closestBeacon.minor];
        [self sendHTTPGetWithEmail:email andBeaconID:cid];
    }
}


-(void) sendHTTPGetWithEmail:(NSString *)email andBeaconID:(NSString *)cid
{

    NSString *serverAddress=[NSString stringWithFormat:@"%@?email=%@&beacon_id=%@",@"http://tosc.in:8080/customer_in",email,cid];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
   
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];

    [NSURLConnection sendAsynchronousRequest:request queue:myQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",newStr);
        
        NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([jsonDict isKindOfClass:[NSDictionary class]] && data!=nil)
        {
            NSArray *items=[jsonDict objectForKey:@"items"];
            NSString *token=[jsonDict objectForKey:@"token"];
            [myQueue cancelAllOperations];
            
        }
    }];

    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
