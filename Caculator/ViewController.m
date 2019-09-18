//
//  ViewController.m
//  Caculator
//
//  Created by fz500net on 2019/9/10.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import "ViewController.h"
#import "sqlite3.h"

@implementation ViewController : UIViewController

/*
    全局变量说明：
    1.first：用来在四则运算中判断是不是第一次输入数字，
            因为此时history内的内容为空，必须要对history
            初始化，默认为true即第一次输入；
    2.dotExist：用来判断小数点存不存在，以防出现类似于1.2.3
                的输入，默认为不存在；
    3._operator：操作符判断，1～4分别对应加减乘除，0为无四
                则运算操作，默认为0，即不是任何一个四则运算
                符号（他处还有依靠0作逻辑判断）。
 */
bool first = true;
bool dotExist = false;
int _operator = 0;
    /*
     函数说明：点击对应数字按钮，在result中显示数字
     */
- (IBAction)number:(UIButton *)sender {
    //按下按钮时，让history被隐藏，result处于显示状态
    history.hidden = true;
    result.hidden = false;
    //取出按钮上的文本内容，赋值给result的文本中
    NSString *text = [NSString stringWithFormat:@"%@",sender.currentTitle];
    result.text = [result.text stringByAppendingString:text];
}
    /*
     函数说明：加法运算，思路为读取history中的数据和result
            内的数字相加，因此需要对history初始化为0
     */
- (IBAction)plus:(UIButton *)sender {
    /*
     此处逻辑判断意为：
     在满足result中的内容不为空的情况下，如果是第一次按下“+”
     按钮或者当前运算符（四则运算）等于0:
     然后对history内的文本内容初始化为0
     条件“运算符等于0”是为了在按下”=“按钮后实现新的2个数的
     四则运算
     */
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        //history的文本内容初始化，同时first将不再成立
        history.text = @"0";
        first = false;
    }
    /*
     此处逻辑判断意为：
     当当前运算符不是“+”也不是初始值，而且result中的内容不为空
     目的是为了实现类似1+2*3/4这样按下多种运算符的一次性运算
     在只有加法的表达式中（1+2+3+4）此处就不会执行
     */
    if(_operator != 1 && _operator != 0 && ![result.text isEqual:@""])
    {
        //调用一次equal，结算上一次运算结果
        [self equal:nil];
        _operator = 1;
        return;
    }
    //如果history内的内容为空，直接结束函数体
    //目的是为了防止在第一次不输入数字时直接按下运算符
    //导致程序崩溃
    if([history.text  isEqual: @""])
        return;
    //如果result内的内容为空，对result初始化为0
    //目的是为了防止按下运算符后不输入数字直接按下新运算符后
    //导致程序崩溃
    if([result.text isEqual:@""])
        result.text = @"0";
    /*
      此处使用了NSDecimalNumber类进行高精度计算
      局部变量说明：
      1.currentNumber：result的UIlabel中的内容
      2.historyNumber: history的UIlabel中的内容
      3.resultNumber：currentNumber和historyNumber的和
     */
    NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *historyNumber = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *resultNumber = [currentNumber decimalNumberByAdding:historyNumber];
    history.text = [NSString stringWithFormat:@"%@",resultNumber];
    result.text = @"";
    /*
     把运算符变成“+”，然后“加法”函数结束。
     此处已经把运算符变成“+”，无论是在“=”方法里还是其
     他运算的逻辑代码中，都会先进行加法运算。
     */
    _operator = 1;
    dotExist = false;
}
    /*
     函数说明：减法运算，思路为读取history中的数据和result
     内的数字相减，因此需要对history的内容初始化为result
     数字的2倍
     */
