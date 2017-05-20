//
//  homeCollectionTableViewCell.m
//  彩票2
//
//  Created by HongShun Chen on 2017/5/8.
//  Copyright © 2017年 1. All rights reserved.
//

#import "homeCollectionTableViewCell.h"



@implementation homeCollectionTableViewCell
@synthesize titleName;
@synthesize labelTime;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(instancetype)initWithtableView:(UITableView *)tableView Data:(kaiJiangEntity *)Entity{
    
    homeCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCollectCell"];
    
    if (cell == nil) {
        cell = [[homeCollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCell"Data:Entity];
    }
    return cell;
    
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(kaiJiangEntity *)Entity{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        self.font = [UIFont systemFontOfSize:13];
        
        
        //        UIImageView *imageView=  [[UIImageView  alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.height+30, 55)];
        //        imageView.image = [UIImage imageNamed:@"homeicon"];
        //        [self addSubview:imageView];
        //spr 彩票种类
        titleName = [[UILabel alloc]initWithFrame:CGRectMake(5,3, 60, 30)];
        //        titleName = [[UILabel alloc]init];
        //        titleStr = @"大乐透";
        
        //        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        //        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        //        CGSize size =  [titleStr boundingRectWithSize:CGSizeMake( MAXFLOAT,titleName.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        //        titleName.frame = CGRectMake(5, 0, size.width, 100);
        self.selectionStyle= UITableViewCellSelectionStyleNone;
        
        titleName.textAlignment= NSTextAlignmentLeft;
        titleName.font = [UIFont fontWithName:@"Arial Rounded MT Bold"  size:(17.0)];
        //        labelStr.numberOfLines = 2;
        [titleName setTextColor:[UIColor blackColor]];
        //        titleName.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleName];
        
        
        
//        //labelStr 期数
//        
//        labelStr = [[UILabel alloc]initWithFrame:CGRectMake(K_RECT_MAXX(titleName)+10, 5, self.frame.size.height+50, 25)];
//        labelStr.textAlignment= NSTextAlignmentLeft;
//        //                labelStr.text = @"中国鼓励彩票福利彩票中国鼓励彩票福利彩票中国鼓励彩票福利彩票中国鼓励彩票";
//        //        labelStr.numberOfLines = 2;
//        [labelStr setTextColor:[UIColor lightGrayColor]];
//        labelStr.font = [UIFont systemFontOfSize:11];
//        [self addSubview:labelStr];
//        
//        //title时间
//        labelText = [[UILabel alloc]initWithFrame:CGRectMake(K_RECT_MAXX(labelStr), 5, K_FRAME_BASE_WIDTH/10*5, 25)];
//        labelText.font = [UIFont systemFontOfSize:11];
//        [labelText setTextColor:[UIColor lightGrayColor]];
//        
//        [self  addSubview:labelText];
        
        
        //time
        
        //        labelTime = [[UILabel alloc]initWithFrame:CGRectMake(K_FRAME_BASE_WIDTH-140, K_RECT_MAXY(labelStr), 130, 10)];
        //        labelTime.textAlignment= NSTextAlignmentRight;
        //        //        labelTime.text = @"8:00";
        //        [labelTime setTextColor:[UIColor grayColor]];
        //        labelTime.font = [UIFont systemFontOfSize:11];
        //        [self addSubview:labelTime];
        //        NSString *str = [self segmentationStr:Entity.numbers];
//        NSString *string = Entity.numbers;
        NSArray *aArray = Entity.numbers;
        for (int i=0; i<aArray.count; i++) {
            labelTime = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];
            labelTime.backgroundColor =K_NAVBAR_COLOR;
            labelTime.textAlignment = NSTextAlignmentCenter;
            labelTime.font = [UIFont systemFontOfSize:14];
            int x = [aArray[i] intValue];
            labelTime.textColor = [UIColor whiteColor];
            labelTime.text = [NSString stringWithFormat:@"%d",x];
            labelTime.layer.cornerRadius = 20;
            labelTime.shadowColor = [UIColor colorWithWhite:0.1f alpha:0.8f];    //设置文本的阴影色彩和透明度。
            labelTime.shadowOffset = CGSizeMake(2.0f, 2.0f);
            labelTime.layer.masksToBounds =  YES;
            [self addSubview:labelTime];
        }
        
    }
    return self;
}

@end
