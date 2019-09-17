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
    //输出接口result和history分别为2个UIlabel
    //result用来显示输入数字，history用来显示运算结果
    __weak IBOutlet UILabel *result;
    __weak IBOutlet UILabel *history;
    //所有button类的集合，用来在viewDidLoad中描绘边框
    IBOutletCollection(UIButton) NSArray *number;
}

- (IBAction)number:(UIButton *)sender;
    //四则运算：加减乘除
- (IBAction)plus:(UIButton *)sender;
- (IBAction)minus:(UIButton *)sender;
- (IBAction)multiply:(UIButton *)sender;
- (IBAction)divide:(UIButton *)sender;
    //取百分比、相反数的运算
- (IBAction)percent:(UIButton *)sender;
- (IBAction)reverse:(UIButton *)sender;
    //清空history和result中的内容
- (IBAction)clear:(UIButton *)sender;
    //对四则运算取结果
- (IBAction)equal:(UIButton *)sender;
    //小数点
- (IBAction)dot:(UIButton *)sender;
- (void)viewDidLoad;
@end

