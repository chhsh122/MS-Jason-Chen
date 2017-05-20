//
//  CollectionViewCell.m
//  inrtest
//
//  Created by 宋辉 on 2017/4/22.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self CreateView];
    }
    
    return self;
}

-(void)CreateView{
    
    _NubleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _NubleLab.backgroundColor = [UIColor whiteColor];
    _NubleLab.layer.cornerRadius = _NubleLab.bounds.size.width/2;
    _NubleLab.layer.masksToBounds = YES;
    _NubleLab.textAlignment = 1;
    
    _NubleLab.layer.borderColor = [UIColor redColor].CGColor;
    _NubleLab.layer.borderWidth = 1;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
    [_NubleLab addGestureRecognizer:labelTapGestureRecognizer];
    
    [self.contentView addSubview:_NubleLab];
    
    //
 
    
}


-(void)labelClick:(UITapGestureRecognizer *)sender{
    
    UILabel *label = (UILabel *)sender.view;
    NSLog(@"号码 = %@",label.text);
 
//    if ([self.delegate respondsToSelector:@selector(didButtonItemClick:)]) {
//        [self.delegate didButtonItemClick:button];
//    }
    
    
    
}



-(void)ChangeLabel:(UILabel *)label{
    label.backgroundColor = [UIColor redColor];
//    label
    
    
    
    
}

@end
