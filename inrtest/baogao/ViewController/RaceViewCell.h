//
//  RaceViewCell.h
//  Lottery_first
//
//  Created by Guoguo on 2017/4/28.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaceViewCell : UITableViewCell
@property (nonatomic, copy) UIImageView *imgComment;
@property (nonatomic, strong) UILabel *lblWeekNameTime;
@property (nonatomic, strong) UILabel *lblCommentNum;
@property (nonatomic, strong) UILabel *lblTitleHome;
@property (nonatomic, strong) UILabel *lblTitleAway;
@property (nonatomic, strong) UILabel *lblScore;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) UILabel *lblHalfScore;

@end
