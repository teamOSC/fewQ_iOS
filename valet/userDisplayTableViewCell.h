//
//  userDisplayTableViewCell.h
//  valet
//
//  Created by Robin Malhotra on 20/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userDisplayTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@end