- (IBAction)minus:(UIButton *)sender {
    /*
     此处逻辑判断意为：
     在满足result中的内容不为空的情况下，如果是第一次按下“-”
     按钮或者当前运算符（四则运算）等于0:
     然后对history内的文本内容初始化为result数字的2倍
     条件“运算符等于0”是为了在按下”=“按钮后实现新的2个数的
     四则运算
     */
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        /*
         此处使用了NSDecimalNumber类进行高精度计算
         局部变量说明：
         1.currentNumber：result的UIlabel中的内容
         2.Number2: 字符串2的NSDecimalNumber类
         3.resultNumber：currentNumber和Number2差
         */
        NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
        NSDecimalNumber *Number2 = [NSDecimalNumber decimalNumberWithString:@"2"];
        NSDecimalNumber *resultNumber = [currentNumber decimalNumberByMultiplyingBy:Number2];
        //history的文本内容初始化，同时first将不再成立
        history.text = [NSString stringWithFormat:@"%@",resultNumber];
        first = false;
    }
    /*
     此处逻辑判断意为：
     当当前运算符不是“-”也不是初始值，而且result中的内容不为空
     目的是为了实现类似1+2*3/4这样按下多种运算符的一次性运算
     在只有减法的表达式中（1-2-3-4）此处就不会执行
     */
    if(_operator != 2 && _operator != 0 && ![result.text isEqual:@""])
    {
        //调用一次equal，结算上一次运算结果
        [self equal:nil];
        _operator = 2;
        return;
    }
    //此两处一样的逻辑判断，都是为了防止运算符前后无输入而崩溃
    if([history.text  isEqual: @""])
        return;
    if([result.text isEqual:@""])
        result.text = @"0";
    /*
     此处使用了NSDecimalNumber类进行高精度计算
     局部变量说明：
     1.currentNumber：result的UIlabel中的内容
     2.historyNumber: history的UIlabel中的内容
     3.resultNumber：currentNumber和historyNumber的和差
     */
    NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *historyNumber = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *resultNumber = [historyNumber decimalNumberBySubtracting:currentNumber];
    history.text = [NSString stringWithFormat:@"%@",resultNumber];
    result.text = @"";
    /*
     把运算符变成“-”，然后“减法”函数结束。
     此处已经把运算符变成“-”，无论是在“=”方法里还是其
     他运算的逻辑代码中，都会先进行减法运算。
     */
    _operator = 2;
    //因为result的内容被清空了，自然小数点也不会存在
    dotExist = false;
}
    /*
     函数说明：乘法运算，思路为读取history中的数据和result
     内的数字相乘，因此需要对history的内容初始化为1
     */
- (IBAction)multiply:(UIButton *)sender {
    /*
     此处逻辑判断意为：
     在满足result中的内容不为空的情况下，如果是第一次按下“*”
     按钮或者当前运算符（四则运算）等于0:
     然后对history内的文本内容初始化为1
     条件“运算符等于0”是为了在按下”=“按钮后实现新的2个数的
     四则运算
     */
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        //history的文本内容初始化，同时first将不再成立
        history.text = @"1";
        first = false;
    }
    /*
     此处逻辑判断意为：
     当当前运算符不是“*”也不是初始值，而且result中的内容不为空
     目的是为了实现类似1+2*3/4这样按下多种运算符的一次性运算
     在只有乘法的表达式中（1*2*3*4）此处就不会执行
     */
    if(_operator != 3 && _operator != 0 && ![result.text isEqual:@""])
    {
        ///调用一次equal，结算上一次运算结果
        [self equal:nil];
        _operator = 3;
        return;
    }
    //此两处一样的逻辑判断，都是为了防止运算符前后无输入而崩溃
    if([history.text  isEqual: @""])
        return;
    if([result.text isEqual:@""])
        result.text = @"1";
    /*
     此处使用了NSDecimalNumber类进行高精度计算
     局部变量说明：
     1.currentNumber：result的UIlabel中的内容
     2.historyNumber: history的UIlabel中的内容
     3.resultNumber：currentNumber和historyNumber的和积
     */
    NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *historyNumber = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *resultNumber = [currentNumber decimalNumberByMultiplyingBy:historyNumber];
    history.text = [NSString stringWithFormat:@"%@",resultNumber];
    result.text = @"";
    /*
     把运算符变成“*”，然后“乘法”函数结束。
     此处已经把运算符变成“*”，无论是在“=”方法里还是其
     他运算的逻辑代码中，都会先进行乘法运算。
     */
    _operator = 3;
    //因为result的内容被清空了，自然小数点也不会存在
    dotExist = false;
}
    /*
     函数说明：除法运算，思路为读取history中的数据和result
     内的数字相除，因此需要对history的内容初始化为result
     数字的平方
     */
