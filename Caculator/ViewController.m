//
//  ViewController.m
//  Caculator
//
//  Created by fz500net on 2019/9/10.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController : UIViewController


BOOL first = true;
BOOL isDotExist = false;
int _operator = 0;

- (IBAction)number0:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"0"];
}

- (IBAction)number1:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"1"];
}

- (IBAction)number2:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"2"];
}

- (IBAction)number3:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"3"];
}

- (IBAction)number4:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"4"];
}

- (IBAction)number5:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"5"];
}

- (IBAction)number6:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"6"];
}

- (IBAction)number7:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"7"];
}

- (IBAction)number8:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"8"];
}

- (IBAction)number9:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"9"];
}

- (IBAction)plus:(UIButton *)sender {
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        history.text = @"0";
        first = false;
    }
    if(_operator != 1 && _operator != 0 && ![result.text isEqual:@""])
    {
        [self equal:nil];
        _operator = 1;
        //first = false;
        return;
    }
    if([result.text isEqual:@""])
    {
        result.text = @"0";
    }
    NSDecimalNumber *cur = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *his = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *res = [cur decimalNumberByAdding:his];
    history.text = [NSString stringWithFormat:@"%@",res];
    result.text = @"";
    _operator = 1;
    isDotExist = false;
}

- (IBAction)minus:(UIButton *)sender {
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        NSDecimalNumber *p1 = [NSDecimalNumber decimalNumberWithString:result.text];
        NSDecimalNumber *p2 = [NSDecimalNumber decimalNumberWithString:@"2"];
        NSDecimalNumber *p3 = [p1 decimalNumberByMultiplyingBy:p2];
        history.text = [NSString stringWithFormat:@"%@",p3];
        first = false;
    }
    if(_operator != 2 && _operator != 0 && ![result.text isEqual:@""])
    {
        [self equal:nil];
        _operator = 2;
        //first = false;
        return;
    }
    if([result.text isEqual:@""])
    {
        result.text = @"0";
    }
    NSDecimalNumber *his = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *cur = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *res = [his decimalNumberBySubtracting:cur];
    history.text = [NSString stringWithFormat:@"%@",res];
    result.text = @"";
    _operator = 2;
    isDotExist = false;
}

- (IBAction)multiply:(UIButton *)sender {
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        history.text = @"1";
        first = false;
    }
    if(_operator != 3 && _operator != 0 && ![result.text isEqual:@""])
    {
        [self equal:nil];
        _operator = 3;
        //first = false;
        return;
    }
    if([result.text isEqual:@""])
    {
        result.text = @"1";
    }
    NSDecimalNumber *cur = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *his = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *res = [cur decimalNumberByMultiplyingBy:his];
    history.text = [NSString stringWithFormat:@"%@",res];
    result.text = @"";
    _operator = 3;
    isDotExist = false;
}

- (IBAction)divide:(UIButton *)sender {
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        NSDecimalNumber *p1 = [NSDecimalNumber decimalNumberWithString:result.text];
        NSDecimalNumber *p2 = [p1 decimalNumberByMultiplyingBy:p1];
        history.text = [NSString stringWithFormat:@"%@",p2];
        first = false;
    }
    if(_operator != 4 && _operator != 0 && ![result.text isEqual:@""])
    {
        [self equal:nil];
        _operator = 4;
        //first = false;
        return;
    }
    if([result.text isEqual:@""])
    {
        result.text = @"1";
    }
    NSDecimalNumber *his = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *cur = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *res = [his decimalNumberByDividingBy:cur];
    history.text = [NSString stringWithFormat:@"%@",res];
    result.text = @"";
    _operator = 4;
    isDotExist = false;
}

- (IBAction)percent:(UIButton *)sender {
    NSDecimalNumber *cur = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *p = [NSDecimalNumber decimalNumberWithString:@"0.01"];
    NSDecimalNumber *res = [cur decimalNumberByMultiplyingBy:p];
    result.text = [NSString stringWithFormat:@"%@",res];
}

- (IBAction)reverse:(UIButton *)sender {
    if([result.text  isEqual: @""])
        return;
    NSDecimalNumber *res = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *p = [NSDecimalNumber decimalNumberWithString:@"-1"];
    NSDecimalNumber *rev = [res decimalNumberByMultiplyingBy:p];
    result.text = [NSString stringWithFormat:@"%@",rev];
    
}

- (IBAction)clear:(UIButton *)sender {
    result.text = @"";
}

- (IBAction)equal:(UIButton *)sender {
    if([result.text isEqual:@""])
        result.text = @"0";
    NSDecimalNumber *his = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *cur = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *res ;
    switch (_operator)
    {
    case 1:
            res = [cur decimalNumberByAdding:his];
        break;
    case 2:
            res = [his decimalNumberBySubtracting:cur];
        break;
    case 3:
            if(cur.doubleValue == 0)
               cur = [NSDecimalNumber decimalNumberWithString:@"1"];
            res = [his decimalNumberByMultiplyingBy:cur];
        break;
    case 4:
            if(cur.doubleValue == 0)
                cur = [NSDecimalNumber decimalNumberWithString:@"1"];
            res = [his decimalNumberByDividingBy:cur];
        break;
        default:
            res = his;
    }
    result.text = @"";
    history.text = [NSString stringWithFormat:@"%@",res];
    _operator = 0;
    //first = false;
    isDotExist = false;
}

- (IBAction)dot:(UIButton *)sender {
    if(!isDotExist && ![result.text  isEqual: @""])
        result.text = [result.text stringByAppendingString:@"."];
    isDotExist = true;
}
@end
