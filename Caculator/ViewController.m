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
    result.text = [result.text stringByAppendingString:@"9"];
}

- (IBAction)number9:(UIButton *)sender {
    result.text = [result.text stringByAppendingString:@"9"];
}

- (IBAction)plus:(UIButton *)sender {
    if(first && ![result.text isEqual:@""])
    {
        history.text = @"0";
        first = false;
    }
    if([result.text isEqual:@""])
    {
        result.text = @"0";
    }
    
    double sum =[history.text doubleValue];
    double number =[result.text doubleValue];
    sum += number;
    history.text = [NSString stringWithFormat:@"%f",sum];
    result.text = @"";
    _operator = 1;
    isDotExist = false;
}

- (IBAction)minus:(UIButton *)sender {
    if(first && ![result.text isEqual:@""])
    {
        double current = [result.text doubleValue];
        history.text = [NSString stringWithFormat:@"%f",current * 2];
        first = false;
    }
    if([result.text isEqual:@""])
    {
        result.text = @"0";
    }
    
    double minus =[history.text doubleValue];
    double number =[result.text doubleValue];
    minus -= number;
    history.text = [NSString stringWithFormat:@"%f",minus];
    result.text = @"";
    _operator = 2;
    isDotExist = false;
}

- (IBAction)multiply:(UIButton *)sender {
    if(first && ![result.text isEqual:@""])
    {
        history.text = @"1";
        first = false;
    }
    if([result.text isEqual:@""])
    {
        result.text = @"0";
    }
    
    double mul =[history.text doubleValue];
    double number =[result.text doubleValue];
    mul *= number;
    history.text = [NSString stringWithFormat:@"%f",mul];
    result.text = @"";
    _operator = 3;
    isDotExist = false;
}

- (IBAction)divide:(UIButton *)sender {
    if(first && ![result.text isEqual:@""])
    {
        double current = [result.text doubleValue];
        history.text = [NSString stringWithFormat:@"%f",current * current];
        first = false;
    }
    if([result.text isEqual:@""])
    {
        result.text = @"1";
    }
    
    double div =[history.text doubleValue];
    double number =[result.text doubleValue];
    if(number <= 0.0000001f)
        number = 1;
    div /= number;
    history.text = [NSString stringWithFormat:@"%f",div];
    result.text = @"";
    _operator = 4;
    isDotExist = false;
}

- (IBAction)percent:(UIButton *)sender {
    double result_number = [result.text doubleValue];
    double percent_number = result_number * 0.01;
    result.text = [NSString stringWithFormat:@"%f",percent_number];
}

- (IBAction)reverse:(UIButton *)sender {
    if([result.text  isEqual: @""])
        result.text = @"0";
    double result_number = [result.text doubleValue];
    double reverse_number = -result_number;
    result.text = [NSString stringWithFormat:@"%f",reverse_number];
    
}

- (IBAction)clear:(UIButton *)sender {
    result.text = @"";
}

- (IBAction)equal:(UIButton *)sender {
    if([result.text isEqual:@""])
        result.text = @"0";
    double history_number = [history.text doubleValue];
    double current_number = [result.text doubleValue];
    double result_number;
    switch (_operator)
    {
    case 1:
        result_number = history_number + current_number;
        break;
    case 2:
        result_number = history_number - current_number;
        break;
    case 3:
        if(current_number <= 0.0000001f)
            current_number = 1.0f;
        result_number = history_number * current_number;
        break;
    case 4:
        if(current_number <= 0.0000001f)
            current_number = 1.0f;
            result_number = history_number / (current_number * 0.1f);
        break;
        default:
            result_number = history_number;
    }
    result.text = @"";
    history.text = [NSString stringWithFormat:@"%f",result_number];
    _operator = 0;
    first = true;
    isDotExist = false;
}

- (IBAction)dot:(UIButton *)sender {
    if(!isDotExist && ![result.text  isEqual: @""])
        result.text = [result.text stringByAppendingString:@"."];
    isDotExist = true;
}
@end
