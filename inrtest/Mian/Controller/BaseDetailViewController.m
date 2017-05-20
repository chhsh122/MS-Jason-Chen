//
//  BaseDetailViewController.m
//  Domino
//
//  Created by HongShun Chen on 2017/3/24.
//  Copyright © 2017年 jack.wang. All rights reserved.
//

#import "UIImageView+AFNetworking.h"

#import "BaseDetailViewController.h"

@interface BaseDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, assign) NSInteger lottoryId;

@end

@implementation BaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"资讯详情";
    
    _isFav = NO;
    
//    [self createRightBtn];
    
    self.navigationController.navigationBarHidden = NO;
    
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
//    [self.navigationController.navigationBar setBarTintColor:[Utils colorFromHexRGB:@"d91d36"]];
//    [self.navigationController.navigationBar setBarTintColor:K_NAVBAR_COLOR];
    
    self.view.backgroundColor =RGB(242, 242, 242);
    // Do any additional setup after loading the view.
}

- (void)createRightBtn {
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(0, 0, scaleWithSize(41),scaleWithSize(41));
    [collectBtn setImage:[UIImage imageNamed:@"collect_normal"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:collectBtn];
    self.collectBtn = collectBtn;
}

- (void)judgeIsFav {
    NSString *phoneNum = [[gobalConfig getInstance] phonenumber];
    if ([phoneNum isEqualToString:@""] || phoneNum == nil) {
        
    }else{
        NSString *url = @"https://www.h1055.com/ozsuser/isCollect.htmlsuser/isCollect.htmls";
        NSDictionary *parame = @{
                                 @"phonenumber": phoneNum,
                                 @"lottoryId": @(_lottoryId)
                                 };
        [[CPNetWorkRequest sharedClient]get:url parame:parame success:^(id object) {
            if (![[object objectForKey:@"errorcode"]  isEqualToString:@"0"]) {
                NSString *errStr = [object objectForKey:@"error"];
                [SVProgressHUD showErrorWithStatus:errStr];
                
            }else{
                NSNumber *isFav = [object objectForKey:@"result"];
                _isFav = [isFav intValue];
                if (_isFav == 0) {
                    _isFav = NO;
                }else{
                    _isFav = YES;
                }
                if (_isFav) {
                    [self.collectBtn setImage:[UIImage imageNamed:@"collect_selected"] forState:UIControlStateNormal];
                }else{
                    [self.collectBtn setImage:[UIImage imageNamed:@"collect_normal"] forState:UIControlStateNormal];
                }
                
            }

        } failure:^(NSError *err) {
            
        }];
        
    }

}

- (void)collectClick {
    
    NSString *phoneNum = [[gobalConfig getInstance] phonenumber];
    if ([phoneNum isEqualToString:@""] || phoneNum == nil) {
        [SVProgressHUD showErrorWithStatus:@"请先登录！"];
    }else{
        _isFav = !_isFav;
        if (!_isFav) {
            [self.collectBtn setImage:[UIImage imageNamed:@"collect_normal"] forState:UIControlStateNormal];
            NSString *url = @"https://www.h1055.com/ozsuser/saveCollection.htmls";
            NSDictionary *parame = @{
                                     @"phonenumber": phoneNum,
                                     @"lottoryId": @(_lottoryId)
                                     };
            [[CPNetWorkRequest sharedClient]get:url parame:parame success:^(id object) {
                if (![[object objectForKey:@"errorcode"]  isEqualToString:@"0"]) {
                    NSString *errStr = [object objectForKey:@"error"];
                    [SVProgressHUD showErrorWithStatus:errStr];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                }
            } failure:^(NSError *err) {
                
            }];
            
        }else{
            [self.collectBtn setImage:[UIImage imageNamed:@"collect_selected"] forState:UIControlStateNormal];
            NSString *url = @"https://www.h1055.com/ozsuser/deleteCollection.htmls";
            NSDictionary *parame = @{
                                     @"phonenumber": phoneNum,
                                     @"lottoryId": @(_lottoryId)
                                     };
            [[CPNetWorkRequest sharedClient]get:url parame:parame success:^(id object) {
                if (![[object objectForKey:@"errorcode"]  isEqualToString:@"0"]) {
                    NSString *errStr = [object objectForKey:@"error"];
                    [SVProgressHUD showErrorWithStatus:errStr];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                    
                }
            } failure:^(NSError *err) {
                
            }];
        }
    }

}

-(void)addSubViewsWithhtmlDic:(NSDictionary *)htmlDic{

 //文章
    UILabel *label = [[UILabel alloc]init];
    NSString *description =[NSString stringWithFormat:@"%@",[htmlDic objectForKey:@"description"]];
    label.text = description;
    label.numberOfLines = 0;

    UIFont *font = [UIFont systemFontOfSize:13];
    label.font = font;
    [label setNumberOfLines:0];
    label.lineBreakMode = UILineBreakModeWordWrap;
//    label.backgroundColor = [UIColor greenColor];
    label.tag = 102;
    CGSize size = CGSizeMake(kWidth,2000);
    CGSize labelsize = [description sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];

//scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.contentSize = CGSizeMake(kWidth,  kHeight/6+kHeight/4+labelsize.height+100);
//    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator = NO;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.view.frame.size.height);
        make.width.mas_equalTo(self.view.frame.size.width);
    }];

    
    
    
    NSString *lottoryId = [htmlDic objectForKey:@"id"];
    _lottoryId = [lottoryId integerValue];
    
    UIView *headerView=  [[UIView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight/6)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    
    //text
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, kWidth-40, kHeight/9)];
    titleLabel.numberOfLines = 2;
    titleLabel.text = [NSString stringWithFormat:@"%@",[htmlDic objectForKey:@"title"]];
    [headerView addSubview:titleLabel];
    
    //time
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, K_RECT_MAXY(titleLabel), kWidth-40, 15)];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font =[UIFont systemFontOfSize:11.0];
    timeLabel.text = [NSString stringWithFormat:@"%@",[htmlDic objectForKey:@"strTime"]];
    [headerView addSubview:timeLabel];
    
    
    
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, K_RECT_MAXY(headerView), K_FRAME_BASE_WIDTH, 1)];
    [grayLine setBackgroundColor:[UIColor lightGrayColor]];
    [grayLine setAlpha:0.2f];
    [grayLine.layer setShadowOffset:CGSizeMake(0, 1.0)];
    [grayLine.layer setShadowRadius:0.5];
    [scrollView addSubview:grayLine];
    

    label.frame = CGRectMake(10, K_RECT_MAXY(headerView)+10, kWidth-20, labelsize.height);
    [scrollView addSubview:label];




    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, K_RECT_MAXY(label)+10, kWidth-20, kHeight/4)];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[htmlDic objectForKey:@"imageurl"]]];
    [imageView setImageWithURL:url];
    [scrollView addSubview:imageView];
    
    
    [scrollView  addSubview:headerView];

    
}

- (void)viewWillAppear:(BOOL)animated{
    [self judgeIsFav];
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
