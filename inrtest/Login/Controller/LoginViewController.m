//
//  LoginViewController.m
//  Domino
//
//  Created by jack.wang on 16/6/27.
//  Copyright © 2016年 jack.wang. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RegisterWebViewController.h"
#import "ForgetViewController.h"
//#import "ForgotWebViewController.h"
#import "testViewController.h"


static int num = 60;

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize showPswBtn;

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self createHeaderViewWithBackButton:@"登陆"];
    [self addSubviews];
    [self getImageData];
    
    self.title=@"登陆";
    self.navigationController.navigationBarHidden=NO;
    
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
//    [self.navigationController.navigationBar setBarTintColor:[Utils colorFromHexRGB:@"d91d36"]];
//    [self.navigationController.navigationBar setBarTintColor:K_NAVBAR_COLOR];
    // Do any additional setup after loading the view.
}



-(void)addSubviews{
    

    
    
    loginTitleBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginTitleBtn setFrame:CGRectMake(K_FRAME_BASE_WIDTH/2, K_FRAME_NAVIGATION_BAR_HEIGHT+40, 100, 50)];
    [loginTitleBtn setTitle:@"快速登录" forState:UIControlStateNormal];
    [loginTitleBtn setTitleColor:K_COLOR_DAMINO_BLUE forState:UIControlStateSelected];
    [loginTitleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginTitleBtn addTarget:self action:@selector(loginTitleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginTitleBtn];
    
    loginAccountBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginAccountBtn setFrame:CGRectMake(K_FRAME_BASE_WIDTH/2-50, K_FRAME_NAVIGATION_BAR_HEIGHT+40, 100, 50)];
    [loginAccountBtn setTitle:@"账号登录" forState:UIControlStateNormal];
    [loginAccountBtn setTitleColor:K_COLOR_DAMINO_BLUE forState:UIControlStateSelected];
    [loginAccountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginAccountBtn.userInteractionEnabled = NO;
    [loginAccountBtn addTarget:self action:@selector(loginAccountBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginAccountBtn];
    
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, loginTitleBtn.frame.origin.y+52, K_FRAME_BASE_WIDTH, 3)];
    [grayLine setBackgroundColor:[UIColor lightGrayColor]];
    [grayLine setAlpha:0.2f];
    [grayLine.layer setShadowOffset:CGSizeMake(0, 1.0)];
    [grayLine.layer setShadowRadius:0.5];
//    [self.view addSubview:grayLine];
    
    moveLine = [[UIView alloc] initWithFrame:CGRectMake(0, loginTitleBtn.frame.origin.y+50, 100, 3)];
    [moveLine setBackgroundColor:K_COLOR_DAMINO_BLUE];
//    [self.view addSubview:moveLine];
    [self loginTitleBtnAction:nil];
    
//    UIImageView *logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"domino_logo"]];
//    UIImageView *logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconLogin@2x.png"]];
    UIImageView *logoImgView = [[UIImageView alloc] init];
    
//    [logoImgView setFrame:CGRectMake((K_FRAME_BASE_WIDTH-205)/2, CGRectGetMaxY(moveLine.frame)+50, 205, 51)];
    [logoImgView setFrame:CGRectMake(0, CGRectGetMaxY(moveLine.frame), K_FRAME_BASE_WIDTH, 152)];

    logoImgView.image = [UIImage imageNamed:@"icon1.png"];
    logoImgView.contentMode =UIViewContentModeScaleToFill;
    //    [logoImgView setCenter:CGPointMake(K_FRAME_BASE_WIDTH/2, K_FRAME_BASE_HEIGHT/2)];
