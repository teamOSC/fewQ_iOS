//
//  LandingPageViewController.m
//  valet
//
//  Created by Robin Malhotra on 20/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "LandingPageViewController.h"
#import "userDisplayViewController.h"
#import "popupViewController.h"
#import <AFPopupView/AFPopupView.h>
#define UUID @"6470FCEB-0F6B-4609-AA4C-2D0F92F0FB2E"
static NSString * treasureId = @"rdvApp.directionTest";
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface LandingPageViewController ()
{
    NSMutableArray *items;
    NSMutableArray *history;
    NSString *token;
    NSString *type;
    CLBeacon *closestBeacon;
    int x;
}
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
    items=[[NSMutableArray alloc] init];
    NSUUID * uid = [[NSUUID alloc] initWithUUIDString:UUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid identifier:treasureId];
    // When set to YES, the location manager sends beacon notifications when the user turns on the display and the device is already inside the region.
    [self.beaconRegion setNotifyEntryStateOnDisplay:YES];
    [self.beaconRegion setNotifyOnEntry:YES];
    [self.beaconRegion setNotifyOnExit:YES];
    x=0;
    [self configureReceiver];
    
    [self.salesButton setHidden:YES];
    [self.servicesButton setHidden:YES];
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
        closestBeacon=[beacons objectAtIndex:0];
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *email=[defaults objectForKey:@"emailID"];
        NSString *cid=[NSString stringWithFormat:@"%@,%@,%@",[closestBeacon.proximityUUID UUIDString],closestBeacon.major,closestBeacon.minor];
        [self sendHTTPGetWithEmail:email andBeaconID:cid];
        
        
        if ([closestBeacon proximity]==CLProximityFar && x==0)
        {
            [self performSegueWithIdentifier:@"popup" sender:self];
            x=1;
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    UILocalNotification *notif=[[UILocalNotification alloc]init];
    [notif setAlertBody:@"Welcome to Valet"];
    [[UIApplication sharedApplication]presentLocalNotificationNow:notif];

}
-(void) sendHTTPGetWithEmail:(NSString *)email andBeaconID:(NSString *)cid
{
    if (![[self.navigationController topViewController] isKindOfClass:[userDisplayViewController class]] && [items count]<=0)
    {
        NSString *serverAddress=[NSString stringWithFormat:@"%@?email=%@&beacon_id=%@",@"http://tosc.in:8080/customer_in",email,cid];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:10];
        
        [request setHTTPMethod: @"GET"];
        
        
        NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:myQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data!=nil)
            {
                NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",newStr);
                
                NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if ([jsonDict isKindOfClass:[NSDictionary class]] )
                {
                    items=[jsonDict objectForKey:@"items"];
                    token=[jsonDict objectForKey:@"token"];
                    history=[jsonDict objectForKey:@"history"];
                    [myQueue cancelAllOperations];
                    
                }
                
            }
            
            
        }];
    }
    
    
    if ([items count]>0)
    {
        [self.servicesButton setHidden:NO];
        [self.salesButton setHidden:NO];
        [self.loadingLabel setHidden:YES];
    }
    
    
    


    

    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"userDisplay"])
    {
        userDisplayViewController *vc=segue.destinationViewController;
        vc.token=token;
        if (sender==self.salesButton)
        {
            vc.type=@"mall";
        }
        
        else
        {
            vc.type=@"services";
        }
        
        vc.history=history;
        vc.items=items;
    }
    
    else if ([segue.identifier isEqualToString:@"popup"])
    {
        popupViewController *vc=segue.destinationViewController;
        vc.closestBeacon=closestBeacon;
    }
}

- (IBAction)sales:(id)sender
{
    if (items)
    {
        if (![[self.navigationController topViewController] isKindOfClass:[userDisplayViewController class]]) {
            [self performSegueWithIdentifier:@"userDisplay" sender:sender];
        }
        
    }
}

- (IBAction)services:(id)sender
{
    if (items)
    {
        if (![[self.navigationController topViewController] isKindOfClass:[userDisplayViewController class]]) {
            [self performSegueWithIdentifier:@"userDisplay" sender:sender];
        }
        
    }

}


-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
    
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    NSString *email=[defaults objectForKey:@"emailID"];
//    long integer=(long)[defaults objectForKey:@"rating"];
//    NSString *cid=[NSString stringWithFormat:@"%@,%@,%@,%@",[email,closestBeacon.proximityUUID UUIDString],closestBeacon.major,closestBeacon.minor];
//
//    NSString *serverAddress=[NSString stringWithFormat:@"%@?email=%@&beacon_id=%@",@"http://tosc.in:8080/feedback",email,cid];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
//                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
//                                                       timeoutInterval:10];
//    
//    [request setHTTPMethod: @"GET"];
//    
//    
//    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:myQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (data!=nil)
//        {
//            NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",newStr);
//            
//            NSDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//            if ([jsonDict isKindOfClass:[NSDictionary class]] )
//            {
//                items=[jsonDict objectForKey:@"items"];
//                token=[jsonDict objectForKey:@"token"];
//                history=[jsonDict objectForKey:@"history"];
//                [myQueue cancelAllOperations];
//                
//            }
//            
//        }
//        
//        
//    }];

}



@end
