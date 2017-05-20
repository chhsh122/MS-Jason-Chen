//
//  homeCollectionTableViewCell.h
//  彩票2
//
//  Created by HongShun Chen on 2017/5/8.
//  Copyright © 2017年 1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "kaiJiangEntity.h"

@interface homeCollectionTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleName;
@property(nonatomic,strong)UILabel *labelTime;
+(instancetype)initWithtableView:(UITableView *)tableView Data:(kaiJiangEntity *)Entity;
@end
