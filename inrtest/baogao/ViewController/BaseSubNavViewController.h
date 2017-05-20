//
//  BaseSubNavViewController.h
//  Lottery_first
//
//  Created by SunnyInfo MacBook on 17/4/21.
//  Copyright © 2017年 guoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSubNavViewController : UIViewController

{
    UIBarButtonItem *btnBackItem;
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
    
    BOOL enablePopAnimation;
    BOOL _denyBackUp;
}

@property (strong, nonatomic) UIViewController *backViewController;
@property (nonatomic, assign) BOOL denyBackUp;

-(void)returnAction;
@end
