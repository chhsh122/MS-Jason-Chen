//
//  HomeCollectViewController.m
//  彩票2
//
//  Created by HongShun Chen on 2017/5/8.
//  Copyright © 2017年 1. All rights reserved.
//

#import "HomeCollectViewController.h"

#import "homeCollectionTableViewCell.h"
@interface HomeCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)NSArray *history;
@property(nonatomic,copy )NSMutableArray     *entityArr;
@end

@implementation HomeCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    [self addSubViews];
    self.view.backgroundColor =[UIColor whiteColor];

    [self  dictionaryToKaijiangEntity];
    // Do any additional setup after loading the view.
}

-(void)addSubViews{
    UITableView *tablview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    tablview.delegate =self;
    tablview.dataSource = self;
    [self.view addSubview:tablview];
}

-(void)dictionaryToKaijiangEntity{
    _entityArr = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *tmphistory = [[NSArray alloc] initWithContentsOfFile:[documentsDirectory stringByAppendingString:@"/history"]];
    self.history = [[tmphistory reverseObjectEnumerator] allObjects];
    
    for (int i= 0; i<_history.count; i++) {
        kaiJiangEntity *entity = [[kaiJiangEntity alloc]init];
        entity.numbers =_history[i];
        [_entityArr addObject:entity];
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.history.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    homeCollectionTableViewCell *cell = [homeCollectionTableViewCell initWithtableView:tableView Data:_entityArr[indexPath.row]];
//    MineDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell"];
//    cell.numbers = self.history[indexPath.row];
//    [cell configCell];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
