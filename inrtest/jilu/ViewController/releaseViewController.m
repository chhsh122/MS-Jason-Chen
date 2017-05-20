//
//  releaseViewController.m
//  inrtest
//
//  Created by HongShun Chen on 2017/4/25.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import "releaseViewController.h"



@interface releaseViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UITextView *content;

@end

@implementation releaseViewController{
    NSMutableArray *dataArr;
    NSString *titleStr;
    NSString *contentStr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发 布";
    [self createViews];
    // Do any additional setup after loading the view.
}



-(void)getDataWithphoneNumber:(NSString *)phoneNumber title:(NSString *)title content:(NSString *)content userName:(NSString *)userName{
    dataArr = [NSMutableArray array];
    //https://h1055.com/user/saveForum.htmls?phonenumber=15199451747&title=%25E4%25BD%25A0%25E5%25A5%25BD&content=wowowowowowwo
    NSString *url = [NSString stringWithFormat:@"https://h1055.com/ozsuser/saveForum.htmls?phonenumber=%@&title=%@&content=%@&username=%@",[[gobalConfig getInstance]phonenumber ],title,content,userName];
    [self.navigationController popViewControllerAnimated:YES];
    
    [[CPNetWorkRequest sharedClient] get:url parame:nil success:^(id object) {
        NSDictionary *dic = (NSDictionary *)object;
        if (object[@"errorcode"] == 0) {
            
            dataArr  = [dic objectForKey:@"result"];
            //success
            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [tableview reloadData];
                //                [self showHint:[dic objectForKey:@"error"]];
            });
        }else{
            //fail
            [SVProgressHUD showErrorWithStatus:@"error"];
            
        }
    } failure:^(NSError *err) {
        
    }];
    
//    [[HttpRequestClient sharedClient]getKaijiangNewsWithUrl:str request:^(int resultCode, NSString *resultMsg, NSArray *dataList, NSError *error) {
//        NSLog(@"%@",dataList);
//        NSDictionary *dic = (NSDictionary *)dataList;
//        if (resultCode ==0) {
//            
//            dataArr  = [dic objectForKey:@"result"];
//            //success
//            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //                [tableview reloadData];
//                //                [self showHint:[dic objectForKey:@"error"]];
//            });
//        }else{
//            //fail
//            [SVProgressHUD showWithStatus:@"error"];
//            
//        }
//    }];
}

- (void)createViews {
    
    UITextField *titleText = [[UITextField alloc]init];
    titleText.placeholder = @"标题";
    [titleText addTarget:self action:@selector(ListentitleChange) forControlEvents:UIControlEventEditingChanged];
    titleText.font = fontSize(scaleWithSize(23));
    [self.view addSubview:titleText];
    self.titleText = titleText;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = Color(200, 199, 204, 100);
    [self.view addSubview:line];
    
    UITextView *content = [[UITextView alloc]init];
    content.font = fontSize(scaleWithSize(18));
    content.delegate =self;
    [self.view addSubview:content];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.font = fontSize(scaleWithSize(18));
    placeHolderLabel.text = @"输入正文（必填）";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [content addSubview:placeHolderLabel];
    
    [content setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    [titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@68);
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width-32, 64));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.equalTo(titleText.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width-32, 1));
    }];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(line.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width-32, 200));
    }];
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    next.frame = CGRectMake(0, 0, 40, 18);
    [next setTitle:@"发布" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    //    [next setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    next.titleLabel.font = fontSize(scaleWithSize(16));
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:next];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, 0, 40, 18);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    //    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancel.titleLabel.font = fontSize(scaleWithSize(16));
    self.content = content;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancel];
}


//titleChange
-(void)ListentitleChange{
    titleStr =   _titleText.text;
}
- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"textViewDidChange：%@", textView.text);
    contentStr =  textView.text;
}
//取消
- (void)cancelClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextClick {
    
    [self getDataWithphoneNumber:nil title:titleStr content:contentStr userName:[[gobalConfig getInstance] userName]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
