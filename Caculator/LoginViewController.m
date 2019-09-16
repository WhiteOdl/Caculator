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
    sqlite3 *sqliteDB;
    NSString *theStrPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *DBpath = [theStrPath stringByAppendingString:@"/userInfo.db"];
    if(sqlite3_open([DBpath UTF8String], &sqliteDB) == SQLITE_OK)
    {
        int open = [self createTable:sqliteDB];
        //NSLog(@"open result=%d,path:%@",open,DBpath);
    }
    else
        NSLog(@"failed,path:%@",DBpath);
    int quit = [self closeDatabase:sqliteDB];
    //NSLog(@"quit result=%d",quit);
}
- (int)createTable:(sqlite3 *)DateBase
{
    const char *sql = "create table if not exists\
    user (\
    uid integer primary key autoincrement,\
    username varchar(8),\
    password varchar(16)\
    );";
    sqlite3_stmt *stmt = NULL;
    return sqlite3_prepare_v2(DateBase,sql,-1,&stmt,nil);
}
- (int)searchData:(NSString *)User :(NSString *)Password
{
    return 1;
}
- (int)insertData:(sqlite3 *)DateBase
{
    return 1;
}
- (int)closeDatabase:(sqlite3 *)DateBase
{
    return sqlite3_close(DateBase);
}
- (IBAction)Login:(UIButton *)sender {
    NSString *usr = user.text;
    NSString *pwd = password.text;
    if([self searchData:usr :pwd])
    {
        [self performSegueWithIdentifier:@"ToLogin" sender:self];
    }
}

- (IBAction)Register:(UIButton *)sender {
}

@end
