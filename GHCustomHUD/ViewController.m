//
//  ViewController.m
//  GHCustomHUD
//
//  Created by sally on 16/1/25.
//  Copyright © 2016年 koalac. All rights reserved.
//

#import "ViewController.h"
#import "CustomHudView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)showInView:(id)sender {
  //1.1、显示缓冲圈在view中
  [CustomHudView createHUDInView:self.view];
  //1.2、通过hud直接隐藏缓冲圈
  //CustomHudView *hud = [CustomHudView createHUDInView:self.view];
  //hud.hidden = YES;
  
  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(hideInViewAfterTimer) userInfo:nil repeats:NO];
}

- (void)hideInViewAfterTimer {
  //1.3、隐藏view中所有的缓冲圈
  [CustomHudView hideAllHUDsForView:self.view];
}

//2.1、显示缓冲圈在vc中
- (IBAction)showInVc:(id)sender {
  [CustomHudView createHUDInCurrVC];//亦可使用直接隐藏缓冲圈的方式
  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(hideInVcAfterTimer) userInfo:nil repeats:NO];
}

- (void)hideInVcAfterTimer {
  //2.2、隐藏vc中所有的缓冲圈
  [CustomHudView hideAllHUDsForCurrVC];
}

@end
