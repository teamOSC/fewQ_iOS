//
//  userDisplayViewController.m
//  valet
//
//  Created by Robin Malhotra on 20/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "userDisplayViewController.h"
#import "userDisplayTableViewCell.h"
#import "AsyncImageView.h"
@interface userDisplayViewController ()

@end

@implementation userDisplayViewController

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
    self.tokenLabel.text=self.token;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.type isEqualToString:@"mall"])
    {
        return [self.items count];

    }
    return [self.history count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    userDisplayTableViewCell *cell=(userDisplayTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    AsyncImageView *imgView=(AsyncImageView *)[cell viewWithTag:1];

    if ([self.type isEqualToString:@"mall"])
    {
        cell.date.text=[[self.items objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.productName.text=[[self.items objectAtIndex:indexPath.row]objectForKey:@"text"];
        NSString *arr=[[self.items objectAtIndex:indexPath.row] objectForKey:@"image"];
        imgView.imageURL=[NSURL URLWithString:arr];
    }
    
    else if ([self.type isEqualToString:@"services"])
    {
        cell.date.text=[[self.history objectAtIndex:indexPath.row] objectForKey:@"date"];
        cell.productName.text=[[self.history objectAtIndex:indexPath.row] objectForKey:@"name"];
        switch (indexPath.row)
        {
            case 0:
                imgView.imageURL=[NSURL URLWithString:@"http://storage3d.com/storage/2010.11/b2053e7d5c9623e1df426e31199414d3.jpg"];
            case 1:
                imgView.imageURL=[NSURL URLWithString:@"http://d21fsbehgrfqf3.cloudfront.net/product/256/APMT-8460.jpg"];
            case 2:
                imgView.imageURL=[NSURL URLWithString:@"http://png-1.findicons.com/files/icons/975/oldschool/256/gameboy_256.png"];
                break;
                
            default:
                break;
        }
    }
    return cell;
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
