//
//  LoginViewController.m
//  Caculator
//
//  Created by fz500net on 2019/9/16.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController
- (void) leftGesture:(UISwipeGestureRecognizer *)recognizer
{
    //if(self.selectedIndex != 1)
        self.selectedIndex += 1;
}
- (void) rightGesture:(UISwipeGestureRecognizer *)recognizer
{
    //if(self.selectedIndex != 0)
        self.selectedIndex -= 1;
}
- (void) upGesture:(UISwipeGestureRecognizer *)recognizer
{
    
}
- (void) downGesture:(UISwipeGestureRecognizer *)recognizer
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 把向右的手势添加进right中
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightGesture:)];
    [right setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:right];
    // 把向左的手势添加进left中
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftGesture:)];
    [left setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:left];
    //把向上的手势添加进up中
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upGesture:)];
    [up setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:up];
    //把向下的手势添加进down中
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downGesture:)];
    [down setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:down];
}


@end
