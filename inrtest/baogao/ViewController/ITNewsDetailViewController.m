//
//  ITNewsDetailViewController.m
//  inrtest
//
//  Created by 张涛 on 2017/4/25.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import "ITNewsDetailViewController.h"

@interface ITNewsDetailViewController ()

@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, assign) NSInteger lottoryId;

@end

@implementation ITNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯详情";
    // Do any additional setup after loading the view.
}

-(void)addSubViewsWithhtmlDic:(NSDictionary *)htmlDic{
    //    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //    webView.delegate = self;
    ////    NSString *htmlString = htmlStr.Remark;//这是html格式的代码段
    ////    [webView loadHTMLString:htmlStr baseURL:nil];
    //    [self.view addSubview:webView];
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
    
    //    headerView.backgroundColor = [UIColor redColor];
    
    
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, K_RECT_MAXY(headerView), K_FRAME_BASE_WIDTH, 1)];
    [grayLine setBackgroundColor:[UIColor lightGrayColor]];
    [grayLine setAlpha:0.2f];
    [grayLine.layer setShadowOffset:CGSizeMake(0, 1.0)];
    [grayLine.layer setShadowRadius:0.5];
    [self.view addSubview:grayLine];
    
    
    
    //description
    NSString *description =[NSString stringWithFormat:@"%@",[htmlDic objectForKey:@"description"]];
    
    UILabel *descriptionLabel  = [[UILabel alloc]initWithFrame:CGRectMake(10,K_RECT_MAXY(grayLine)+10, kWidth-20, 30*(description.length/20))];
    descriptionLabel.font = [UIFont systemFontOfSize:12.0];
    descriptionLabel.text =description;
    descriptionLabel.textAlignment = NSTextAlignmentLeft;
    descriptionLabel.numberOfLines = 20;
    [self.view addSubview:descriptionLabel];
    
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, K_RECT_MAXY(descriptionLabel)+10, kWidth-20, kHeight/4)];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[htmlDic objectForKey:@"imageurl"]]];
    [imageView setImageWithURL:url];
    [self.view addSubview:imageView];
    
    
    [self.view  addSubview:headerView];
    
    
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
