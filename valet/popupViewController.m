//
//  popupViewController.m
//  valet
//
//  Created by Robin Malhotra on 20/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "popupViewController.h"
@interface popupViewController ()
@property(nonatomic, retain) UILabel *rateLabel;
@property (nonatomic, strong) NSString *item;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSDictionary *jsonDict;

@end

@implementation popupViewController

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
    
    NSString *serverAddress=[NSString stringWithFormat:@"%@?email=%@&beacon_id=%@",@"http://tosc.in:8080/customer_out",@"m@m.com",@"1"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSHTTPURLResponse *response = NULL;

    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if (data!=nil)
        {
            NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@" the new data %@",newStr);
            
            self.jsonDict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        }
        
        

    
    self.item=[_jsonDict objectForKey:@"item"];
    self.date=[_jsonDict objectForKey:@"date"];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *name=[defaults objectForKey:@"name"];
    self.transactionText.text=[NSString stringWithFormat:@"Congratulations on your purchase of %@ on date %@. Your credit card statement will be emailed yo you shortly,%@",self.item,self.date,name];

    
    
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
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

- (IBAction)dismiss:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
