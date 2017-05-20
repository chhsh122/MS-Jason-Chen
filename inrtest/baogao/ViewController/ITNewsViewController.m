//
//  ITNewsViewController.m
//  inrtest
//
//  Created by 张涛 on 2017/4/25.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import "ITNewsViewController.h"
#import "ITBaoGaoViewCell.h"
#import "BaseDetailViewController.h"


@interface ITNewsViewController ()<UITableViewDataSource, UITableViewDelegate,SDCycleScrollViewDelegate>

@end

@implementation ITNewsViewController{
    NSArray *dataArr;
    UITableView  *tableview;
    UIView *grayBgView;
    NSString *webUrlStr;
    NSMutableArray *imageArr;
}


-(void)viewWillAppear:(BOOL)animated{
    [self getInfoData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"彩讯";
    [self addSubViews];

//    [self addSubViews];
    // Do any additional setup after loading the view.
}

-(void)getInfoData{
    imageArr = [NSMutableArray array];
    [[CPNetWorkRequest sharedClient]get:@"https://www.h1055.com/interface/getAllNews.htmls?page=list" parame:nil success:^(id object) {
        if (![[object objectForKey:@"errorcode"]  isEqualToString:@"0"]) {
            NSString *errStr = [object objectForKey:@"msg"];
            //           [self showHint:errStr];
            
        }else{
            [tableview.mj_header endRefreshing];
            dataArr = [object objectForKey:@"result"];
            for (int i = 0  ; i<dataArr.count; i++) {
                [imageArr addObject:[dataArr[i] objectForKey:@"imageurl"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
//                addScorllView;
                [self addScorllView];
                [tableview reloadData];
            });
        }
        
    } failure:^(NSError *err) {
        
    }];
    
}

-(void)addScorllView{
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, scaleWithSize(200))];
    
    

    
        //创建轮播图
    
    
    //scaleWithSize(163)
    CGRect frame = CGRectMake(0, 0, SCREEN_SIZE.width, 163);
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
    cycleScrollView.delegate = self;
    cycleScrollView.imageURLStringsGroup = imageArr;
    cycleScrollView.autoScrollTimeInterval = 5;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView = cycleScrollView;
    [bgView addSubview:self.cycleScrollView];
    

    //猜你喜欢
    UILabel *likeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, K_RECT_MAXY(cycleScrollView), kWidth, 30)];
    likeLab.text = @"❤️热门资讯推荐";
    likeLab.font = [UIFont systemFontOfSize:scaleWithSize(13) weight:UIFontWeightThin];
    [bgView addSubview:likeLab];
    
    //line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, K_RECT_MAXY(likeLab), kWidth, 1)];
    line.backgroundColor = Color(200, 199, 204, 1);
    [bgView addSubview:line];
    
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.bottom.mas_equalTo(grayView.mas_bottom);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width, 1));
//    }];
//    [likeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_right).offset(scaleWithSize(15));
//        make.centerY.mas_equalTo(cycleScrollView.mas_centerY);
//        make.width.mas_lessThanOrEqualTo(150);
//    }];
    tableview.tableHeaderView =bgView;
}

-(void)addSubViews{
    
    //
    //创建轮播图
    
//    CPHallHeaderView *headerView = [[CPHallHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, screen_height + scaleWithSize(125))];//328
//    headerView.delegate = self;
//    headerView.imageURLStringsGroup = @[@"banner1", @"banner2", @"banner3"];
//    tableView.tableHeaderView = headerView;
//    self.headerView = headerView;

//    [self.view addSubview:cycleScrollView];
        [self addScorllView];
    //tablview
    tableview = [[UITableView alloc]initWithFrame:self.view.frame];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableview.rowHeight = scaleWithSize(110);
    [self.view addSubview:tableview];
    
    
    tableview.tableHeaderView = _cycleScrollView;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getInfoData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    tableview.mj_header = header;
    [header beginRefreshing];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_SIZE.width -18,SCREEN_SIZE.height, 18.0)];
    
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:11.0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.backgroundColor =[UIColor grayColor];
    [label setText:@"所有资讯与开奖活动与苹果公司(Apple Inc.)无关。"];
    //    [self.view addSubview:label];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ITBaoGaoViewCell *cell = [ITBaoGaoViewCell initWithtableView:tableView];
    if (dataArr.count) {
        cell.labelText.text = [dataArr[indexPath.row] objectForKey:@"title"];
        cell.labelTime.text = [dataArr[indexPath.row] objectForKey:@"strTime"];
        cell.labelStr.text = [dataArr[indexPath.row] objectForKey:@"description"];
        NSURL *url  = [NSURL URLWithString:[dataArr[indexPath.row] objectForKey:@"imageurl"]];
        [cell.imageView sd_setImageWithURL:url];
    }
    
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    return cell;
    
    //HomeTableViewCell.h
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    BaseDetailViewController *baseView = [[BaseDetailViewController alloc]init];
    [baseView addSubViewsWithhtmlDic:dataArr[indexPath.row]];
    [self.navigationController pushViewController:baseView animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark SDCycleScrollViewDelegate
- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup{
    _cycleScrollView.imageURLStringsGroup = [imageURLStringsGroup copy];
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
