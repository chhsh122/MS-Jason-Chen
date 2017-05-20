//
//  PickBallNewController.h
//  inrtest
//
//  Created by 宋辉 on 2017/5/5.
//  Copyright © 2017年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickBallNewController : UIViewController



@property(nonatomic,assign)NSInteger FLag;





/**
 参数说明
 
 @param contrname 控制器名称          如: 3D球
 @param methodsname 玩法名称          如: @"玩法: 任选七个号";
 @param sectioncount 区数            如 3D球 有 百位 十位 个位  则需要 3个区
 @param rowcount 每个区的itme数量      如: 3D球有9个号码  则 每个区有9个itme
 @param randomcount 每个区 随机的个数  如: 3D球 每个区 需要随机 1个球 则  randomcount = 1;
 @param array 每个区的名称            如: 十位 百位  个位  千位  . .. . . . .
 */
-(void)ContrillerName:(NSString *)contrname
          MethodsName:(NSString *)methodsname
         SectionCount:(NSInteger)sectioncount
             RowCount:(NSInteger)rowcount
          RandomCount:(NSInteger)randomcount
     SectionNameArray:(NSArray *)array;




@end
