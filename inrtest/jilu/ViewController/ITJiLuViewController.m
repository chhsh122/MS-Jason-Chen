//
//  ITJiLuViewController.m
//  inrtest
//
//  Created by 张涛 on 16/4/18.
//  Copyright © 2016年 张涛. All rights reserved.
//

#import "ITJiLuViewController.h"
#import "Config.h"
#import "CPArenaTableViewCell.h"
#import "releaseViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "math.h"

#import "LoginViewController.h"

#define self_Width CGRectGetWidth([UIScreen mainScreen].bounds)
#define self_Height CGRectGetHeight([UIScreen mainScreen].bounds)

@class AppDelegate;
@interface ITJiLuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end



@implementation ITJiLuViewController

@synthesize tableview;


-(void)viewWillAppear:(BOOL)animated{
    
    if ([[gobalConfig getInstance] IsLogin] ==NO) {
        
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate *appDelegate = [self sharedAppDelegate];
            [appDelegate switchVc:3];
        });
        
        _dataArr = [NSMutableArray array];
        [self.tableview reloadData];
    }else{
        [self getData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightBtn];
    self.navigationController.navigationBarHidden = NO;
    self.title =@"论坛";
    
    [self addSubViews];
}



-(void)getData{
//    dataArr = [NSMutableArray array];
    
    NSString *url = [NSString stringWithFormat:@"https://h1055.com/user/getAllForum.htmls?phonenumber=%@", [[gobalConfig getInstance]phonenumber]];
    [[CPNetWorkRequest sharedClient]get:url parame:nil success:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        if (object[@""] ==0) {
            
            _dataArr  = [dic objectForKey:@"result"];
            //success
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableview reloadData];
                //                [self showHint:[dic objectForKey:@"error"]];
            });
        }else{
            //fail
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [tableview reloadData];
                [SVProgressHUD showWithStatus:@"error"];
            });
            
            
        }
    } failure:^(NSError *err) {
        
    }];
}
-(void)addSubViews{
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - scaleWithSize(46))];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (AppDelegate *)sharedAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CPArenaTableViewCell *cell = [CPArenaTableViewCell cellWithTableView:tableView];
    if (_dataArr.count) {
        cell.title.text= [_dataArr[indexPath.row] objectForKey:@"title"];
        cell.dateLabel.text = [_dataArr[indexPath.row] objectForKey:@"strcreatetime"];
        cell.authorLabel.text =[_dataArr[indexPath.row] objectForKey:@"username"];
        cell.contentLab.text = [_dataArr[indexPath.row] objectForKey:@"content"];
    }
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return scaleWithSize(144);
}

- (void)createRightBtn {
    UIButton *confirmBtn = [[UIButton alloc]init];
    confirmBtn.frame = CGRectMake(0, 0, scaleWithSize(40), scaleWithSize(20));
    [confirmBtn setTitle:@"发帖" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = fontSize(scaleWithSize(18));
    [confirmBtn addTarget:self action:@selector(releaseClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:confirmBtn];
}

- (void)releaseClick {
    if ([[gobalConfig getInstance] IsLogin] ==NO) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        releaseViewController *vc = [[releaseViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //    XCReleaseViewController *vc = [[XCReleaseViewController alloc]init];
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