- (IBAction)divide:(UIButton *)sender {
    /*
     此处逻辑判断意为：
     在满足result中的内容不为空的情况下，如果是第一次按下“➗”
     按钮或者当前运算符（四则运算）等于0:
     然后对history内的文本内容初始化为result数字的平方
     条件“运算符等于0”是为了在按下”=“按钮后实现新的2个数的
     四则运算
     */
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        /*
         此处使用了NSDecimalNumber类进行高精度计算
         局部变量说明：
         1.currentNumber：result的UIlabel中的内容
         2.resultNumber：currentNumber和平方
         */
        NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
        NSDecimalNumber *resultNumber = [currentNumber decimalNumberByMultiplyingBy:currentNumber];
        history.text = [NSString stringWithFormat:@"%@",resultNumber];
        first = false;
    }
    /*
     此处逻辑判断意为：
     当当前运算符不是“除”也不是初始值，而且result中的内容不为空
     目的是为了实现类似1+2*3/4这样按下多种运算符的一次性运算
     在只有除法的表达式中（1➗2➗3➗4）此处就不会执行
     */
    if(_operator != 4 && _operator != 0 && ![result.text isEqual:@""])
    {
         //调用一次equal，结算上一次运算结果
        [self equal:nil];
        _operator = 4;
        return;
    }
    //此处一样的逻辑判断，都是为了防止运算符前后无输入而崩溃
    if([history.text isEqual: @""])
        return;
    //如果除数为0，清空result，目的是为了防止0作除数
    if([result.text isEqual:@"0"])
    {
        result.text = @"";
        return;
    }
    //如果result的内容为空，默认赋值1，既是为了防止无输入崩溃，
    //也是为了防止因为输入0导致result内容被清空崩溃
    if([result.text isEqual:@""])
        result.text = @"1";
    /*
     此处使用了NSDecimalNumber类进行高精度计算
     局部变量说明：
     1.currentNumber：result的UIlabel中的内容
     2.historyNumber: history的UIlabel中的内容
     3.resultNumber：historyNumber和currentNumber的商
     */
    NSDecimalNumber *historyNumber = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *resultNumber = [historyNumber decimalNumberByDividingBy:currentNumber];
    history.text = [NSString stringWithFormat:@"%@",resultNumber];
    result.text = @"";
    /*
     把运算符变成“➗”，然后“除法”函数结束。
     此处已经把运算符变成“➗”，无论是在“=”方法里还是其
     他运算的逻辑代码中，都会先进行除法运算。
     */
    _operator = 4;
    dotExist = false;
}
    /*
     函数说明：取余运算
     */
