//
//  ITTabBarController.m
//  inrtest
//
//  Created by 张涛 on 16/4/18.
//  Copyright © 2016年 张涛. All rights reserved.
//

#import "ITTabBarController.h"
#import "ITNavigationController.h"
#import "ITBaoGaoViewController.h"
#import "ITJiLuViewController.h"
#import "ITZhiShiViewController.h"
#import "ITSheDingViewController.h"
#import "ITNewsViewController.h"
#import <RDVTabBarItem.h>
#import <RDVTabBarController.h>
#import "Config.h"

#import "ITTeamInfoViewController.h"
#import "ITMatchViewController.h"
#import "RaceViewController.h"

@interface ITTabBarController ()

@end

@implementation ITTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildVCs];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAllChildVCs {
    
    
    //    }else if (button.tag == 4){
    //        ITTeamInfoViewController *vc = [[ITTeamInfoViewController alloc]init];
    //        [self.navigationController pushViewController:vc animated:YES];
    //    }else{
    //        ITMatchViewController *vc = [[ITMatchViewController alloc]init];
    //        [self.navigationController pushViewController:vc animated:YES];
    //    }
    ITBaoGaoViewController *vc1 = [[ITBaoGaoViewController alloc]init];
    [self addOneChildVC:vc1 imageName:@"首页" title:@"首页"];
    
    ITNewsViewController *vc2 = [[ITNewsViewController alloc]init];
    [self addOneChildVC:vc2 imageName:@"论坛" title:@"彩讯"];
    
    ITZhiShiViewController *vc3 = [[ITZhiShiViewController alloc]init];
    [self addOneChildVC:vc3 imageName:@"附近票点" title:@"附近票点"];
    
    RaceViewController *vc4 = [[RaceViewController alloc]init];
    [self addOneChildVC:vc4 imageName:@"我的" title:@"竞技场"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = Color(255, 86, 86, 1);
    self.tabBar.translucent = NO;
    
}

- (void)addOneChildVC: (UIViewController *)vc imageName:(NSString *)imageName title: (NSString *)title{
    
    ITNavigationController *nav = [[ITNavigationController alloc]initWithRootViewController:vc];
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.title = title;
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [self addChildViewController:nav];
    
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
