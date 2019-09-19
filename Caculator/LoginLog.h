//
//  LoginLog.h
//  Caculator
//
//  Created by fz500net on 2019/9/19.
//  Copyright © 2019 fz500net. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
NS_ASSUME_NONNULL_BEGIN

@interface LoginLog : NSObject
{
}
@property(nonatomic,copy) NSString *ipAddres;
@property(nonatomic,copy) NSString *loginTim;
+(instancetype)shareLoginLog;
//以下2个获取IP函数摘自网络
+(NSString *) getIPAddress:(bool) ipv4;
+(NSDictionary *)getIPAddresses;
@end

NS_ASSUME_NONNULL_END
