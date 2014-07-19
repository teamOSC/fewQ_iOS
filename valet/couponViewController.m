//
//  couponViewController.m
//  valet
//
//  Created by Robin Malhotra on 19/07/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "couponViewController.h"
#import "couponCard.h"
@interface couponViewController ()
+ (UIColor *)randomColor;

@end


@implementation UIColor (randomColor)
+ (UIColor *)randomColor {
    
    CGFloat comps[3];
    
    for (int i = 0; i < 3; i++) {
        
        NSUInteger r = arc4random_uniform(256);
        comps[i] = (CGFloat)r/255.f;
    }
    
    return [UIColor colorWithRed:comps[0] green:comps[1] blue:comps[2] alpha:1.0];
}

@end

@interface couponViewController ()

@property (strong, readonly, nonatomic) NSMutableArray *cards;

@end

@implementation couponViewController

@synthesize cards = _cards;

+ (UIColor *)randomColor {
    
    CGFloat comps[3];
    
    for (int i = 0; i < 3; i++) {
        
        NSUInteger r = arc4random_uniform(256);
        comps[i] = (CGFloat)r/255.f;
    }
    
    return [UIColor colorWithRed:comps[0] green:comps[1] blue:comps[2] alpha:1.0];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Set to NO to prevent a small number
    // of cards from filling the entire
    // view height evenly and only show
    // their -topReveal amount
    //
    self.stackedLayout.fillHeight = YES;
    
    // Set to NO to prevent a small number
    // of cards from being scrollable and
    // bounce
    //
    self.stackedLayout.alwaysBounce = YES;
    
    // Set to NO to prevent unexposed
    // items at top and bottom from
    // being selectable
    //
    self.unexposedItemsAreSelectable = YES;
    
    if (self.doubleTapToClose) {
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        
        recognizer.delaysTouchesBegan = YES;
        recognizer.numberOfTapsRequired = 2;
        
        [self.collectionView addGestureRecognizer:recognizer];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - Accessors

- (NSMutableArray *)cards {
    
    if (_cards == nil) {
        
        NSArray *cards = @[ @{ @"name" : @"Card #0", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #1", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #2", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #3", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #4", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #5", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #6", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #7", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #8", @"color" : [UIColor randomColor] },
                            @{ @"name" : @"Card #9", @"color" : [UIColor randomColor] }];
        
        _cards = [NSMutableArray arrayWithArray:cards];
    }
    
    return _cards;
}

#pragma mark - Actions

- (IBAction)handleDoubleTap:(UITapGestureRecognizer *)recognizer {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CollectionViewDataSource protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.cards.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    couponCard *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    
    if (indexPath.row%2==0)
    {
        cell.roundedView.backgroundColor=[UIColor blueColor];
        cell.companyName.text=[NSString stringWithFormat:@"asfjdnkj"];
    }
    else
    {
        cell.roundedView.backgroundColor=[UIColor redColor];
    }
    
    return cell;
}

#pragma mark - Overloaded methods

- (void)moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    // Update data source when moving cards around
    //
    NSDictionary *card = self.cards[fromIndexPath.item];
    
    [self.cards removeObjectAtIndex:fromIndexPath.item];
    [self.cards insertObject:card atIndex:toIndexPath.item];
}

@end
