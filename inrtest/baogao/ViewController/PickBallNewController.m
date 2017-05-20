//
//  PickBallNewController.m
//  inrtest
//
//  Created by 宋辉 on 2017/5/5.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import "PickBallNewController.h"
#import "CollectionViewCell.h"
#import "MyHeaderView.h"
//#import "PublicInFoViewController.h"
#import "Masonry.h"
#import "HomeCollectViewController.h"
/** 屏幕的宽度 */
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
/** 屏幕的高度 */
#define ScreenHeigth    [[UIScreen mainScreen] bounds].size.height



@interface PickBallNewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyHeaderViewDelegate>
{
    NSString *Newtitle;
    NSInteger Count_row;
    NSInteger Count_Random;
    NSInteger Count_section;
    NSString *Methods_Name;
    NSArray *section_array;
    
    
}
@property(nonatomic,strong)UICollectionView *CollectionView;
@property(nonatomic,strong)NSMutableArray *Source_Array;

@property(nonatomic,strong)NSMutableArray *Other_Array;

@property(nonatomic,strong)NSMutableDictionary *Source_Dict;

@property(nonatomic,strong)NSMutableArray *Key_Array;
@end

@implementation PickBallNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(242, 242, 242, 1);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //Color(237, 96, 91, 1);
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    [self CreateleftBarButtonItem];
    //    array = @[@"百  位",@"十  位",@"个  位"];
    //      [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
//       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [self CreateTopView];
    [self CreateSource];
    [self CreateBView];
}

-(void)ContrillerName:(NSString *)contrname
          MethodsName:(NSString *)methodsname
         SectionCount:(NSInteger)sectioncount
             RowCount:(NSInteger)rowcount
          RandomCount:(NSInteger)randomcount
     SectionNameArray:(NSArray *)array{
    
    Newtitle = contrname;
    self.title = Newtitle;
    Count_row = rowcount;
    Count_Random = randomcount;
    Count_section = sectioncount;
    Methods_Name = methodsname;
    section_array = array;
}




-(NSMutableDictionary *)Source_Dict{
    
    if (!_Source_Dict) {
        _Source_Dict = [NSMutableDictionary dictionary];
    }
    return _Source_Dict;
}

-(NSMutableArray *)Key_Array{
    
    if (!_Key_Array) {
        _Key_Array = [NSMutableArray array];
    }
    return _Key_Array;
    
}

//
/**
 下方按钮
 */
