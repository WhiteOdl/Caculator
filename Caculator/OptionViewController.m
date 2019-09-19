//
//  OptionViewController.m
//  Caculator
//
//  Created by fz500net on 2019/9/18.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import "OptionViewController.h"
#import "LoginLog.h"
@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *addresses = [LoginLog getIPAddresses];
    for(NSString *key in addresses)
    {
        NSLog(@"%@:%@",key,addresses[key]);
    }
    // Do any additional setup after loading the view.
}


- (IBAction)Exit:(UIButton *)sender {
    //exit(0);
}
@end
