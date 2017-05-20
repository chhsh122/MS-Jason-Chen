//
//  MyHeaderView.m
//  inrtest
//
//  Created by 宋辉 on 2017/4/22.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import "MyHeaderView.h"

@implementation MyHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor cyanColor];
        [self CreateView];
    }
    return self;
}

-(void)CreateView{
    
    _imageViews = [[UIImageView alloc]init];
    _imageViews.image = [UIImage imageNamed:@"NOEELotteryRightArrow"];
    _imageViews.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self addSubview:_imageViews];
    
    // 文字
    _textlabel2 = [[UILabel alloc] init];
    
    _textlabel2 .textColor = [UIColor blackColor];
//        textlabel.backgroundColor = [UIColor cyanColor];
    _textlabel2 .font = [UIFont systemFontOfSize:14 * Width_P];
    _textlabel2.textAlignment = 1;
    [self addSubview:_textlabel2];

    
    // 摇一摇图片
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setImage:[UIImage imageNamed:@"BetShake"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(headYYYbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];

    
    
    [_imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10 * Width_P);
        make.size.mas_equalTo(CGSizeMake(10 * Width_P, 16 * Heigt_P));
        
        
    }];
    [_textlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imageViews);
        make.left.equalTo(_imageViews.mas_right).offset(8 * Width_P);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imageViews);
        make.right.equalTo(self).offset( - 5 * Width_P);
    }];
    
    
//    _titleLab = [[UILabel alloc]init];
//    _titleLab.frame =CGRectMake(0,0, self.frame.size.width,self.frame.size.height);
//    _titleLab.textAlignment =NSTextAlignmentCenter;
//    _titleLab.backgroundColor = [UIColor redColor];
//    [self addSubview:_titleLab];
    
}

-(void)headYYYbuttonClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(MyheadYYYButtonClick)]) {
        [self.delegate MyheadYYYButtonClick];
    }
    
    
    
}





@end