-(void)CreateBView{
    
    UIView *BView = [[UIView alloc]init];
    BView.backgroundColor = Color(242, 242, 242, 1);
    [self.view addSubview:BView];
    
    
    // 清空 按钮 FootHHClean
    UIButton *RemoveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [RemoveBtn addTarget:self action:@selector(NesRemoveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    RemoveBtn.backgroundColor = Color(237, 96, 91, 1);
    [RemoveBtn setTitle:@"清空" forState:0];
    RemoveBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [RemoveBtn setTitleColor:[UIColor whiteColor] forState:0];
    RemoveBtn.clipsToBounds = YES;
    
    RemoveBtn.layer.cornerRadius = 5;
//    [RemoveBtn addTarget:self action:@selector(NesRemoveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [BView addSubview:RemoveBtn];
    //    // 走势按钮
    UIButton *CollectionBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [CollectionBtn addTarget:self action:@selector(NesCollectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    CollectionBtn.backgroundColor = Color(237, 96, 91, 1);
    [CollectionBtn setTitle:@"收藏" forState:0];
    [CollectionBtn setTitleColor:[UIColor whiteColor] forState:0];
    CollectionBtn.clipsToBounds = YES;
    
    CollectionBtn.layer.cornerRadius = 5;
    
    [BView addSubview:CollectionBtn];
    
    [BView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@(50 * Heigt_P));
    }];
    
    
    [RemoveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BView).offset(10 * Width_P);
        make.centerY.equalTo(BView);
        make.size.mas_equalTo(CGSizeMake(88 * Width_P, 35 * Heigt_P));
        // 24    21 45
        // 41 65
    }];
    //
    // 120 44
    [CollectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BView).offset( -100 * Width_P );
        make.centerY.equalTo(RemoveBtn);
        make.size.mas_equalTo(CGSizeMake(88 * Width_P, 35 * Heigt_P));
    }];
    
}
// 清空
-(void)NesRemoveButtonClick:(UIButton *)sender{
    
    [self.Source_Dict removeAllObjects];
    [self.CollectionView reloadData];
    
}
// 收藏
-(void)NesCollectionButtonClick:(UIButton *)sender{
//
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSArray *history = [[NSArray alloc] initWithContentsOfFile:[documentsDirectory stringByAppendingString:@"/history"]];
        if (history==nil) {
            history = [NSArray array];
        }
    if ([self.Source_Dict objectForKey:@"0"]!=nil) {
        
        history = [history arrayByAddingObject:[self.Source_Dict objectForKey:@"0"]];
    }
    
//    if ([self.Source_Dict objectForKey:@"1"] != nil) {
//        
//    }

//        NSArray *A = [self.Source_Dict objectForKey:@"0"];
//        history = [history arrayByAddingObject:[self.Source_Dict objectForKey:@"0"]];
//        
        [history writeToFile:[documentsDirectory stringByAppendingString:@"/history"] atomically:YES];
    HomeCollectViewController *vc = [[HomeCollectViewController alloc]init];
    [self.navigationController pushViewController:vc  animated:YES];
    //    PublicInFoViewController *Vc = [[PublicInFoViewController alloc]init];
    
    
    
}
// 创建数据
-(void)CreateSource{
    
    _Source_Array = [NSMutableArray arrayWithCapacity:Count_row];
    for (int i = 0; i < Count_row; i ++) {
        
        [_Source_Array addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
    
    NSLog(@"生成的每个区itme数字 = %@",_Source_Array);
}


// 摇一摇
-(void)RandomNumber{
    //每次随机  清空Key数组
    [self.Key_Array removeAllObjects];
    
    // 几个区 就循环几次
    for (int i = 0; i < Count_section; i ++ ) {
        [self.Key_Array addObject:[NSString stringWithFormat:@"%d",i]];
        // 随机出每个区的随机数
        NSMutableArray  *array_0 = [_Source_Array mutableCopy];
        NSMutableArray *arr = [NSMutableArray array];
        for (int j = 0; j < Count_Random; j ++ ) {
            
            int index = arc4random()%array_0.count;
            //            NSLog(@"每个区的随机数下标 = %d",index);
            
            int n = [array_0[index] intValue];
            // 根据下标找到 数组中对应的元素  添加
            [arr addObject:[NSString stringWithFormat:@"%d",n]];
            [array_0 removeObjectAtIndex:index];
            // 按区 将数组加入字典中
            [self.Source_Dict setObject:arr forKey:[NSString stringWithFormat:@"%d",i]];
            
            
        }
        
        
    }
    NSLog(@"Key = %@",_Key_Array);
    NSLog(@"字典 = %@",_Source_Dict);
    
    
    [_CollectionView reloadData];
    
    
}

-(NSMutableArray *)Other_Array{
    if (!_Other_Array) {
        _Other_Array = [NSMutableArray array];
    }
    return _Other_Array;
    
    
    
}
//-(NSMutableArray *)Random_Array{
//
//    if (!_Random_Array) {
//        _Random_Array = [NSMutableArray array];
//    }
//    return _Random_Array;
//}

-(void)CreateTopView{
    
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 31 * Heigt_P)];
    BGView.backgroundColor = Color(242, 242, 242, 1);
    [self.view addSubview:BGView];
    
    //    标题
    UILabel * textlabel = [[UILabel alloc] init];
    textlabel.frame = CGRectMake(0, 0, ScreenWidth, 30 * Heigt_P);
    //    textlabel.text = @"玩法: 三星直选";
    textlabel.text = Methods_Name;
    textlabel .textColor = [UIColor grayColor];
    //    textlabel.backgroundColor = [UIColor cyanColor];
    textlabel .font = [UIFont systemFontOfSize:15 * Width_P];
    textlabel.textAlignment = 1;
    [BGView addSubview:textlabel];
    
    //线
    UIView *line = [[UIView alloc]init];
    line.frame = CGRectMake(0, CGRectGetMaxY(textlabel.frame), ScreenWidth, 1 * Heigt_P);
    line.backgroundColor = Color(200, 199, 204, 1);
    [BGView addSubview:line];
    
    
    
    // 球号
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    self.CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(BGView.frame), ScreenWidth, ScreenHeigth - 150) collectionViewLayout:layOut];
    _CollectionView.allowsMultipleSelection = YES;
    self.CollectionView.backgroundColor = Color(242, 242, 242, 1);
    //    self.CollectionView.scrollEnabled = NO;
    [self.CollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"coll_cell"];
    
    [self.CollectionView registerClass:[MyHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    [self.view addSubview:self.CollectionView];
    
}


#pragma mark 返回多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _Source_Array.count;
    
    
    
}

