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
    __weak IBOutlet UITextField *user;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UIButton *login;
    __weak IBOutlet UIButton *regist;
}
- (IBAction)Login:(UIButton *)sender;
- (IBAction)Register:(UIButton *)sender;
- (int)createTable:(sqlite3 *)DateBase;
- (int)searchData:(NSString *)User :(NSString *)Password;
- (int)insertData:(sqlite3 *)DateBase;
- (int)closeDatabase:(sqlite3 *)DateBase;
@end

NS_ASSUME_NONNULL_END
