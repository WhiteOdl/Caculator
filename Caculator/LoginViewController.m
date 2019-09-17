//
//  LoginViewController.m
//  Caculator
//
//  Created by fz500net on 2019/9/16.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import "LoginViewController.h"
#import "sqlite3.h"
@implementation LoginViewController : UIViewController
/*
 在viewload里初始化数据库，并建立user表
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     数据库名：userInfo.db
     */
    NSString *theStrPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //变量DBpath为完整路径
    NSString *DBpath = [theStrPath stringByAppendingString:@"/userInfo.db"];
    //成功打开数据库
    if(sqlite3_open([DBpath UTF8String], &sqliteDB) == SQLITE_OK)
    {
        int open = [self createTable:sqliteDB];
        NSLog(@"open result=%d,path:%@",open,DBpath);
    }
    //失败
    else
        NSLog(@"failed,path:%@",DBpath);
}
/*
  函数作用：创建user表
 */
- (int)createTable:(sqlite3 *)DataBase
{
    //创建user表的sql语句
    const char *createSql = "create table if not exists\
    user (\
    uid integer primary key autoincrement,\
    username varchar(8),\
    password varchar(16)\
    );";
    //错误信息
    char *errMsg = NULL;
    //使用exec函数执行sql语句
    int createResult = sqlite3_exec(DataBase,createSql,NULL,NULL,
                 &errMsg);
    if(errMsg)
    {
        NSLog(@"create table failed:%s",errMsg);
        return -1;
    }
    //将执行sql语句函数的返回的值作为此函数的返回值
    return createResult;
}
/*
 函数作用：传入的User和Password参数将在数据库里搜索，
 不论是检查登陆和注册时是否用户名重复、登陆密码是否正确都用得到。
 */
- (int)searchData:(sqlite3 *)DataBase :(NSString *)User :(NSString *)Password
{
    if(User == nil)
        return Empty_InputUser;
    NSString *searchSql = [NSString stringWithFormat:@"select * from user where username = '%@';",User];
    sqlite3_stmt *stmt = NULL;
    NSString *name = nil;
    NSString *password = nil;
    if(sqlite3_prepare_v2(DataBase, searchSql.UTF8String, -1, &stmt, NULL) == SQLITE_OK)
    {
        if(sqlite3_step(stmt) == SQLITE_ROW)
        {
            name = [NSString stringWithFormat:@"%s", sqlite3_column_text(stmt,1)];
            password =[NSString stringWithFormat:@"%s", sqlite3_column_text(stmt,2)];
        }
    }
    sqlite3_finalize(stmt);
    if(name != nil)
    {
        if([Password isEqual:password])
            return User_Exist | Password_Correct;
        else
            return User_Exist | Password_Error;
    }
    if(name == nil && Password == nil)
        return User_NotExist | Empty_InputPassword;
    return User_NotExist;
}
/*
 函数作用：在注册时将user和password这2个UItextfiled里的
 内容插入到数据库的user表中
 */
- (int)insertData:(sqlite3 *)DataBase :(NSString *)User :(NSString *)Password;
{
    NSString *insertSql = [NSString stringWithFormat:@"insert into user(username,password) values('%@','%@');",User,Password];
    char *errMsg = NULL;
    int insertResult = sqlite3_exec(DataBase, insertSql.UTF8String, NULL, NULL, &errMsg);
    return insertResult;
}
/*
 函数作用：关闭数据库句柄
 */
- (int)closeDatabase:(sqlite3 *)DataBase
{
    return sqlite3_close(DataBase);
}
/*
 函数作用：Login按钮的动作，登陆成功可以跳转到主页面
 */
- (IBAction)Login:(UIButton *)sender {
    NSString *usr = user.text;
    NSString *pwd = password.text;
    if([self searchData:sqliteDB :usr :pwd] == (User_Exist | Password_Correct))
    {
        [self performSegueWithIdentifier:@"ToLogin" sender:self];
    }
}
/*
 函数作用：Register按钮的动作，用来注册新用户
 */
- (IBAction)Register:(UIButton *)sender {
    NSString *usr = user.text;
    NSString *pwd = password.text;
    if(([self searchData:sqliteDB :usr :pwd] & User_NotExist) == User_NotExist && ![pwd  isEqual: @""])
    {
        int rc = [self insertData:sqliteDB :usr :pwd];
        NSLog(@"rc=%d",rc);
    }
}
@end