//    [self.view addSubview:logoImgView];
    
    float logoY = CGRectGetMaxY(grayLine.frame)-50;
    
    for (int i=0; i<3; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, logoY+50*i, K_FRAME_BASE_WIDTH, 1)];
        [lineView setBackgroundColor:[UIColor lightGrayColor]];
        [lineView setAlpha:0.2f];
        [self.view addSubview:lineView];
    }
    
    userField = [[UITextField alloc] initWithFrame:CGRectMake(20, logoY, K_FRAME_BASE_WIDTH-40, 50)];
    [userField setDelegate:self];
    [userField setPlaceholder:@"手机号"];
    userField.text = @"";
    [userField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:userField];
    
    imageCode = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userField.frame), K_FRAME_BASE_WIDTH-40, 50)];
    [imageCode setDelegate:self];
    [imageCode setPlaceholder:@"请输入图形码"];
    [imageCode setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:imageCode];
    imageCode.hidden = YES;
    
    imageLine = [[UIView alloc] initWithFrame:CGRectMake(K_FRAME_BASE_WIDTH-140, CGRectGetMaxY(userField.frame)+7.5, 1, 35)];
    [imageLine setBackgroundColor:[UIColor lightGrayColor]];
    [imageLine setAlpha:0.2f];
    [self.view addSubview:imageLine];
    imageLine.hidden = YES;
    
    imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageButton setFrame:CGRectMake(K_FRAME_BASE_WIDTH-130, CGRectGetMaxY(userField.frame), 120, 50)];
    [imageButton addTarget:self action:@selector(imageBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imageButton];
    imageButton.hidden = YES;
    
    passField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userField.frame), K_FRAME_BASE_WIDTH-40, 50)];
    [passField setDelegate:self];
    [passField setPlaceholder:@"密码"];
    passField.text = @"Qwer";
    [passField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:passField];
    
    buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(userField.frame)+100, K_FRAME_BASE_WIDTH, 1)];
    [buttomLine setBackgroundColor:[UIColor lightGrayColor]];
    [buttomLine setAlpha:0.2f];
    [self.view addSubview:buttomLine];
    buttomLine.hidden = YES;
    
    //显示安全输入按钮

    UIImage *NImage = [UIImage imageNamed:@"loginpage_btn_hide.png"];
    UIImage *SImage = [UIImage imageNamed: @"loginpage_btn_display.png"];
    CGFloat BtnY = logoY+105+(50-RectHeight(NImage)*2)/2;
    //K_FRAME_BASE_HEIGHT/3+100
    UIButton *showPswBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(K_FRAME_BASE_WIDTH-50,BtnY , RectWidth(NImage), RectHeight(NImage))];
    [showPswBtn1 setBackgroundImage:NImage forState:UIControlStateNormal];
    [showPswBtn1 setBackgroundImage:SImage forState:UIControlStateSelected];
    [showPswBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showPswBtn1 addTarget:self action:@selector(setShowPswBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPswBtn1];
    self.showPswBtn = showPswBtn1;
    
    verifyLine = [[UIView alloc] initWithFrame:CGRectMake(K_FRAME_BASE_WIDTH-140, logoY+77.5, 1, 35)];
    [verifyLine setBackgroundColor:[UIColor lightGrayColor]];
    [verifyLine setAlpha:0.2f];
    [self.view addSubview:verifyLine];
    
    verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyButton setFrame:CGRectMake(K_FRAME_BASE_WIDTH-130, logoY+50, 120, 50)];
    [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [verifyButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [verifyButton addTarget:self action:@selector(verifyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verifyButton];
    
    forgetPassButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [forgetPassButton setFrame:CGRectMake(20, logoY+100, 70, 40)];
    [forgetPassButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPassButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [forgetPassButton setTitleColor:K_COLOR_DAMINO_BLUE forState:UIControlStateNormal];
    [forgetPassButton addTarget:self action:@selector(forgetPassBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassButton];
    
    registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerButton setFrame:CGRectMake(K_FRAME_BASE_WIDTH-60, logoY+100, 45, 40)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [registerButton setTitleColor:K_COLOR_DAMINO_BLUE forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(30, logoY+250, K_FRAME_BASE_WIDTH-60, 40)];
    [loginButton setBackgroundColor:K_COLOR_DAMINO_RED];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    loginButton.layer.cornerRadius = 5.0;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [self loginAccountBtnAction:loginAccountBtn];
}

#pragma mark -
#pragma mark button action

-(void)loginTitleBtnAction:(id)sender{
    
    [loginTitleBtn setSelected:YES];
    [loginAccountBtn setSelected:NO];
    
    [verifyLine setHidden:NO];
    [verifyButton setHidden:NO];
    [forgetPassButton setHidden:YES];
    [registerButton setHidden:YES];
    [buttomLine setHidden:NO];
    [imageButton setHidden:NO];
    [imageLine setHidden:NO];
    
    [userField setPlaceholder:@"手机号"];
    [imageCode setHidden:NO];
    [passField setPlaceholder:@"验证码"];
    [passField setSecureTextEntry:NO];
    
    [userField setText:@""];
    [passField setText:@""];
    showPswBtn.hidden =YES;
    
    [moveLine.layer addAnimation:[self moveX:0.3f X:[NSNumber numberWithFloat:loginTitleBtn.frame.origin.x]] forKey:nil];
    
    [self reloadTitelBtnAction];
}

- (void)reloadTitelBtnAction {
    [passField setFrame:CGRectMake(20, CGRectGetMaxY(imageCode.frame), K_FRAME_BASE_WIDTH-40, 50)];
    [verifyLine setFrame:CGRectMake(K_FRAME_BASE_WIDTH-140, CGRectGetMaxY(imageCode.frame)+7.5, 1, 35)];
    [verifyButton setFrame:CGRectMake(K_FRAME_BASE_WIDTH-130, CGRectGetMaxY(imageCode.frame), 120, 50)];
    [loginButton setFrame:CGRectMake(0, CGRectGetMaxY(imageCode.frame)+100, K_FRAME_BASE_WIDTH, 40)];
}

-(void)loginAccountBtnAction:(id)sender{
    [loginTitleBtn setSelected:NO];
    [loginAccountBtn setSelected:YES];
    
    [verifyLine setHidden:YES];
    [verifyButton setHidden:YES];
    [forgetPassButton setHidden:NO];
    [registerButton setHidden:NO];
    [buttomLine setHidden:YES];
    [imageButton setHidden:YES];
    [imageLine setHidden:YES];
    
    [userField setPlaceholder:@"账号/手机号"];
    [imageCode setHidden:YES];
    [passField setPlaceholder:@"密码"];
    
    [passField setSecureTextEntry:YES];
    
    [userField setText:@""];
    [passField setText:@""];
    showPswBtn.hidden =NO;
    
    [moveLine.layer addAnimation:[self moveX:0.3f X:[NSNumber numberWithFloat:loginAccountBtn.frame.origin.x]] forKey:nil];
    
    [self reloadActionBtnAction];
}

- (void)reloadActionBtnAction {
    [passField setFrame:CGRectMake(20, CGRectGetMaxY(userField.frame), K_FRAME_BASE_WIDTH-40, 50)];
    [verifyLine setFrame:CGRectMake(K_FRAME_BASE_WIDTH-140, CGRectGetMaxY(userField.frame)+7.5, 1, 35)];
    [verifyButton setFrame:CGRectMake(K_FRAME_BASE_WIDTH-130, CGRectGetMaxY(userField.frame), 120, 50)];
    [loginButton setFrame:CGRectMake(0, CGRectGetMaxY(userField.frame)+100, K_FRAME_BASE_WIDTH, 40)];
}

//设置显示密码安全显示
-(void)setShowPswBtn{
    self.showPswBtn.selected =! self.showPswBtn.selected;
    passField.secureTextEntry = !passField.secureTextEntry;
}

//更新图片验证码
- (void)imageBtnAction {
    
    [self getImageData];
}



//请求获取图片验证码
- (void)getImageData {
//    [[HttpRequestClient sharedClient] getUserValidCode:^(int resultCode, NSString *resultMsg, NSDictionary *dataDict, NSError *error) {
//        if (resultCode == 0) {
//            NSString *base64 = dataDict[@"ImageBase64String"];
//            [imageButton setImage:[UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters]] forState:UIControlStateNormal];
//            VerificationCodeKey = dataDict[@"VerificationCodeKey"];
//        }
//    }];
}

//--------

- (void)verifyBtnAction:(id)sender{
    if (userField.text.length == 11) {
        if ([Utils validateTelPhone:userField.text]) {
            if (imageCode.text.length > 0 && imageCode.text.length <= 4) {
                [verifyButton setUserInteractionEnabled:NO];
                time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendValidCode) userInfo:nil repeats:YES];
            } else {
                [SVProgressHUD showErrorWithStatus:@"图形验证码长度有误，请重新输入后再试！"];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"手机号码格式不正确"];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
    }
}

- (void)sendValidCode {
    
    if (num == 60) {
        num--;
        NSString *urlStr = [NSString stringWithFormat:@"https://www.h1055.com:80/ozsuser/registerCheckUser.htmls?phonenumber=%@",userField.text];
        
        [[CPNetWorkRequest sharedClient]get:urlStr parame:nil success:^(id object) {
            if (object[@"errorcode"] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
            } else {
                [SVProgressHUD showErrorWithStatus:object[@"error"]];
                num = 0;
            }
        } failure:^(NSError *err) {
            
        }];
        
    } else if (num > 0) {
        num--;
        [verifyButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",num] forState:UIControlStateNormal];
    } else {
        [time invalidate];
        [self getImageData];
        [verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [verifyButton setUserInteractionEnabled:YES];
        num = 60;
    }
    
}

- (void)registerBtnAction:(id)sender{
    RegisterViewController *registerController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];

}

- (void)forgetPassBtnAction:(id)sender{
    ForgetViewController  *forgotViewController = [[ForgetViewController alloc] init] ;
//    forgotViewController.phoneStr = userField.text;
    [self.navigationController pushViewController:forgotViewController animated:YES];
}

- (void)loginBtnAction:(id)sender{
    
//    testViewController *test   =[[testViewController alloc]init];
//    [self.navigationController pushViewController:test animated:YES];
//    
    
    NSString *password = nil;
    NSString *code = nil;
    
    if (userField.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"账号不能为空，请输入后再试！"];
        return;
    }
    
    if (loginTitleBtn.selected) {
        if (passField.text.length > 0) {
            code = passField.text;
        } else {
            [SVProgressHUD showErrorWithStatus:@"验证码不能为空，请输入后再试！"];
            
            return;
        }
    } else {
        if (passField.text.length > 0) {
            password = passField.text;
        } else {
            [SVProgressHUD showErrorWithStatus:@"密码不能为空，请输入后再试！"];
            return;
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"https://www.h1055.com/ozsuser/login.htmls"];
    NSDictionary *dic = @{@"phonenumber": userField.text,@"userpwd":password};
    [[CPNetWorkRequest sharedClient]get:urlStr parame:dic success:^(id object) {
        if (![[object objectForKey:@"errorcode"]  isEqualToString:@"0"]) {
            NSString *errStr = [object objectForKey:@"error"];
            [SVProgressHUD showErrorWithStatus:errStr];
            
        }else{
            [[gobalConfig getInstance] setUserName: object[@"result"][@"username"]];
            [[gobalConfig getInstance] setPhonenumber:object[@"result"][@"phonenumber"]];
            [[gobalConfig getInstance]setIsLogin:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            });
            
        }
        
    } failure:^(NSError *err) {
        
    }];

}

-(void)backBtnAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark view animation

-( CABasicAnimation *)moveX:( float )time X:( NSNumber *)x
{
    NSLog(@"X:%@",x);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath : @"transform.translation.x" ]; ///.y 的话就向下移动。
    animation. toValue = x;
    animation. duration = time;
    animation. removedOnCompletion = NO ; //yes 的话，又返回原位置了。
    animation. repeatCount = 0 ;
    animation. fillMode = kCAFillModeForwards;
    
    return animation;
}

#pragma mark -
#pragma mark textfield
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    [self changeViewHeightForkeyBoardWillShow:self.view];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
