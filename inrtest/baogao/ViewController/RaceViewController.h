//
//  RaceViewController.h
//  Lottery_first
//
//  Created by Guoguo on 2017/4/28.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaceViewCell.h"
#import "RaceDetailViewController.h"
@interface RaceViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) UITableView *tabView;
@property (nonatomic, copy) NSMutableArray *dataSourceArr;

@end
