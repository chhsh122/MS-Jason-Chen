//
//  ITCaiZhongViewController.m
//  inrtest
//
//  Created by 张涛 on 2017/4/25.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import "ITCaiZhongViewController.h"
#import "kaiJiangEntity.h"
#import "MineDetailTableViewCell.h"

@interface ITCaiZhongViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ITCaiZhongViewController{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *caiPiaoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
    // Do any additional setup after loading the view.
}

-(void)getMoreData{
    caiPiaoArr= [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    NSString *url = @"";
    switch (_type) {
        case 0:
            url = @"https://www.h1055.com/interface/queryLottoryRecord.htmls?param=3d";
            break;
        case 1:
            url = @"https://www.h1055.com/interface/queryLottoryRecord.htmls?param=ssq";
            break;
        case 2:
            url = @"https://www.h1055.com/interface/queryLottoryRecord.htmls?param=qlc";
            break;
        case 3:
            url = @"https://www.h1055.com/interface/queryLottoryRecord.htmls?param=dlt";
            break;
        case 4:
            url = @"https://www.h1055.com/interface/queryLottoryRecord.htmls?param=3ds";
            break;
        case 5:
            url = @"https://www.h1055.com/interface/queryLottoryRecord.htmls?param=pls";
            break;
        case 6:
            url = @"https://www.h1055.com/interface/queryLottoryRecord.htmls?param=plw";
            break;
            
        default:
            break;
    }
    //http://api.kaijiangtong.com/lottery/?name=sd&format=json&uid=743362&token=70ece3eedfe88729358657bcc5048f62638f8b0e
    [[CPNetWorkRequest sharedClient]get:url parame:nil success:^(id object) {
        if ([object[@"errorcode"] isEqualToString:@"0"]) {
            [_tableView.mj_header endRefreshing];
            NSDictionary *dic = (NSDictionary *)object;
            NSArray *dicArr= [dic objectForKey:@"result"];
            
            for (int i =0; i< dicArr.count; i++) {
                kaiJiangEntity *kaijiang = [[kaiJiangEntity alloc]initWithDict:dicArr[i]];
                
                [caiPiaoArr addObject:kaijiang];
                
            }
            [_tableView reloadData];
            
        }else{
            
            [_tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *err) {
        
    }];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.rowHeight = scaleWithSize(90);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight ;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    _tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header beginRefreshing];
    
    [self.view addSubview:_tableView];
    
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return caiPiaoArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineDetailTableViewCell *cell = [MineDetailTableViewCell initWithtableView:tableView Data:caiPiaoArr[indexPath.row]];
    kaiJiangEntity *kaijiang = [[kaiJiangEntity alloc]init];
    kaijiang = caiPiaoArr[indexPath.row];
    //    cell.titleName.text= @"大乐透";
    switch (_type) {
        case 0:
            cell.titleName.text = @"3D球";
            break;
        case 1:
            cell.titleName.text = @"双色球";
            break;
        case 2:
            cell.titleName.text = @"七彩乐";
            break;
        case 3:
            cell.titleName.text = @"大乐透";
            break;
        case 4:
            cell.titleName.text = @"3D试机号";
            break;
        case 5:
            cell.titleName.text = @"排列三";
            break;
        case 6:
            cell.titleName.text = @"排列五";
            break;
            
        default:
            break;
    }
    cell.labelStr.text= [NSString stringWithFormat:@"%@期",kaijiang.qiShuNo] ;
    cell.labelText.text= kaijiang.dataline;
    
    //    cell.videoModel = _dataArray[indexPath.item];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
    
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
