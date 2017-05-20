//
//  CPInfoHeaderView.m
//  彩票2
//
//  Created by 张涛 on 2017/4/14.
//  Copyright © 2017年 1. All rights reserved.
//

#import "CPInfoHeaderView.h"

@interface CPInfoHeaderView()
    
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nameLab;

@end

@implementation CPInfoHeaderView

    
- (instancetype)initWithFrame:(CGRect)frame
    {
        self = [super initWithFrame:frame];
        if (self) {
            
        }
        return self;
    }
    
- (instancetype)initWithHeader:(CGRect)frame{
    if (self = [super init]) {
        
        self.frame = frame;
        
        UIView *bgView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:bgView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.image = [UIImage imageNamed:@"my-view-header"];
        [bgView addSubview:imageView];
        self.imageView = imageView;
        
        UIImageView *headImg = [[UIImageView alloc]init];
        headImg.image = [UIImage imageNamed:@"morentouxiang"];
        headImg.contentMode = UIViewContentModeScaleAspectFill;
        headImg.layer.cornerRadius = scaleWithSize(40);
        headImg.layer.masksToBounds = YES;
        self.headImg = headImg;
        [imageView addSubview:headImg];
        
        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.font = fontSize(20);
        nameLab.textColor = [UIColor whiteColor];
        if ([[gobalConfig getInstance]IsLogin]) {
            NSLog(@"%@++++",[[gobalConfig getInstance]userName]);
            nameLab.text=[[gobalConfig getInstance]userName];
        }else{
            
            nameLab.text = @"点击登录";
        }
        [imageView addSubview:nameLab];
        self.nameLab = nameLab;
        [self layoutView];
        
    }
    return self;
}
    
- (void)layoutView{

    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(scaleWithSize(16));
        make.centerX.mas_equalTo(self.imageView.mas_centerX);
        make.centerY.mas_equalTo(self.imageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(scaleWithSize(80), scaleWithSize(80)));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.headImg.mas_right).offset(scaleWithSize(10));
        make.centerX.mas_equalTo(self.imageView.mas_centerX);
//        make.centerY.mas_equalTo(self.headImg.mas_centerY);
        make.top.mas_equalTo(self.headImg.mas_bottom).offset(scaleWithSize(10));
        make.width.mas_lessThanOrEqualTo(150);
    }];

}
    
- (void) setUserName:(NSString *)userName{
    _userName = userName;
    
    self.nameLab.text = userName;
}
    
//- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset{
//    [self.bgHeaderView layoutHeaderViewForScrollViewOffset:offset];
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
