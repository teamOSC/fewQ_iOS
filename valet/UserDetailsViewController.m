//
//  UserDetailsViewController.m
//  NSS IITD
//
//  Created by Robin Malhotra on 24/05/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "UserDetailsViewController.h"

@interface UserDetailsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailIDField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNoField;

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
    
    NSString *name=[defaults objectForKey:@"name"];
    NSString *emailID=[defaults objectForKey:@"emailID"];
    NSString *password=[defaults objectForKey:@"password"];
    NSString *phoneNo=[defaults objectForKey:@"phoneNo"];
    
    self.nameField.text=name;
    self.emailIDField.text=emailID;
    self.passwordField.text=password;
    self.phoneNoField.text=phoneNo;
    // Do any additional setup after loading the view.
}
- (IBAction)saveButton:(id)sender
{
    NSString *name=self.nameField.text;
    NSString *emailID=self.emailIDField.text;
    NSString *password=self.passwordField.text;
    NSString *phoneNo=self.phoneNoField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([self isValidEmail:emailID])
    {
        [defaults setObject:name forKey:@"name"];
        [defaults setObject:emailID forKey:@"emailID"];
        [defaults setObject:password forKey:@"password"];
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
