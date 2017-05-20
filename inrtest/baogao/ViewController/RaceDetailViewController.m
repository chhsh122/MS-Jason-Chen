//
//  RaceDetailViewController.m
//  Lottery_first
//
//  Created by Guoguo on 2017/4/28.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import "RaceDetailViewController.h"

@interface RaceDetailViewController ()

@end

@implementation RaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"leagueName"]];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", _dicDataSource);
    [self initRaceDetailUI];
    
}

- (void)initRaceDetailUI {

    CGFloat spacing = 8.0f;
    CGFloat border  = 1.0f;
    CGFloat lblHeight = 22.0f;
   
    
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, spacing+60, SCREEN_WIDTH, SCREEN_HEIGHT / 3)];
    viewBack.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewBack];
    
     CGFloat imgHeight = (viewBack.frame.size.height - border - 2 * spacing) / 2;
    
     UIImageView *imgTeamA = [[UIImageView alloc] initWithFrame:CGRectMake(spacing, spacing, imgHeight, imgHeight)];
    [viewBack addSubview:imgTeamA];
    
    UILabel *lblTeamAName = [[UILabel alloc] initWithFrame:CGRectMake(spacing, imgTeamA.frame.origin.y + imgTeamA.frame.size.height + border, imgHeight, lblHeight)];
    lblTeamAName.textAlignment = NSTextAlignmentCenter;
    [lblTeamAName setFont:[UIFont systemFontOfSize:16.0]];
    [viewBack addSubview:lblTeamAName];
    
    UILabel *lblScore = [[UILabel alloc] initWithFrame:CGRectMake(imgTeamA.frame.origin.x + imgHeight + spacing, imgTeamA.frame.origin.y, viewBack.frame.size.width - 2 * imgHeight - 4 * spacing, imgHeight)];
    lblScore.textAlignment = NSTextAlignmentCenter;
    [lblScore setFont:[UIFont boldSystemFontOfSize:18.0]];
    [viewBack addSubview:lblScore];
    
    UIImageView *imgTeamB = [[UIImageView alloc] initWithFrame:CGRectMake(lblScore.frame.origin.x + lblScore.frame.size.width + spacing, imgTeamA.frame.origin.y, imgHeight, imgHeight)];
    [viewBack addSubview:imgTeamB];
    
    UILabel *lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(lblScore.frame.origin.x, lblTeamAName.frame.origin.y, lblScore.frame.size.width, lblTeamAName.frame.size.height)];
    lblStatus.textAlignment = NSTextAlignmentCenter;
    [lblStatus setFont:[UIFont systemFontOfSize:16.0]];

    [viewBack addSubview:lblStatus];
    
    UILabel *lblMatchTime = [[UILabel alloc] initWithFrame:CGRectMake(0, lblStatus.frame.origin.y + lblStatus.frame.size.height + spacing, kWidth, lblStatus.frame.size.height)];
    lblMatchTime.textAlignment = NSTextAlignmentCenter;
    [lblMatchTime setFont:[UIFont systemFontOfSize:14.0]];
//    lblMatchTime.backgroundColor =[UIColor redColor];
    [viewBack addSubview:lblMatchTime];
    
    UILabel *lblTeamBName = [[UILabel alloc] initWithFrame:CGRectMake(imgTeamB.frame.origin.x, lblTeamAName.frame.origin.y, lblTeamAName.frame.size.width, lblTeamAName.frame.size.height)];
    lblTeamBName.textAlignment = NSTextAlignmentCenter;
    [lblTeamBName setFont:[UIFont systemFontOfSize:16.0]];
    [viewBack addSubview:lblTeamBName];
    
    lblMatchTime.text = [NSString stringWithFormat:@"%@ %@",[_dicDataSource objectForKey:@"matchDay"], [_dicDataSource objectForKey:@"matchTime"]];//@"周四001 俄超 22：00";
    if (!_isFootballRace) {
        lblTeamAName.text = [NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"visitName"]];//@"阿姆卡尔";
        lblTeamBName.text = [NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"hostName"]];//@"克拉斯诺";
        [imgTeamA setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"visitLogoUrl"]]] placeholderImage:nil];
        [imgTeamB setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"hostLogoUrl"]]] placeholderImage:nil];
        lblScore.text = [NSString stringWithFormat:@"%@:%@", [_dicDataSource objectForKey:@"visitGoal"], [_dicDataSource objectForKey:@"hostGoal"]];//@"0:2";

    } else {
        
        lblTeamAName.text = [NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"teamA"]];//@"阿姆卡尔";
        lblTeamBName.text = [NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"teamB"]];//@"克拉斯诺";
        
        [imgTeamA setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"teamALogo"]]] placeholderImage:nil];
        [imgTeamB setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"teamBLogo"]]] placeholderImage:nil];
        lblScore.text = [NSString stringWithFormat:@"%@:%@", [_dicDataSource objectForKey:@"teamAGoal"], [_dicDataSource objectForKey:@"teamBGoal"]];//@"0:2";
    }
    lblStatus.text =  [NSString stringWithFormat:@"%@", [_dicDataSource objectForKey:@"statusDesc"]];//@"已结束";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