- (IBAction)mod:(UIButton *)sender {
    /*
     此处逻辑判断意为：
     在满足result中的内容不为空的情况下，如果是第一次按下“%”
     按钮或者当前运算符（四则运算）等于0:
     然后对history内的文本内容初始化为result数字的文本内容
     条件“运算符等于0”是为了在按下”=“按钮后实现新的2个数的运算
     */
    if((first || !_operator) && ![result.text isEqual:@""])
    {
        //history的文本内容初始化，同时first将不再成立
        history.text = result.text;
        first = false;
        result.text = @"";
    }
    /*
     此处逻辑判断意为：
     当当前运算符不是“%”也不是初始值，而且result中的内容不为空
     目的是为了实现类似1+2*3/4这样按下多种运算符的一次性运算
     在只有除法的表达式中（1%2%3%4）此处就不会执行
     */
    if(_operator != 5 && _operator != 0 && ![result.text isEqual:@""])
    {
        /*
         因为当前的运算符是其他运算，直接调用“=”按钮的方法
         调用完毕就把运算符变成“%”，然后“取余”函数结束。
         此处已经把运算符变成“%”，无论是在“=”方法里还是其
         他运算的逻辑代码中，都会先进行取余运算。
         即在连续运算中，当前运算按钮总是会先执行上一次的运
         算方法直到按下“=”。
         */
        [self equal:nil];
        _operator = 5;
        return;
    }
    //此处一样的逻辑判断，都是为了防止运算符前后无输入而崩溃
    if([history.text isEqual: @""])
        return;
    //result为空直接返回，等待按下数字后的“=”操作或其他运算操作
    if([result.text isEqual:@""])
    {
        _operator = 5;
        dotExist = false;
        return;
    }
    /*
     此处使用了NSDecimalNumber类进行高精度计算
     局部变量说明：
     1.currentNumber：result的UIlabel中的内容
     2.historyNumber: history的UIlabel中的内容
     3.Result:result和history的int值取整后取余
     结果
     4.resultNumber：取余结果Result写入
     resultNumber中
     */
    NSDecimalNumber *historyNumber = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
    int Result = [historyNumber intValue] % [currentNumber intValue];
    NSDecimalNumber *resultNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",Result]];
    //将resultNumber转化为字符串赋值给history的文本内容
    history.text = [NSString stringWithFormat:@"%@",resultNumber];
    //将result的文本内容清空，利于进行运算符之后的数字输入
    result.text = @"";
    /*
     把运算符变成“%”，然后“除法”函数结束。
     此处已经把运算符变成“%”，无论是在“=”方法里还是其
     他运算的逻辑代码中，都会先进行取余运算。
     */
    _operator = 5;
    //因为result的内容被清空了，自然小数点也不会存在
    dotExist = false;
}
    /*
     函数作用：对当前result的数字取反
     */
- (IBAction)reverse:(UIButton *)sender {
    //如果在result无内容的情况下按下“+/-”按钮，直接退出函数
    //防止进行后续操作时崩溃
    if([result.text  isEqual: @""])
        return;
    /*
     此处使用了NSDecimalNumber类进行高精度计算
     局部变量说明：
     1.currentNumber：result的UIlabel中的内容
     2.reverseNumber: 相反数的实际取值：-1
     3.resultNumber：currentNumber和的operatorPercent的
     积
     */
    NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *reverseNumber = [NSDecimalNumber decimalNumberWithString:@"-1"];
    NSDecimalNumber *resultNumber = [currentNumber decimalNumberByMultiplyingBy:reverseNumber];
    //将resultNumber转化为字符串赋值给result的文本内容
    result.text = [NSString stringWithFormat:@"%@",resultNumber];
    
}
    /*
     函数说明：将result和history这两个UIlabel中的内容清空
     */
- (IBAction)clear:(UIButton *)sender {
    //除了first之外，其他全局变量都变回默认值，是完全的清除
    //不是单方面的清除当前数字
    result.text = @"";
    history.text = @"";
    _operator = 0;
    //因为进行了清空操作，所以小数点自然也不存在了
    if(dotExist)
        dotExist = false;
    //清除完，把histroy隐藏起来，result显示出来
    history.hidden = true;
    result.hidden = false;
}
    /*
     函数说明：“=”按钮的实现，思路为读取history、result这两个
     UIlabel中的数字，根据当前运算符的标志进行四则运算并将结果
     写入history的文本中
     */
