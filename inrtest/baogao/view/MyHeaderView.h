//
//  MyHeaderView.h
//  inrtest
//
//  Created by 宋辉 on 2017/4/22.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyHeaderViewDelegate <NSObject>

@optional
- (void)MyheadYYYButtonClick;

// 清空
-(void)RemoveNumber;

// 收藏
-(void)CollectionNumber;

-(void)ButtonClickTag:(NSInteger)tag;

@end
@interface MyHeaderView : UICollectionReusableView




//添加一个lable用于显示内容
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *textlabel2;
@property(nonatomic,strong)UIImageView *imageViews;
@property(nonatomic,strong)UIButton *button;

@property (nonatomic, weak) id<MyHeaderViewDelegate> delegate;


@end
