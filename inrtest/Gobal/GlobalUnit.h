//
//  GlobalUnit.h
//  Lottery_first
//
//  Created by SunnyInfo MacBook on 17/4/21.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define globalManager [GlobalUnit shareManager]
#define NotificationLoginSuccess @"NotificationLoginSuccess"
#define NotificationPostingSuccess @"NotificationPostingSuccess"


@interface GlobalUnit : NSObject

+ (GlobalUnit *) shareManager;

+ (BOOL) isBlankString:(NSString *)string;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSInteger)getIntValue:(id)object;

+(NSInteger)getIntValue:(id)object withDefault:(NSInteger)defaultvalue;

+(NSString *)getStringValue:(id)object;

+(NSString *)getStringValue:(id)object withDefault:(NSString*)defaultvalue;

+(void)showAlertHint:(NSString*)title message:(NSString*)message viewcontroller:(UIViewController *)viewcontroller;

+(void)showMessage:(NSString *)message viewcontroller:(UIViewController *)viewcontroller;

+(void)showPopHint:(NSString *)contentMessage targetView:(UIView*)popView showInView:(UIView*)showView;

//提取的通用接口，在一个view上创建左边title，中间内容和右边箭头的方法，contentX为负数的时候，不创建内容部分，showArrow为false的时候不创建箭头，中间的内容支持label和textfield
+(id)addTitleContentArrowViews:(UIView*)parentView font:(UIFont*)font title:(NSString*)title contentText:(NSString*)content contentX:(NSInteger)contentX contentClass:(NSString*)contentClass txtDelegate:(id<UITextFieldDelegate>)txtDelegate showArrow:(BOOL)showArrowImg;

+ (BOOL) isMobile:(NSString *)mobileNumbel;

@property (nonatomic) BOOL isLogined;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *userName;


@end
