//
//  CPArenaTableViewCell.m
//  彩票2
//
//  Created by 张涛 on 2017/4/15.
//  Copyright © 2017年 1. All rights reserved.
//

#import "CPArenaTableViewCell.h"

@interface CPArenaTableViewCell()

//@property (nonatomic, weak) UIImageView *pic;
//@property (nonatomic, weak) UILabel *title;
//@property (nonatomic, weak) UILabel *contentLab;
//@property (nonatomic, weak) UIView *lineBottom;
////@property (nonatomic, weak) UIButton *commentButton;
////@property (nonatomic, weak) UIButton *praiseButton;
//@property (nonatomic, weak) UILabel *authorLabel;
//@property (nonatomic, weak) UILabel *dateLabel;
////@property (nonatomic, weak) UILabel *enrollLab;

@end

@implementation CPArenaTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *cellID = @"CPArenaTableViewCell";
    CPArenaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CPArenaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *contentView = self.contentView;

        UIImageView *pic = [[UIImageView alloc] init];
        pic.contentMode = UIViewContentModeScaleToFill;
        pic.layer.masksToBounds = YES;
        pic.image = [UIImage imageNamed:@"morentouxiang"];
        pic.layer.cornerRadius = scaleWithSize(20);
        self.pic = pic;
        [contentView addSubview:pic];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"中奖啦中奖啦！！！！";
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = Color(73 , 73, 73, 1);
        title.font = fontSize(scaleWithSize(17.5));
        [contentView addSubview:title];
        self.title = title;
        
        UILabel *contentLab = [[UILabel alloc]init];
        contentLab.font = fontSize(scaleWithSize(17.5));
        contentLab.text = @"来自崇明的神秘陈先生中奖超1000万！";
        contentLab.textColor = Color(160, 160, 160, 1);
        contentLab.numberOfLines = 2;
        [contentView addSubview:contentLab];
        self.contentLab = contentLab;
        
        UIView *lineBottom = [[UIView alloc] init];
        lineBottom.backgroundColor = Color(200, 199, 204, 1);
        [contentView addSubview:lineBottom];
        self.lineBottom = lineBottom;
//
//        UIButton *commentButton = [self createAssistButton:@"cell-comment-icon"];
//        [contentView addSubview:commentButton];
//        self.commentButton = commentButton;
//        
//        UIButton *praiseButton = [self createAssistButton:@"home-praise-icon"];
//        [contentView addSubview:praiseButton];
//        self.praiseButton = praiseButton;
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.textColor = Color(160, 160, 160, 1);
        dateLabel.font = fontSize(scaleWithSize(15));
        dateLabel.text = @"2016年8月13日";
        [contentView addSubview:dateLabel];
        self.dateLabel = dateLabel;
        
        UILabel *authorLabel = [[UILabel alloc] init];
        authorLabel.textColor = Color(160, 160, 160, 1);
        authorLabel.font = fontSize(scaleWithSize(15));
        authorLabel.text = @"不作不死不舒服斯基";
        [contentView addSubview:authorLabel];
        self.authorLabel = authorLabel;
        
//        UILabel *enrollLab = [[UILabel alloc]init];
//        enrollLab.textColor = Color(160, 160, 160, 1);
//        enrollLab.font = fontSize(scaleWithSize(15));
//        [contentView addSubview:enrollLab];
//        self.enrollLab = enrollLab;
        
        [self layoutViewFrame];
    }
    
    return self;
}

- (void)layoutViewFrame{
    
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scaleWithSize(8));
        make.left.mas_equalTo(scaleWithSize(16));
        make.right.equalTo(self.contentView).offset(scaleWithSize(-16));
    }];
    
    [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scaleWithSize(22));
        make.top.equalTo(_title.mas_bottom).offset(scaleWithSize(12.5));
        make.size.mas_equalTo(CGSizeMake(scaleWithSize(40), scaleWithSize(40)));
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pic.mas_right).offset(scaleWithSize(13.5));
        make.top.mas_equalTo(_title.mas_bottom).offset(scaleWithSize(13));
        make.right.mas_equalTo(scaleWithSize(-16));
    }];
//    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_title.mas_bottom).offset(scaleWithSize(11));
//        make.left.equalTo(_pic.mas_right).offset(scaleWithSize(11));
//        make.right.equalTo(self.contentView).offset(scaleWithSize(-18));
//    }];
    
    //    CGFloat vWidth = (SCREEN_SIZE.width - 32) / 3;
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_pic.mas_left);
        make.top.equalTo(_pic.mas_bottom).offset(scaleWithSize(20));
        make.width.lessThanOrEqualTo(@150);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_contentLab.mas_right);
        make.top.mas_equalTo(_authorLabel.mas_top);
        make.width.lessThanOrEqualTo(@150);
    }];
//    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_descLabel.mas_right);
//        make.width.lessThanOrEqualTo(@(scaleWithSize(150)));
//        //        make.width.mas_equalTo(scaleWithSize(80));
//        make.top.equalTo(_dateLabel);
//    }];
//    
//    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_praiseButton.mas_left).offset(scaleWithSize(-18.5));
//        make.width.lessThanOrEqualTo(@(scaleWithSize(150)));
//        //        make.width.mas_equalTo(scaleWithSize(80));
//        make.top.equalTo(_dateLabel);
//    }];
//    
    [_lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_title.mas_left);
        make.right.equalTo(_title.mas_right);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.contentView);
    }];
    
//    [_enrollLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_descLabel.mas_right);
//        make.width.lessThanOrEqualTo(@150);
//        make.top.equalTo(_dateLabel);
//    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
