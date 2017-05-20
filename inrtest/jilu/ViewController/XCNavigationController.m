//
//  XCNavigationController.m
//  彩票2
//
//  Created by 1 on 16/1/20.
//  Copyright © 2016年 1. All rights reserved.
//

#import "XCNavigationController.h"

@interface XCNavigationController ()

@end

@implementation XCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置item中的控件颜色
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self.navigationBar setTitleTextAttributes:dict];
    
    self.view.backgroundColor =[UIColor redColor];
    
    

}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:YES];
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
