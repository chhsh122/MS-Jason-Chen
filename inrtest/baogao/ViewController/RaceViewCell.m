//
//  RaceViewCell.m
//  Lottery_first
//
//  Created by Guoguo on 2017/4/28.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import "RaceViewCell.h"

@implementation RaceViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat spacing = 8.0f;
        CGFloat border = 1.0f;
        
        UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 6)];
        viewBack.backgroundColor = [UIColor whiteColor];
//        viewBack.layer.shadowColor = [UIColor grayColor].CGColor;
//        viewBack.layer.shadowOpacity = 0.5;
//        viewBack.layer.shadowOffset = CGSizeMake(0, 3);
        [self.contentView addSubview:viewBack];
        
        _lblWeekNameTime = [[UILabel alloc] initWithFrame:CGRectMake(spacing, spacing, (viewBack.frame.size.width - 3 * spacing) / 2, (viewBack.frame.size.height - 2 * spacing - 2 * border) / 3)];
        _lblWeekNameTime.textColor = Guoguo_darkGreyFontColor;
        [_lblWeekNameTime setFont:[UIFont systemFontOfSize:14]];
        [viewBack addSubview:_lblWeekNameTime];
        
        UIView *viewComment = [[UIView alloc] initWithFrame:CGRectMake(_lblWeekNameTime.frame.origin.x + _lblWeekNameTime.frame.size.width + spacing + 8 * spacing, _lblWeekNameTime.frame.origin.y, _lblWeekNameTime.frame.size.width - 8 * spacing, _lblWeekNameTime.frame.size.height)];
        viewComment.backgroundColor = [UIColor clearColor];
        [viewBack addSubview:viewComment];
        
        _imgComment = [[UIImageView alloc] initWithFrame:CGRectMake(0, (viewComment.frame.size.height - 22) / 2, 22, 22)];
        [viewComment addSubview:_imgComment];
        
        _lblCommentNum = [[UILabel alloc] initWithFrame:CGRectMake(_imgComment.frame.origin.x + _imgComment.frame.size.width + spacing, 0, viewComment.frame.size.width - _imgComment.frame.origin.x - _imgComment.frame.size.width - spacing, viewComment.frame.size.height)];
        _lblCommentNum.textColor = Guoguo_darkGreyFontColor;
        [_lblCommentNum setFont:[UIFont systemFontOfSize:14]];
        [viewComment addSubview:_lblCommentNum];
        
        _lblTitleHome = [[UILabel alloc] initWithFrame:CGRectMake(spacing, _lblWeekNameTime.frame.origin.y + _lblWeekNameTime.frame.size.height + border, (viewBack.frame.size.width - 4 * spacing) / 3, _lblWeekNameTime.frame.size.height)];
//        _lblTitleHome.textColor = Guoguo_hintFontColor;
        [_lblTitleHome setFont:[UIFont boldSystemFontOfSize:16]];
        _lblTitleHome.textAlignment = NSTextAlignmentCenter;
        [viewBack addSubview:_lblTitleHome];
        
        _lblScore = [[UILabel alloc] initWithFrame:CGRectMake(_lblTitleHome.frame.origin.x + _lblTitleHome.frame.size.width + spacing, _lblTitleHome.frame.origin.y, _lblTitleHome.frame.size.width, _lblTitleHome.frame.size.height)];
        _lblScore.textColor = [UIColor orangeColor];
        _lblScore.textAlignment = NSTextAlignmentCenter;
        [_lblScore setFont:[UIFont boldSystemFontOfSize:16]];
        [viewBack addSubview:_lblScore];
        
        _lblTitleAway = [[UILabel alloc] initWithFrame:CGRectMake(_lblScore.frame.origin.x + _lblScore.frame.size.width + spacing, _lblTitleHome.frame.origin.y, _lblTitleHome.frame.size.width, _lblTitleHome.frame.size.height)];
//        _lblTitleAway.textColor = Guoguo_hintFontColor;
        [_lblTitleAway setFont:[UIFont boldSystemFontOfSize:16]];
        _lblTitleAway.textAlignment = NSTextAlignmentCenter;
        [viewBack addSubview:_lblTitleAway];
        
        _lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(_lblScore.frame.origin.x, _lblScore.frame.origin.y + _lblScore.frame.size.height + border, _lblScore.frame.size.width, _lblTitleHome.frame.size.height)];
        _lblStatus.textColor = [UIColor orangeColor];
        _lblStatus.textAlignment = NSTextAlignmentCenter;
        [_lblStatus setFont:[UIFont systemFontOfSize:14]];
        [viewBack addSubview:_lblStatus];
        
        _lblHalfScore = [[UILabel alloc] initWithFrame:CGRectMake(_lblTitleAway.frame.origin.x, _lblStatus.frame.origin.y, _lblScore.frame.size.width, _lblTitleHome.frame.size.height)];
        _lblHalfScore.textColor = Guoguo_darkGreyFontColor;
        _lblHalfScore.textAlignment = NSTextAlignmentCenter;
        [_lblHalfScore setFont:[UIFont systemFontOfSize:14]];
        [viewBack addSubview:_lblHalfScore];
        
        /*
         /设置阴影的颜色
         6     self.customView.layer.shadowColor=[UIColor blackColor].CGColor;
         7     //设置阴影的偏移量，如果为正数，则代表为往右边偏移
         8     self.customView.layer.shadowOffset=CGSizeMake(15, 5);
         9     //设置阴影的透明度(0~1之间，0表示完全透明)
         10     self.customView.layer.shadowOpacity=0.6;
         */
        
        UIView *viewSpacing = [[UIView alloc] initWithFrame:CGRectMake(0, viewBack.frame.origin.y + viewBack.frame.size.height, SCREEN_WIDTH, border)];
        [self.contentView addSubview:viewSpacing];
        viewSpacing.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
