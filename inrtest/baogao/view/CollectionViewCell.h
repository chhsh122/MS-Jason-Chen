//
//  CollectionViewCell.h
//  inrtest
//
//  Created by 宋辉 on 2017/4/22.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CollectionViewCellDelegate <NSObject>

@optional
//- (void)didItemClick:(CollectionViewCell *)cell Label:(UILabel *)label;

//- (void)didSelectItem: (NSInteger)index;

@end
@interface CollectionViewCell : UICollectionViewCell
@property(strong,nonatomic)UILabel *NubleLab;
@property (nonatomic, weak) id<CollectionViewCellDelegate> delegate;
@end