- (IBAction)equal:(UIButton *)sender {
    //按下“=”就将history这个UIlabel显示出来
    //运算符不为0，显示运算结果;
    //运算符为0，即在输入数字后直接按“=”
    //将直接舍去result的内容，显示histroy
    if(_operator != 0)
    {
    history.hidden = false;
    result.hidden = true;
    }
    //如果history内的文本为空，但是result的文本不为空，
    //将result的内容直接赋值给history，并清空result
    //目的是为了防止在不输入数字时直接按下“=”导致程序崩溃
    if([history.text isEqual:@""] && ![result.text isEqual:@""])
    {
        history.text = result.text;
        result.text = @"";
        first = false;
        return;
    }
    //如果result内的内容为空，对result初始化为0
    //目的是为了防止按下运算符后不输入数字直接按下“=”后
    //导致程序崩溃
    if([result.text isEqual:@""])
        result.text = @"0";
    /*
     此处使用了NSDecimalNumber类进行高精度计算
     局部变量说明：
     1.currentNumber：result的UIlabel中的内容
     2.historyNumber: history的UIlabel中的内容
     3.resultNumber：currentNumber和的historyNumber的
     四则运算结果
     */
    NSDecimalNumber *currentNumber = [NSDecimalNumber decimalNumberWithString:result.text];
    NSDecimalNumber *historyNumber = [NSDecimalNumber decimalNumberWithString:history.text];
    NSDecimalNumber *resultNumber ;
    int Result = 0;
    /*
     对不同运算符进行不同计算：
     */
    switch (_operator)
    {
    //当运算符是“+”：
    //resulNumber是currentNumber和historyNumber的和
    case 1:
            resultNumber = [currentNumber decimalNumberByAdding:historyNumber];
        break;
    //当运算符是“-”：
    //resulNumber是historyNumber和currentNumber的差
    case 2:
            resultNumber = [historyNumber decimalNumberBySubtracting:currentNumber];
        break;
    //当运算符是“*”：
    //resulNumber是currentNumber和historyNumber的积
    case 3:
            resultNumber = [historyNumber decimalNumberByMultiplyingBy:currentNumber];
        break;
    //当运算符是“➗”：
    //resulNumber是historyNumber和currentNumber的商
    case 4:
            if(currentNumber.doubleValue == 0)
                currentNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
            resultNumber = [historyNumber decimalNumberByDividingBy:currentNumber];
            break;
    //当运算符是“%”
    //需要用整型Result接收数据
        case 5:
            if(currentNumber.intValue == 0)
                currentNumber = [NSDecimalNumber decimalNumberWithString:@"1"];
            Result = [historyNumber intValue] % [currentNumber intValue];
            resultNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",Result]];
        break;
    //当运算符不是加减乘除时：
    //resultNumber的值为historyNumber
        default:
            resultNumber = historyNumber;
    }
    //将result的文本内容清空，利于下一个数字输入
    result.text = @"";
    //将resultNumber转成字符串赋值给history的文本内容
    history.text = [NSString stringWithFormat:@"%@",resultNumber];
    //按下等号后，运算符就变回默认值
    //方便进行连续运算
    _operator = 0;
    //因为result被清空了，所以小数点自然也不存在了
    dotExist = false;
}
    /*
     函数说明：小数点的输入
     */
- (IBAction)dot:(UIButton *)sender {
    //判断小数点是否存在，小数点不存在且result文本内容不为空才
    //可以输入小数点，防止出现“.3” 这样的字符串
    if(!dotExist && ![result.text  isEqual: @""])
    {
        result.text = [result.text stringByAppendingString:@"."];
        dotExist = true;
    }
}
    /*
     函数说明：视图的初始化，此函数中仅实现了对按钮的边框属性操作
     */
- (void)viewDidLoad
{
    [super viewDidLoad];
    //以此遍历number集合中的所有UIButton，给这些button加上
    //边框，边框宽度为1，颜色为黑色
    for(UIButton *button in number)
    {
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor blackColor].CGColor;
    }
    //NSLog(@"%lu",(unsigned long)number.count);
}
@end
