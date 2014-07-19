//
//  couponCard.h
//  valet
//
//  Created by Robin Malhotra on 19/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface couponCard : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *offer;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (copy, nonatomic) UIColor *color;
@property (strong, nonatomic) IBOutlet UIView *roundedView;

@end
