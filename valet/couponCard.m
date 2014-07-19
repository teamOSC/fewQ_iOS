//
//  couponCard.m
//  valet
//
//  Created by Robin Malhotra on 19/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "couponCard.h"

@implementation couponCard

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    
    self.roundedView.backgroundColor = self.color;
    
    self.roundedView.layer.cornerRadius = 10.0;
    self.roundedView.layer.borderWidth = 1.0;
    self.roundedView.layer.borderColor = [UIColor blackColor].CGColor;
    
}

#pragma mark - Accessors


- (void)setColor:(UIColor *)color {
    
    _color = [color copy];
    
    self.roundedView.backgroundColor = self.color;
}

#pragma mark - Methods

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    self.roundedView.layer.borderColor = self.selected ? [UIColor whiteColor].CGColor : [UIColor blackColor].CGColor;
}
@end