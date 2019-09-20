//
//  LogViewController.h
//  Caculator
//
//  Created by fz500net on 2019/9/20.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginLog.h"
NS_ASSUME_NONNULL_BEGIN

@interface LogViewController : UITableViewController
{
    UILabel *IPlabel;
}
@property(nonatomic,copy) NSString *ipAddres;
-(void)init:(UITableViewCellStyle *)style :(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
