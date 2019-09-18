//
//  LoginViewController.h
//  Caculator
//
//  Created by fz500net on 2019/9/16.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
{
    //暂时使用1个sqlite3变量
    sqlite3 *sqliteDB;
    //4个输出接口：
    //2个对应UITextField输入框：用户、密码
    //2个对应UIbutton按钮：登陆、注册
    __weak IBOutlet UITextField *user;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UIButton *login;
    __weak IBOutlet UIButton *regist;
    /*
     枚举类：
     账户状态：
     用户存在 = 1，
     用户不存在 = 2，
     密码错误 = 4，
     密码正确 = 8，
     在UITextField中输入了空的用户名 = 16，
     在UITextField中输入了空的密码 = 32，
     */
    enum accountStatus
    {
        User_Exist = 1,
        User_NotExist = 2,
        Password_Error = 4,
        Password_Correct = 8,
        Empty_InputUser = 16,
        Empty_InputPassword = 32,
    };
}
//2个Button的控制方法
- (IBAction)Login:(UIButton *)sender;
- (IBAction)Register:(UIButton *)sender;
//数据库操作的方法：
//建立用户表
- (int)createTable:(sqlite3 *)DataBase;
//查询信息
- (int)searchData:(sqlite3 *)DataBase :(NSString *)User :(NSString *)Password;
//注册信息
- (int)insertData:(sqlite3 *)DataBase :(NSString *)User :(NSString *)Password;
//关闭数据库
- (int)closeDatabase:(sqlite3 *)DateBase;
- (IBAction)onTapGestureRecongnized:(UITapGestureRecognizer *)sender;

@end

NS_ASSUME_NONNULL_END
