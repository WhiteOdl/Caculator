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
    NSString *BasePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //变量DBpath为完整路径
    NSString *DBpath = [BasePath stringByAppendingString:@"/userInfo.db"];
     
    //成功打开数据库
    if(sqlite3_open([DBpath UTF8String], &sqliteDB) == SQLITE_OK)
        [self createTable:sqliteDB];
    //失败
    else
        NSLog(@"\nfailed,database path:\n%@",DBpath);
}
/*
  函数作用：创建user表
 */
- (int)createTable:(sqlite3 *)DataBase
{
    //创建user表的sql语句
    //uid字段为自增长主键
    const char *createSql = "create table if not exists\
    user (\
    uid integer primary key autoincrement,\
    username varchar(8),\
    password varchar(16)\
    );";
    //错误信息
    char *errorMessage = NULL;
    //使用exec函数执行sql语句
    int createResult = sqlite3_exec(DataBase,createSql,NULL,NULL,
                 &errorMessage);
    if(errorMessage)
    {
        NSLog(@"create table failed:%s",errorMessage);
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
    //如果在UITextFeild中输入了空的用户名，将直接退出函数，不进行查询
    if(User == nil)
        return Empty_InputUser;
    //创建查询sql语句
    NSString *searchSql = [NSString stringWithFormat:@"select * from user where username = '%@';",User];
    //创建查询准备对象searchStatement
    sqlite3_stmt *searchStatement = NULL;
    //创建接收字符串name和password
    NSString *name = nil;
    NSString *password = nil;
    //执行searchStatement
    if(sqlite3_prepare_v2(DataBase, searchSql.UTF8String, -1, &searchStatement, NULL) == SQLITE_OK)
    {
        //因为确保了用户名的唯一性，不进行while循环查询
        //唯一性通过注册账号时检测用户名是否存在体现：存在则不予创建
        //此处name只有2种结果：nil或者User
        //password也只有2种结果：nil或者数据库用户表中的password字段
        if(sqlite3_step(searchStatement) == SQLITE_ROW)
        {
            name = [NSString stringWithFormat:@"%s", sqlite3_column_text(searchStatement,1)];
            password =[NSString stringWithFormat:@"%s", sqlite3_column_text(searchStatement,2)];
        }
    }
    //释放searchStatement占用的内存
    sqlite3_finalize(searchStatement);
    //根据数据库里的信息返回不同的账号状态
    //因为当User为空时，在函数一开始就返回了，所以这里没有进行User == nil判断
    if(name != nil)
    {
        //当user的UITextField里的内容和数据库用户表里password字段相同
        //返回用户已存在和密码正确 2种状态
        if([Password isEqual:password])
            return User_Exist | Password_Correct;
        //否则返回用户已存在和密码不正确 2种状态
        else
            return User_Exist | Password_Error;
    }
    //name == nil代表没有在数据库用户表中查到与User相同的数据，并且当password的UITextField中
    //没有填写数据
    //返回用户不存在和在UITextField中输入了空的密码 2种状态
    if(name == nil && Password == nil)
        return User_NotExist | Empty_InputPassword;
    //当不满足之前任意情况，只返回用户不存在这一种情况
    return User_NotExist;
}
/*
 函数作用：在注册时将user和password这2个UItextfiled里的
 内容插入到数据库的user表中
 */
- (int)insertData:(sqlite3 *)DataBase :(NSString *)User :(NSString *)Password;
{
    //创建插入数据的sql语句
    NSString *insertSql = [NSString stringWithFormat:@"insert into user(username,password) values('%@','%@');",User,Password];
    //创建储存错误信息的字符指针
    char *errorMessage = NULL;
    //用exec函数执行insertSql语句
    int insertResult = sqlite3_exec(DataBase, insertSql.UTF8String, NULL, NULL, &errorMessage);
    //将exec函数的返回值当作此函数返回值
    return insertResult;
}
/*
 函数作用：关闭数据库句柄
 */
- (int)closeDatabase:(sqlite3 *)DataBase
{
    //将close函数的返回值当作此函数的返回值
    return sqlite3_close(DataBase);
}
    //轻触其他空白区域关闭键盘
- (IBAction)onTapGestureRecongnized:(UITapGestureRecognizer *)sender {
    [user resignFirstResponder];
    [password resignFirstResponder];
}
    //按下虚拟键盘return关闭键盘
- (IBAction)TextEndEdit:(UITextField *)sender
{
    [sender resignFirstResponder];
}
/*
 函数作用：Login按钮的动作，登陆成功可以跳转到主页面
 */
- (IBAction)Login:(UIButton *)sender {
    NSString *username = user.text;
    NSString *passwords = password.text;
    //如果查到了与user的UItextField中的数据一样的用户名，并且密码正确
    if([self searchData:sqliteDB :username :passwords] == (User_Exist | Password_Correct))
    {
        //跳转到主页面
        [self performSegueWithIdentifier:@"ToLogin" sender:self];
        [self closeDatabase:sqliteDB];
    }
}
//按下register按钮前往注册页面
- (IBAction)JumpToRegister:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ToRegister" sender:self];
}
/*
 函数作用：Register按钮的动作，用来注册新用户
 */
- (IBAction)Register:(UIButton *)sender {
    NSString *username = user.text;
    NSString *passwords = password.text;
    //如果没查到了与user的UItextField中的数据一样的用户名，并且
    //password的UItextField中的数据不为空
    if(([self searchData:sqliteDB :username :passwords] & User_NotExist) == User_NotExist && ![passwords  isEqual: @""])
    {
        //将此数据插入到数据库表中
        int rc = [self insertData:sqliteDB :username :passwords];
        NSLog(@"rc=%d",rc);
        [self performSegueWithIdentifier:@"BackToLogin" sender:self];
    }
}
//在注册页面按下back返回登陆页面
- (IBAction)BackToLogin:(UIButton *)sender {
    [self performSegueWithIdentifier:@"BackToLogin" sender:self];
}


@end
