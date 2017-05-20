//
//  ForgetViewController.m
//  Domino
//
//  Created by jack.wang on 16/7/18.
//  Copyright © 2016年 jack.wang. All rights reserved.
//

#import "ForgetViewController.h"
#import "NewPassViewController.h"

static int num = 60;

@interface ForgetViewController ()

@property (nonatomic, strong)   UIButton        *varify;

@end

@implementation ForgetViewController

@synthesize strTime;

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createHeaderViewWithBackButton:@"忘记密码"];
    [self addsubviews];
    if (_isChangePwd) {
        self.title = @"修改密码";
    }else{
        self.title=@"忘记密码";
    }
    self.navigationController.navigationBarHidden=NO;
    
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
//    [self.navigationController.navigationBar setBarTintColor:[Utils colorFromHexRGB:@"d91d36"]];
//    [self.navigationController.navigationBar setBarTintColor:K_NAVBAR_COLOR];
    
    // Do any additional setup after loading the view.
}

-(void)addsubviews{
    
    for (int i=0; i<4; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, K_FRAME_NAVIGATION_BAR_HEIGHT+K_FRAME_HEAD_HEIGHT+50*i, K_FRAME_BASE_WIDTH, 1)];
        [lineView setBackgroundColor:[UIColor lightGrayColor]];
        [lineView setAlpha:0.2f];
        [self.view addSubview:lineView];
    }
    
    phoneField = [[UITextField alloc] init];
    [phoneField setFrame:CGRectMake(20, K_FRAME_NAVIGATION_BAR_HEIGHT+K_FRAME_HEAD_HEIGHT, K_FRAME_BASE_WIDTH-40, 50)];
    [phoneField setPlaceholder:@"输入绑定的手机号"];
    [phoneField setDelegate:self];
    [phoneField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:phoneField];
    
    varifyField = [[UITextField alloc] init];
    [varifyField setFrame:CGRectMake(20, K_FRAME_NAVIGATION_BAR_HEIGHT+K_FRAME_HEAD_HEIGHT+50, K_FRAME_BASE_WIDTH-40, 50)];
    [varifyField setPlaceholder:@"验证码"];
    [varifyField setDelegate:self];
    [varifyField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:varifyField];
    //新密码
    newPswField = [[UITextField alloc] init];
    [newPswField setFrame:CGRectMake(20, K_FRAME_NAVIGATION_BAR_HEIGHT+K_FRAME_HEAD_HEIGHT+100, K_FRAME_BASE_WIDTH-40, 50)];
    [newPswField setPlaceholder:@"新密码"];
    [newPswField setDelegate:self];
    [newPswField setReturnKeyType:UIReturnKeyDone];
    [self.view addSubview:newPswField];
    
