//
//  UserDetailsViewController.m
//  NSS IITD
//
//  Created by Robin Malhotra on 24/05/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "UserDetailsViewController.h"
#import <Social/Social.h>

#import <Accounts/Accounts.h>

@interface UserDetailsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailIDField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNoField;
//something
@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (strong,nonatomic) NSString *event;


@end

@implementation UserDetailsViewController
- (IBAction)tapView:(id)sender
{
    [self.view endEditing:YES];
}

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"emailID"])
    {
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }
    NSString *name=[defaults objectForKey:@"name"];
    NSString *emailID=[defaults objectForKey:@"emailID"];
    NSString *phoneNo=[defaults objectForKey:@"phoneNo"];
    
    self.nameField.text=name;
    self.emailIDField.text=emailID;
    self.phoneNoField.text=phoneNo;
    
    

 

    // Do any additional setup after loading the view.
}
- (IBAction)login:(id)sender
{
    NSString *name=self.nameField.text;
    NSString *emailID=self.emailIDField.text;
    NSString *phoneNo=self.phoneNoField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([self isValidEmail:emailID])
    {
        [defaults setObject:name forKey:@"name"];
        [defaults setObject:emailID forKey:@"emailID"];
        [defaults setObject:phoneNo forKey:@"phoneNo"];
    }
    
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"invalid Email" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }

    
    
    //if there is a connection going on just cancel it.
    [self.connection cancel];
    //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        NSURL *url=[[NSURL alloc]initWithString:@"http://tosc.in:8080/user_register"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
        
        //set http method
        [request setHTTPMethod:@"GET"];
        //initialize a post data
        //NSString *postData = @"entry.1910052895=iOS&entry.1103196731=vajhcsd&entry.399168322=BJKSVDB&entry.1544699882=kajfnk&entry.554333590=khdsfbvkj";
        NSString *postData=[NSString stringWithFormat:@"name=%@&email=%@&phone=%@",name,emailID,phoneNo];
        //set request content type we MUST set this value.
        NSURL *url2=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@?%@",url,postData]];
        [request setURL:[url2 standardizedURL]];
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",[request HTTPBody]);
        
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        self.connection = connection;
        [connection start];

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"success" message:@"You have beeen registered" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
    [alert show];
    
}
- (IBAction)saveButton:(id)sender
{
    NSString *name=self.nameField.text;
    NSString *emailID=self.emailIDField.text;
    NSString *phoneNo=self.phoneNoField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([self isValidEmail:emailID])
    {
        [defaults setObject:name forKey:@"name"];
        [defaults setObject:emailID forKey:@"emailID"];
        [defaults setObject:phoneNo forKey:@"phoneNo"];
    }
    
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"invalid Email" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
    
    
    
}


-(BOOL)isValidEmail:(NSString *)email//http://www.codigator.com/snippets/validating-an-email-in-ios-snippet/
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
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
