//
//  ITSheDingViewController.m
//  inrtest
//
//  Created by 张涛 on 16/4/18.
//  Copyright © 2016年 张涛. All rights reserved.
//

#import "ITSheDingViewController.h"
#import "ForgetViewController.h"
#import "CPInfoHeaderView.h"
#import "LoginViewController.h"
#import "CPCollectViewController.h"
#import "XCHelpTabController.h"

@interface ITSheDingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UIImageView *MainimageView;
@property (strong, nonatomic)  UILabel *LabelName;
@property (strong, nonatomic)  UIButton *LoginBtn;

@property (strong, nonatomic) UITableView *tableview;
@property (nonatomic, strong) CPInfoHeaderView *headerView;
@property(nonatomic,strong)UIView *footView;


@end



@implementation ITSheDingViewController
@synthesize tableview;
@synthesize footView;

- (void)LoginBtn:(id)sender {
    if ([[gobalConfig getInstance] IsLogin] == NO) {
    LoginViewController *login =[[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
    }
}



-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [self createViews];
    if ([[gobalConfig getInstance] IsLogin] == YES) {
        footView.hidden= NO;
    }else{
        footView.hidden= YES;
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;

    
}

- (void)createViews {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview = tableView;
    
    CPInfoHeaderView *headerView = [[CPInfoHeaderView alloc]initWithHeader:CGRectMake(0, 0, SCREEN_SIZE.width, scaleWithSize(238))];
//    headerView.userName = [[gobalConfig getInstance] userName];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LoginBtn:)];
    [headerView addGestureRecognizer:tap];
    [tap release];
    //    tableView.contentInset = UIEdgeInsetsMake(0, 0, scaleWithSize(44), 0);
    tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    footView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, scaleWithSize(200))];
    UIButton *exitBtn =[[UIButton alloc]initWithFrame:CGRectMake(scaleWithSize(20), scaleWithSize(100), SCREEN_SIZE.width - scaleWithSize(40), scaleWithSize(40))];
    exitBtn.backgroundColor = Color(250, 67, 67, 1);;
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:exitBtn];
    tableView.tableFooterView =footView;
    
    [self.view addSubview:tableView];
    
}

#pragma mark exitBtnAction

-(void)exitBtnAction{
    [[gobalConfig getInstance]setIsLogin:NO];
    [[gobalConfig getInstance]setPhonenumber:@""];
    LoginViewController *loginView =[[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return scaleWithSize(65);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [cell.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(scaleWithSize(-16));
        make.centerY.mas_equalTo(cell.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(scaleWithSize(30), scaleWithSize(30)));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = Color(200, 199, 204, 1);
    [cell.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.textLabel.mas_left);
        make.bottom.mas_equalTo(cell.contentView.mas_bottom);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(scaleWithSize(-16));
    }];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"修改密码";
        imageView.image = [UIImage imageNamed:@"shezhiicon"];
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"我的收藏";
        imageView.image = [UIImage imageNamed:@"shoucangicon"];
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"帮助";
        imageView.image = [UIImage imageNamed:@"baomingicon"];
    }
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ForgetViewController *vc = [[ForgetViewController alloc]init];
        vc.isChangePwd = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 1){
        
        if ([[gobalConfig getInstance]IsLogin]) {
            CPCollectViewController *vc = [[CPCollectViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            LoginViewController *loginView = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginView animated:YES];
        }

    }else if (indexPath.row == 2){
        XCHelpTabController *vc = [[XCHelpTabController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)setLoginTableView{
//    tablview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
//    tablview.delegate = self;
//    
//    tablview.dataSource = self;
//    [self.view addSubview:tablview];
}


- (void) myItemClick{
    
//    XCHelpTabController *help = [[XCHelpTabController alloc]init];
//    
//    help.title = @"帮助";
//    
//    [self.navigationController pushViewController:help animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
