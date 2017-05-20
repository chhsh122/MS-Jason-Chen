//
//  MineDetailTableViewCell.m
//  Domino
//
//  Created by HongShun Chen on 2017/3/24.
//  Copyright © 2017年 jack.wang. All rights reserved.
//

#import "MineDetailTableViewCell.h"


@implementation MineDetailTableViewCell

@synthesize labelText;
@synthesize labelStr;
@synthesize labelTime;
@synthesize titleName;
@synthesize titleStr;
@synthesize dataArr;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(instancetype)initWithtableView:(UITableView *)tableView Data:(kaiJiangEntity *)Entity{
    
    MineDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    
    if (cell == nil) {
        cell = [[MineDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeCell"Data:Entity];
    }
    return cell;
    
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(kaiJiangEntity *)Entity{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

        //spr 彩票种类
        titleName = [[UILabel alloc]initWithFrame:CGRectMake(5,3, 100, 30)];

        self.selectionStyle= UITableViewCellSelectionStyleNone;

        titleName.textAlignment= NSTextAlignmentLeft;
        titleName.font = [UIFont fontWithName:@"Arial Rounded MT Bold"  size:(17.0)];
        [titleName setTextColor:[UIColor blackColor]];
        [self addSubview:titleName];

        
        
        //labelStr 期数
        
        labelStr = [[UILabel alloc]initWithFrame:CGRectMake(K_RECT_MAXX(titleName)+10, 5, self.frame.size.height+50, 25)];
        labelStr.textAlignment= NSTextAlignmentLeft;
        [labelStr setTextColor:[UIColor lightGrayColor]];
        labelStr.font = [UIFont systemFontOfSize:11];
        [self addSubview:labelStr];
        
        //title时间
        labelText = [[UILabel alloc]initWithFrame:CGRectMake(K_RECT_MAXX(labelStr), 5, K_FRAME_BASE_WIDTH/10*5, 25)];
        labelText.font = [UIFont systemFontOfSize:11];
        [labelText setTextColor:[UIColor lightGrayColor]];

        [self  addSubview:labelText];
        


        NSString *string = Entity.numbers;
        NSArray *aArray = [string componentsSeparatedByString:@","];
        for (int i=0; i<aArray.count; i++) {
            labelTime = [[UILabel alloc]initWithFrame:CGRectMake(5+45*i, K_RECT_MAXY(labelText)+5, 40, 40)];
            labelTime.backgroundColor =[UIColor redColor];
            labelTime.textAlignment = NSTextAlignmentCenter;
            labelTime.font = [UIFont systemFontOfSize:14];
            int x = [aArray[i] intValue];
            labelTime.textColor = [UIColor whiteColor];
            labelTime.text = [NSString stringWithFormat:@"%d",x];
            labelTime.layer.cornerRadius = 20;
            labelTime.layer.masksToBounds =  YES;
            [self addSubview:labelTime];
        }
        
    }
    return self;
}


-(NSString *)segmentationStr:(NSString *)str
{
    if (str.length > 15) {
        NSArray *array = [str componentsSeparatedByString:@","];
        str = array[2];
    }
    return str;
}
@end
