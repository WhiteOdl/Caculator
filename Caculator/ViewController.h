//
//  ViewController.h
//  Caculator
//
//  Created by fz500net on 2019/9/10.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    __weak IBOutlet UILabel *result;
    __weak IBOutlet UILabel *history;
}

- (IBAction)number0:(UIButton *)sender;
- (IBAction)number1:(UIButton *)sender;
- (IBAction)number2:(UIButton *)sender;
- (IBAction)number3:(UIButton *)sender;
- (IBAction)number4:(UIButton *)sender;
- (IBAction)number5:(UIButton *)sender;
- (IBAction)number6:(UIButton *)sender;
- (IBAction)number7:(UIButton *)sender;
- (IBAction)number8:(UIButton *)sender;
- (IBAction)number9:(UIButton *)sender;
- (IBAction)plus:(UIButton *)sender;
- (IBAction)minus:(UIButton *)sender;
- (IBAction)multiply:(UIButton *)sender;
- (IBAction)divide:(UIButton *)sender;
- (IBAction)percent:(UIButton *)sender;
- (IBAction)reverse:(UIButton *)sender;
- (IBAction)clear:(UIButton *)sender;
- (IBAction)equal:(UIButton *)sender;

- (IBAction)dot:(UIButton *)sender;

@end

