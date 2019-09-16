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

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *theStrPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *DBpath = [theStrPath stringByAppendingString:@"/userInfo.db"];
    if(sqlite3_open([DBpath UTF8String], &sqliteDB) == SQLITE_OK)
    {
        int open = [self createTable:sqliteDB];
        NSLog(@"open result=%d,path:%@",open,DBpath);
    }
    else
        NSLog(@"failed,path:%@",DBpath);
    //int quit = [self closeDatabase:sqliteDB];
    //NSLog(@"quit result=%d",quit);
}
- (int)createTable:(sqlite3 *)DataBase
{
    const char *createSql = "create table if not exists\
    user (\
    uid integer primary key autoincrement,\
    username varchar(8),\
    password varchar(16)\
    );";
    char *errMsg = NULL;
    int createResult = sqlite3_exec(DataBase,createSql,NULL,NULL,
                 &errMsg);
    if(errMsg)
    {
        NSLog(@"create table failed:%s",errMsg);
        return -1;
    }
    return createResult;
}
- (int)searchData:(sqlite3 *)DataBase :(NSString *)User :(NSString *)Password
{
    return 1;
}
- (int)insertData:(sqlite3 *)DataBase :(NSString *)User :(NSString *)Password;
{
    NSString *insertSql = [NSString stringWithFormat:@"insert into user(username,password) values('%@','%@')",User,Password];
    char *errMsg = NULL;
    int insertResult = sqlite3_exec(DataBase, insertSql.UTF8String, NULL, NULL, &errMsg);
    return insertResult;
}
- (int)closeDatabase:(sqlite3 *)DataBase
{
    return sqlite3_close(DataBase);
}
- (IBAction)Login:(UIButton *)sender {
    NSString *usr = user.text;
    NSString *pwd = password.text;
    if([self searchData:sqliteDB :usr :pwd])
    {
        [self performSegueWithIdentifier:@"ToLogin" sender:self];
    }
}

- (IBAction)Register:(UIButton *)sender {
    NSString *usr = user.text;
    NSString *pwd = password.text;
    if([self searchData:sqliteDB :usr :pwd])
    {
        int rc = [self insertData:sqliteDB :usr :pwd];
        NSLog(@"rc=%d",rc);
    }
}

@end
