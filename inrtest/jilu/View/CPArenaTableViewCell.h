//
//  CPArenaTableViewCell.h
//  彩票2
//
//  Created by 张涛 on 2017/4/15.
//  Copyright © 2017年 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPArenaTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIView *lineBottom;
//@property (nonatomic, weak) UIButton *commentButton;
//@property (nonatomic, weak) UIButton *praiseButton;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *dateLabel;
//@property (nonatomic, weak) UILabel *enrollLab;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
