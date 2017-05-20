//
//  AppServiceInterface.m
//  Lottery_first
//
//  Created by SunnyInfo MacBook on 17/4/22.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import "AppServiceInterface.h"
static NSString *HttpBaseURL = @"https://www.h1055.com/";
static NSString *HttpBaseURLRace = @"http://api.caipiao.163.com/";

@implementation AppServiceInterface

+(NSString *)callServerInterfaceReturnByString:(NSString *)url params:(NSMutableDictionary *) paramDict
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSLog(@"url:%@ paramDict: %@",url, paramDict);
    __block id resultEnd = nil;
    /**
     同步请求可以参考manager post里，即手工创建AFHTTPRequestOperation，设置requestSerializer和responseSerializer
     然后start再wait，这里因为设计到https证书，直接创建出来的AFHTTPRequestOperation.securityPolicy设置后不起作用，所以还是用manager
     通过manager post后，得到manager创建的AFHTTPRequestOperation来wait等待结束，不过异步过程中的出错信息拿不到
     */
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", @"text/plain", nil];
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    /*
    [manager POST:url parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        for (NSHTTPCookie *tempCookie in cookies) {
            //打印获得的cookie
            debugLog(@"getCookie: %@", tempCookie);
        }
        
        NSStringEncoding gbEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        //先用utf-8解析
        NSString *result  = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (result == NULL) {
            //解析不到，改用gb2312
            result  = [[NSString alloc] initWithData:responseObject encoding:gbEncoding];
        }
        resultEnd = result;
        dispatch_semaphore_signal(semaphore);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"%@", error);
    }];
     */
    
    [manager GET:url parameters:paramDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSStringEncoding gbEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        //先用utf-8解析
        NSString *result  = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (result == NULL) {
            //解析不到，改用gb2312
            result  = [[NSString alloc] initWithData:responseObject encoding:gbEncoding];
        }
        resultEnd = result;
        dispatch_semaphore_signal(semaphore);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        debugLog(@"%@", error);
    }];
    NSTimeInterval timeout = 20; //超时时间
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, timeout * NSEC_PER_SEC));
    return resultEnd;
}

+(NSDictionary *)parseStringToJson:(NSString*)sourceStr
{
    NSDictionary *resultDict;
    if ([GlobalUnit isBlankString:sourceStr]) {
        resultDict = [NSDictionary dictionaryWithObjectsAndKeys:@"-99",@"errCode",@"网络异常，获取数据失败!", @"errMsg" ,nil];
    }
    else
    {
        /**
         options:
         NSJSONReadingMutableContainers：返回可变容器，NSMutableDictionary或NSMutableArray。
         NSJSONReadingMutableLeaves：返回的JSON对象中字符串的值为NSMutableString，目前在iOS 7上测试不好用，应该是个bug，参见：
         http://stackoverflow.com/questions/19345864/nsjsonreadingmutableleaves-option-is-not-working
         NSJSONReadingAllowFragments：允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。参见：
         http://stackoverflow.com/questions/16961025/nsjsonserialization-nsjsonreadingallowfragments-reading
         */
        NSError *error;
        resultDict = [NSJSONSerialization JSONObjectWithData:[sourceStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        if (resultDict == nil) {
//            debugLog(@"json parse failed \r\n");
            resultDict = [NSDictionary dictionaryWithObjectsAndKeys:@"-98",@"errCode",@"Data parsing error！",@"errMsg", nil];
        }
    }
    return resultDict;
}

+(NSDictionary *)callServerInterface:(NSString *)url params:(NSMutableDictionary *) paramDict
{
    NSDictionary *resultDict;
    resultDict = [self parseStringToJson:[self callServerInterfaceReturnByString:url params:paramDict]];
//    debugLog(@"接口%@\n参数%@\n返回%@",url,paramDict,resultDict);
    return resultDict;
}

// 允许不安全证书的设置
+ (AFSecurityPolicy*)customSecurityPolicy
{
    /**** SSL Pinning ****/
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    securityPolicy.validatesDomainName = NO;
    /**** SSL Pinning ****/
    return securityPolicy;
}


+ (NSDictionary *)Login:(NSString *)mobile password:(NSString *)password {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:mobile forKey:@"phonenumber"];
    [params setObject:password forKey:@"userpwd"];
    return [self callServerInterface:[NSString stringWithFormat:@"%@ozsuser/login.htmls", HttpBaseURL] params:params];
}

+(NSDictionary *)SendMobileCheckCode:(NSString *)mobile {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:mobile forKey:@"phonenumber"];
    return [self callServerInterface:[NSString stringWithFormat:@"%@ozsuser/registerCheckUser.htmls", HttpBaseURL] params:params];
}

+(NSDictionary *)Register:(NSString *)phone password:(NSString *)password verifyCode:(NSString *)verifyCode strTime:(NSString *)strTime userName:(NSString *)userName{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:phone forKey:@"phonenumber"];
    [params setObject:password forKey:@"userpwd"];
    [params setObject:verifyCode forKey:@"code"];
    [params setObject:strTime forKey:@"strTime"];
    [params setObject:userName forKey:@"username"];

    return [self callServerInterface:[NSString stringWithFormat:@"%@ozsuser/register.htmls", HttpBaseURL] params:params];
}
+(NSDictionary *)ForgetPassword:(NSString *)mobile password:(NSString *)password mobileCheckCode:(NSString *)mobileCheckCode {

    return nil;
}

+ (NSDictionary *)GetAllForum:(NSString *)mobile {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:mobile forKey:@"phonenumber"];
    return [self callServerInterface:[NSString stringWithFormat:@"%@ozsuser/getAllForum.htmls", HttpBaseURL] params:params];
}

+ (NSDictionary *)Posting:(NSString *)mobile title:(NSString *)title content:(NSString *)content userName:(NSString *)userName {

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:mobile forKey:@"phonenumber"];
    [params setObject:title forKey:@"title"];
    [params setObject:content forKey:@"content"];
    [params setObject:userName forKey:@"username"];
    
    return [self callServerInterface:[NSString stringWithFormat:@"%@ozsuser/saveForum.htmls", HttpBaseURL] params:params];
}

+(NSDictionary *)GetAllNews {

    return [self callServerInterface:[NSString stringWithFormat:@"%@ozsinterface/getAllNews.htmls?page=home", HttpBaseURL] params:nil];
}

//http://api.caipiao.163.com/live_jclq.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=C70F3605-A233-4EDE-B6BA-DE00386793BD
//http://api.caipiao.163.com/live_jclq.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=C70F3605-A233-4EDE-B6BA-DE00386793BD
+ (NSDictionary *)GetBasketBallRace {
    
    return [self callServerInterface:[NSString stringWithFormat:@"%@live_jclq.html?product=caipiao_client&mobileType=iphone&ver=4.32&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=C70F3605-A233-4EDE-B6BA-DE00386793BD", HttpBaseURLRace] params:nil];
}

//http://api.caipiao.163.com/jjc_live.html?gameEn=jczq&product=caipiao_client&mobileType=iphone&ver=4.32&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=C70F3605-A233-4EDE-B6BA-DE00386793BD
+ (NSDictionary *)GetFootballRace {

    return [self callServerInterface:[NSString stringWithFormat:@"%@jjc_live.html?gameEn=jczq&product=caipiao_client&mobileType=iphone&ver=4.32&channel=appstore&apiVer=1.1&apiLevel=27&deviceId=C70F3605-A233-4EDE-B6BA-DE00386793BD", HttpBaseURLRace] params:nil];
}



@end
