//
//  RaceViewController.m
//  Lottery_first
//
//  Created by Guoguo on 2017/4/28.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import "RaceViewController.h"

@interface RaceViewController ()
{
    UIView *viewHeader;
    UIButton *button;
    NSInteger  selectedBtnTag;
    UISearchBar * mySearchBar;
    BOOL clicked;
    BOOL isFootballRace;
    NSMutableArray *buttonArr;
}

@end

@implementation RaceViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    viewHeader.hidden = false;
}
- (void)viewWillDisappear:(BOOL)animated {
    
//    [SVProgressHUD show];

    viewHeader.hidden = true;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:K_NAVBAR_COLOR];

    buttonArr =[NSMutableArray array];
// Do any additional setup after loading the view.
//    self.title = @"赛事";
    self.view.backgroundColor = Guoguo_backgroundColor;
    _dataSourceArr = [[NSMutableArray alloc] init];
    viewHeader = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 26, SCREEN_WIDTH / 3, 38)];
    viewHeader.backgroundColor = [UIColor clearColor];
    [self.navigationController.view addSubview:viewHeader];
    clicked = false;
    NSArray * titleArr = @[@"足球",@"篮球"];
    for (int i = 0; i < titleArr.count; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake((viewHeader.frame.size.width + 1) / 2 * i ,0, (viewHeader.frame.size.width - 1) / 2, viewHeader.frame.size.height - 2 * 8);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 21 + i;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:Guoguo_MainToneColor forState:UIControlStateNormal];
        if (button.tag == 21) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:Guoguo_MainToneColor];
        }
        [button addTarget:self action:@selector(changeBallBtnStatus:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = 1.0f;
        [viewHeader addSubview:button];
        [buttonArr addObject:button];
    }
    [self setupUI];
    isFootballRace = true;
    [self loadFootballRaceNews];
    
}
- (void)setupUI {
    
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 8, self.view.frame.size.width, self.view.frame.size.height - TopBarHeight  - 8) style:UITableViewStylePlain];
    _tabView.showsVerticalScrollIndicator = false;
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.backgroundColor = Guoguo_backgroundColor;
    _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setExtraCellLineHidden:_tabView];
    [self.view addSubview:_tabView];
}

#pragma mark -- BasketBallService
- (void)loadBasketballRaceNews {
    
    [NSThread detachNewThreadSelector:@selector(callServerGetBasketballRaceNews) toTarget:self withObject:nil];
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:Guoguo_MainToneColor];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
-(void)callServerGetBasketballRaceNews
{
    NSDictionary *dic = [AppServiceInterface GetBasketBallRace];
    [self performSelectorOnMainThread:@selector(updateUIAfterCallServerRace:) withObject:dic waitUntilDone:false];
}

- (void)updateUIAfterCallServerRace:(NSDictionary *)dic {

    [SVProgressHUD dismiss];
    [_dataSourceArr removeAllObjects];
    for (NSDictionary *dict in [dic objectForKey:@"data"]) {
        [_dataSourceArr addObjectsFromArray:[dict objectForKey:@"matchInfo"]];
    }
//    [_dataSourceArr addObjectsFromArray:[[[dic objectForKey:@"data"] objectAtIndex:0] objectForKey:@"matchInfo"]];
    [_tabView reloadData];
}
#pragma mark -- FootballService
- (void)loadFootballRaceNews {
    
    [NSThread detachNewThreadSelector:@selector(callServerGetFootballRaceNews) toTarget:self withObject:nil];
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:Guoguo_MainToneColor];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
-(void)callServerGetFootballRaceNews
{
    NSDictionary *dic = [AppServiceInterface GetFootballRace];
    [self performSelectorOnMainThread:@selector(updateUIAfterCallFootballServerRace:) withObject:dic waitUntilDone:false];
}

- (void)updateUIAfterCallFootballServerRace:(NSDictionary *)dic {

    [SVProgressHUD dismiss];
    [_dataSourceArr removeAllObjects];
    for (NSDictionary *dict in [dic objectForKey:@"data"]) {
        [_dataSourceArr addObjectsFromArray:[dict objectForKey:@"matchInfo"]];
    }
    [_tabView reloadData];
}

//多余的空行上不显示分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark -- UITableViewDelegate &  UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCREEN_HEIGHT / 6 + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    RaceViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[RaceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger curRow = [indexPath row];
    NSDictionary *main = [_dataSourceArr objectAtIndex:curRow];
    cell.lblWeekNameTime.text = [NSString stringWithFormat:@"%@ %@ %@", [main objectForKey:@"matchOrder"], [main objectForKey:@"leagueName"], [main objectForKey:@"matchTime"]];//@"周四001 俄超 22：00";
    cell.imgComment.image = [UIImage imageNamed:@"commentNum"];
    cell.lblCommentNum.text = [NSString stringWithFormat:@"%@条聊球", [main objectForKey:@"circleReplyNum"]];//@"486条聊球";
    if (!isFootballRace) {
        cell.lblTitleHome.text = [NSString stringWithFormat:@"%@", [main objectForKey:@"visitName"]];//@"阿姆卡尔";
        cell.lblScore.text = [NSString stringWithFormat:@"%@:%@", [main objectForKey:@"visitGoal"], [main objectForKey:@"hostGoal"]];//@"0:2";
        cell.lblTitleAway.text = [NSString stringWithFormat:@"%@", [main objectForKey:@"hostName"]];//@"克拉斯诺";
    } else {
    
        cell.lblTitleHome.text = [NSString stringWithFormat:@"%@", [main objectForKey:@"teamA"]];//@"阿姆卡尔";
        cell.lblScore.text = [NSString stringWithFormat:@"%@:%@", [main objectForKey:@"teamAGoal"], [main objectForKey:@"teamBGoal"]];//@"0:2";
        cell.lblTitleAway.text = [NSString stringWithFormat:@"%@", [main objectForKey:@"teamB"]];//@"克拉斯诺";
    }
    cell.lblStatus.text =  [NSString stringWithFormat:@"%@", [main objectForKey:@"statusDesc"]];//@"已结束";
    cell.lblHalfScore.text = [NSString stringWithFormat:@"%@", [main objectForKey:@"matchDay"]];//@"半场 0:0";
    //    [cell.imgIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [main objectForKey:@"imageurl"]]] placeholderImage:[UIImage imageNamed:@"替代图片.jpg"]];//[UIImage imageNamed:@"pro_up_img"]
    cell.backgroundColor = Guoguo_backgroundColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger curRow = [indexPath row];
    NSDictionary *main = [_dataSourceArr objectAtIndex:curRow];
    RaceDetailViewController *raceDetailVC = [[RaceDetailViewController alloc] init];
    raceDetailVC.dicDataSource = main;
    raceDetailVC.isFootballRace = isFootballRace;
    [raceDetailVC setHidesBottomBarWhenPushed:true];
    [self.navigationController pushViewController:raceDetailVC animated:true];
}

- (void)changeBallBtnStatus:(UIButton *)sender {
    
    
    for (UIButton *btn  in buttonArr) {
        [btn setTitleColor:Guoguo_MainToneColor forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
    }
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sender setBackgroundColor:Guoguo_MainToneColor];
    if (sender.tag == 21) {

        isFootballRace = true;
        [self loadFootballRaceNews];
    } else if (sender.tag == 22) {
        
        isFootballRace = false;
        [self loadBasketballRaceNews];
    }
    selectedBtnTag = sender.tag;
}

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
