//
//  LoginViewController.h
//  Caculator
//
//  Created by fz500net on 2019/9/16.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UITabBarController
{

}
- (void) leftGesture:(UISwipeGestureRecognizer *) recognizer;
- (void) rightGesture:(UISwipeGestureRecognizer *) recognizer;
- (void) upGesture:(UISwipeGestureRecognizer *) recognizer;
- (void) downGesture:(UISwipeGestureRecognizer *)recognizer;
@end

NS_ASSUME_NONNULL_END
