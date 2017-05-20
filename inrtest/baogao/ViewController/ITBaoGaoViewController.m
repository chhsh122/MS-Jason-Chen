//
//  ITBaoGaoViewController.m
//  inrtest
//
//  Created by 张涛 on 16/4/18.
//  Copyright © 2016年 张涛. All rights reserved.
//

#import "ITBaoGaoViewController.h"
#import "CPHallHeaderView.h"
#import "ITKaiJiangViewController.h"
#import "ITSelectNumViewController.h"
#import "ITNewsViewController.h"
#import "ITZhongJiangViewController.h"
#import "ITTeamInfoViewController.h"
#import "ITMatchViewController.h"
#import "PickBallNewController.h"
#import "ITCaiZhongViewController.h"

@interface ITBaoGaoViewController ()<UITableViewDelegate, UITableViewDataSource, CPHallHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CPHallHeaderView *headerView;

@end

@implementation ITBaoGaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self createViews];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(click) name:@"segmentView" object:nil];
    // Do any additional setup after loading the view.
}

- (void)createViews {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = scaleWithSize(112);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    CPHallHeaderView *headerView = [[CPHallHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, screen_height + scaleWithSize(125))];//328
    headerView.delegate = self;
    headerView.imageURLStringsGroup = @[@"banner1", @"banner2", @"banner3"];
    tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
}

#pragma mark 点击button
- (void)didButtonItemClick:(UIButton *)button{
    
//    if (button.tag == 0) {
//        ITKaiJiangViewController *vc = [[ITKaiJiangViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (button.tag == 1){
//        ITSelectNumViewController *vc = [[ITSelectNumViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (button.tag == 2){
//        ITNewsViewController *vc = [[ITNewsViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (button.tag == 3){
//        ITZhongJiangViewController *vc = [[ITZhongJiangViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (button.tag == 4){
//        ITTeamInfoViewController *vc = [[ITTeamInfoViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        ITMatchViewController *vc = [[ITMatchViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    
    if (button.tag == 2) {
        ITNewsViewController *vc = [[ITNewsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 1){
        ITSelectNumViewController *vc = [[ITSelectNumViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 0){
        //        XCTabBarController *tabBarController = [[XCTabBarController alloc] init];
        //        self.window = [UIApplication sharedApplication].keyWindow;
        //        self.tabBarController.selectedIndex = 3;
        ITKaiJiangViewController *kaijiangxinxi =  [[ITKaiJiangViewController alloc]init];
        [self.navigationController pushViewController:kaijiangxinxi animated:YES];
        //        self.window.rootViewController = tabBarController;
        
    }else if (button.tag == 3){
        ITZhongJiangViewController *vc = [[ITZhongJiangViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 4){
        PickBallNewController *vc = [[PickBallNewController alloc]init];
        [vc ContrillerName:@"老 11选5" MethodsName:@"玩法:至少选一个号码 " SectionCount:1 RowCount:12 RandomCount:1 SectionNameArray: @[@"第 一 位"]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 5){
        PickBallNewController *vc = [[PickBallNewController alloc]init];
        //        vc.Count_row = 12;
        //        vc.Count_section = 1;
        //        vc.Newtitle = @"11选5";
        //        vc.section_array = @[@"第 一 位"];
        //        vc.Methods_Name = @"玩法: 至少选一个号码";
        [vc ContrillerName:@"11选5" MethodsName:@"玩法: 至少选一个号码" SectionCount:1 RowCount:11 RandomCount:1 SectionNameArray:@[@"第 一 位"]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 6){
        PickBallNewController *vc = [[PickBallNewController alloc]init];
        //        vc.Count_row = 12;
        //        vc.Count_section = 1;
        //        vc.Newtitle = @"好运 11选5";
        [vc ContrillerName:@"好运 11选5" MethodsName:@"玩法: 至少选一个号码" SectionCount:1 RowCount:12 RandomCount:1 SectionNameArray:@[@"第 一 位"]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 7){
        PickBallNewController *vc = [[PickBallNewController alloc]init];
        //        vc.Count_row = 12;
        //        vc.Count_section = 1;
        //        vc.Newtitle = @"辽宁 11选5";
        //        vc.section_array = @[@"第 一 位"];
        //        vc.Methods_Name = @"玩法: 至少选一个号码";
        [vc ContrillerName:@"辽宁 11选5" MethodsName:@"玩法: 至少选一个号码" SectionCount:1 RowCount:14 RandomCount:1 SectionNameArray: @[@"第 一 位"]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 8){
        PickBallNewController *vc = [[PickBallNewController alloc]init];
        //        vc.Count_row = 12;
        //        vc.Count_section = 1;
        //        vc.Newtitle = @"易乐 11选5";
        //        vc.section_array = @[@"第 一 位"];
        //        vc.Methods_Name = @"玩法: 至少选一个号码";
        [vc ContrillerName:@"易乐 11选5" MethodsName:@"玩法: 至少选一个号码" SectionCount:1 RowCount:31 RandomCount: 1 SectionNameArray: @[@"第 一 位"]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 9){
        PickBallNewController *vc = [[PickBallNewController alloc]init];
        //        vc.Count_row = 80;
        //        vc.Count_section = 1;
        //        vc.Newtitle = @"任选一";
        //        vc.section_array = @[@"第 一 位"];
        //        vc.Methods_Name = @"玩法: 至少选一个号码";
        [vc ContrillerName:@"上海 11选5" MethodsName:@"玩法: 至少选一个号码" SectionCount:1 RowCount:80 RandomCount:1 SectionNameArray: @[@"第 一 位"]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