// 返回的区数
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return Count_section;
}

#pragma mark 返回item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coll_cell" forIndexPath:indexPath];
    cell.NubleLab.text = _Source_Array[indexPath.row];
    cell.NubleLab.backgroundColor = [UIColor whiteColor];
    cell.NubleLab.textColor = [UIColor blackColor];
    
    NSString *key = _Key_Array[indexPath.section];
    NSArray *array = _Source_Dict[key];
    
    NSString *str = [NSString stringWithFormat:@"%lu",indexPath.row];
    if ([array containsObject:str]) {
        cell.NubleLab.backgroundColor = [UIColor redColor];
        cell.NubleLab.textColor = [UIColor whiteColor];
        
    }else{
        cell.NubleLab.backgroundColor = [UIColor whiteColor];
        cell.NubleLab.textColor = [UIColor blackColor];
    }
    
    return cell;
    
    
}





//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.CollectionView cellForItemAtIndexPath:indexPath];
    CollectionViewCell *item = (CollectionViewCell *)cell;
    
    if ([item.NubleLab.backgroundColor isEqual:[UIColor redColor]]) {  // 已选中
        item.NubleLab.backgroundColor = [UIColor whiteColor];
        item.NubleLab.textColor = [UIColor blackColor];
        
    }else{
        
        
        item.NubleLab.backgroundColor = [UIColor redColor];
        item.NubleLab.textColor = [UIColor whiteColor];
    }
    
    
    
}



//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"这个是取消选择状态");
    
    UICollectionViewCell *cell = [self.CollectionView cellForItemAtIndexPath:indexPath];
    CollectionViewCell *item = (CollectionViewCell *)cell;
    
    if ([item.NubleLab.backgroundColor isEqual:[UIColor whiteColor]]) {
        item.NubleLab.backgroundColor = [UIColor redColor];
        item.NubleLab.textColor = [UIColor whiteColor];
    }else{
        item.NubleLab.backgroundColor = [UIColor whiteColor];
        item.NubleLab.textColor = [UIColor blackColor];
    }
    
    
    
}


// 摇一摇
-(void)MyheadYYYButtonClick{
    
    [self RandomNumber];
    
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView = nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        
        MyHeaderView *headerV = (MyHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        //@"请至少选择 1 个蓝球"
        headerV.delegate = self;
        headerV.button.hidden = NO;
        if (indexPath.section != 0) {
            headerV.button.hidden = YES;
        }
        
        headerV.textlabel2.text = section_array[indexPath.section];
        reusableView = headerV;
        
    }
    
    
    return reusableView;
    
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={ScreenWidth,30 * Heigt_P};
    //    if (section == 0) {
    //        CGSize size={0,0};
    //        return size;
    //    }
    return size;
}

//定义每个UICollectionView 的大小

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return CGSizeMake (Width_P * 35  , Heigt_P * 35);
    
}





//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5 * Heigt_P, 15 * Heigt_P, 5 * Heigt_P, 15 * Heigt_P);//分别为上、左、下、右
}



-(void)CreateleftBarButtonItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(-10,0,50,50);
    [button addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = navLeftButton;
}
// 左上角按钮点击事件
-(void)backEvent{
    [self.navigationController popViewControllerAnimated:YES];
    
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
