//
//  couponViewController.h
//  valet
//
//  Created by Robin Malhotra on 19/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "TGLStackedViewController.h"

@interface couponViewController : TGLStackedViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, assign) BOOL doubleTapToClose;

@end