//    UIView *verifyLine = [[UIView alloc] initWithFrame:CGRectMake(K_FRAME_BASE_WIDTH-110, K_FRAME_NAVIGATION_BAR_HEIGHT+K_FRAME_HEAD_HEIGHT+77.5, 1, 35)];
//    [verifyLine setBackgroundColor:[UIColor lightGrayColor]];
//    [verifyLine setAlpha:0.2f];
//    [self.view addSubview:verifyLine];
    
    UIButton *varifyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [varifyBtn setFrame:CGRectMake(K_FRAME_BASE_WIDTH-100, K_FRAME_NAVIGATION_BAR_HEIGHT+K_FRAME_HEAD_HEIGHT+60, 80, 30)];
    [varifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [varifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    varifyBtn.layer.cornerRadius =5.0;
    varifyBtn.backgroundColor = RGBA(255, 125, 67, 1);
    [varifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [varifyBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [varifyBtn addTarget:self action:@selector(varifyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:varifyBtn];
    self.varify = varifyBtn;
    
    
    

    
//    显示安全输入按钮
    UIImage *NImage = [UIImage imageNamed:@"loginpage_btn_hide.png"];
    UIImage *SImage = [UIImage imageNamed: @"loginpage_btn_display.png"];
    CGFloat BtnY = K_FRAME_NAVIGATION_BAR_HEIGHT+K_FRAME_HEAD_HEIGHT+100+(50-RectHeight(NImage)*2)/2;
    UIButton *showPswBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(K_FRAME_BASE_WIDTH-70, BtnY+5,RectWidth(NImage), RectHeight(NImage))];
    [showPswBtn1 setBackgroundImage:NImage forState:UIControlStateNormal];
    [showPswBtn1 setBackgroundImage:SImage forState:UIControlStateSelected];
    [showPswBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showPswBtn1 addTarget:self action:@selector(setShowPswBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPswBtn1];
    
    self.showPswBtn = showPswBtn1;
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextBtn setFrame:CGRectMake(15, K_FRAME_BASE_HEIGHT/2, K_FRAME_BASE_WIDTH-30, 40)];
    [nextBtn setBackgroundColor:K_COLOR_DAMINO_RED];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    nextBtn.layer.cornerRadius = 5.0;
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

//设置显示密码安全显示
-(void)setShowPswBtn{
    self.showPswBtn.selected =! self.showPswBtn.selected;
    newPswField.secureTextEntry = !newPswField.secureTextEntry;
}


#pragma mark -
#pragma mark button action
-(void)varifyBtnAction:(id)sender{
    if (phoneField.text.length == 11) {
        if ([Utils validateTelPhone:phoneField.text]) {
            [self.varify setUserInteractionEnabled:NO];
            time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendValidCode) userInfo:nil repeats:YES];
        } else {
            [SVProgressHUD showWithStatus:@"手机号码格式不正确"];
        }
    } else {
        [SVProgressHUD showWithStatus:@"请输入11位手机号码"];
    }
}

- (void)sendValidCode {
    if (num == 60) {
        num--;
        
        NSString *urlStr = [NSString stringWithFormat:@"https://www.h1055.com:80/ozsuser/registerCheckUser.htmls?phonenumber=%@",phoneField.text];
        
        [[CPNetWorkRequest sharedClient]get:urlStr parame:nil success:^(id object) {
            if (object[@"errorcode"] == 0) {
                [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
            } else {
                [SVProgressHUD showErrorWithStatus:object[@"error"]];
                num = 0;
            }
        } failure:^(NSError *err) {
            
        }];
        //        [[HttpRequestClient sharedClient] sendValidCode:phoneField.text request:^(int resultCode, NSString *resultMsg, NSDictionary *dataDict, NSError *error) {
        ////            [self showHint:@"验证码发送成功"];
        //        }];
    } else if (num > 0) {
        num--;
        [self.varify setTitle:[NSString stringWithFormat:@"%d(s)",num] forState:UIControlStateNormal];
    } else {
        [time invalidate];
        [self.varify setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.varify setUserInteractionEnabled:YES];
        num = 60;
    }
}

- (void)nextBtnAction:(id)sender{
    NSString *urlStr = [NSString stringWithFormat:@"https://www.h1055.com:80/ozsuser/registerCheckUser.htmls?phonenumber=%@",phoneField.text];
    NSDictionary *dic = @{@"phonenumber":phoneField.text,@"code":varifyField.text,@"userpwd":newPswField.text,@"strTime":strTime};
    [[CPNetWorkRequest sharedClient]get:urlStr parame:dic success:^(id object) {
        if ([object objectForKey:@"code"] !=0) {
            NSString *errStr = [object objectForKey:@"error"];
            [SVProgressHUD showErrorWithStatus:errStr];
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.navigationController  popViewControllerAnimated:YES];
            });
            
        }
    } failure:^(NSError *err) {
        
    }];
    
//    [[HttpRequestClient sharedClient] forgetLoginPassword:nil mobile:phoneField.text newPwd:newPswField.text request:^(int resultCode, NSString *resultMsg, NSDictionary *dataDict, NSError *error) {
//        if (![[dataDict objectForKey:@"code"] isEqualToString:@"000"]) {
//            NSString *errStr = [dataDict objectForKey:@"msg"];
//            [self showHint:errStr];
//            
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [self.navigationController  popViewControllerAnimated:YES];
//            });
//            
//        }
//        NSLog(@"%@",dataDict);
//        
//    }];
//    [self.navigationController popViewControllerAnimated:YES];
//    [HttpRequestClient sharedClient]sendValidCode:<#(NSString *)#> VerificationCode:<#(NSString *)#> VerificationCodeKey:<#(NSString *)#> request:<#^(int resultCode, NSString *resultMsg, NSDictionary *dataDict, NSError *error)request#>
//    if (varifyField.text.length == 6) {
//        [self showHudInView:self.view hint:@"正在验证验证码，请稍等..."];
//        [[HttpRequestClient sharedClient] provingValidCode:varifyField.text mobile:phoneField.text request:^(int resultCode, NSString *resultMsg, NSDictionary *dataDict, NSError *error) {
//            [self hideHud];
//            if (resultCode == 0) {
//                NewPassViewController *newPassController = [[NewPassViewController alloc] initWithMobile:phoneField.text ValidCode:varifyField.text];
//                [self.navigationController pushViewController:newPassController animated:YES];
//            } else {
//                [self showHint:resultMsg];
//            }
//        }];
//    } else {
//        [self showHint:@"验证码输入有误，请重试！"];
//    }
}

#pragma mark -
#pragma mark textfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark menory
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
