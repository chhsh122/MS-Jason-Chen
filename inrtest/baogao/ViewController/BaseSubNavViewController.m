//
//  BaseSubNavViewController.m
//  Lottery_first
//
//  Created by SunnyInfo MacBook on 17/4/21.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import "BaseSubNavViewController.h"

@interface BaseSubNavViewController ()

@end

@implementation BaseSubNavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backToPre
{
    [self returnAction];
    if (self.backViewController) {
        [self.navigationController popToViewController:self.backViewController animated:enablePopAnimation];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:enablePopAnimation];
    }
}

-(void)returnAction
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:K_NAVBAR_COLOR];

    // Do any additional setup after loading the view.
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"backbuttonBlue"]
                       forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
    btnBack.frame = CGRectMake(0, 0, 11.7, 20);
    btnBackItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
    //添加右滑手势执行back操作
    rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    if (!self.denyBackUp) {
        [self.navigationItem setLeftBarButtonItem:btnBackItem];
        [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
    }
    else
    {
        //不允许返回
    }
    //不管怎么样，都将系统的返回按钮隐藏
    self.navigationItem.hidesBackButton = true;
    enablePopAnimation = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self backToPre];
    }
}

- (void)setDenyBackUp:(BOOL)denyBackUp
{
    if (_denyBackUp == denyBackUp) {
        return;
    }
    
    _denyBackUp = denyBackUp;
    if(_denyBackUp)
    {
        [self.navigationItem setLeftBarButtonItem:nil];
        [self.view removeGestureRecognizer:rightSwipeGestureRecognizer];
    }
    else
    {
        [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
        [self.navigationItem setLeftBarButtonItem:btnBackItem];
    }
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
