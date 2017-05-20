//
//  AppServiceInterface.h
//  Lottery_first
//
//  Created by SunnyInfo MacBook on 17/4/22.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppServiceInterface : NSObject





+(NSDictionary *)SendMobileCheckCode:(NSString *)mobile;
+(NSDictionary *)Login:(NSString *)mobile password:(NSString *)password;
+(NSDictionary *)Register:(NSString *)phone password:(NSString *)password verifyCode:(NSString *)verifyCode strTime:(NSString *)strTime userName:(NSString *)userName;
+(NSDictionary *)ForgetPassword:(NSString *)mobile password:(NSString *)password mobileCheckCode:(NSString *)mobileCheckCode;
+(NSDictionary *)GetAllForum:(NSString *)mobile;
+(NSDictionary *)Posting:(NSString *)mobile title:(NSString *)title content:(NSString *)content userName:(NSString *)userName;
+(NSDictionary *)GetAllNews;

//http://url.cn/47zECA
+(NSDictionary *)GetBasketBallRace;
+(NSDictionary *)GetFootballRace;
@end
