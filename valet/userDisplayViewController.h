//
//  userDisplayViewController.h
//  valet
//
//  Created by Robin Malhotra on 20/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userDisplayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray *items;
@property NSString *token;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *history;
@property (weak, nonatomic) IBOutlet UILabel *tokenLabel;
@property NSString *type;
@end
