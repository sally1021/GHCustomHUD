//
//  CustomHudView.h
//  GHCustomHUD
//
//  Created by sally on 16/1/25.
//  Copyright © 2016年 koalac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHudView : UIView

@property (assign, nonatomic) BOOL hidden;

+ (CustomHudView *)createHUDInView:(UIView *)view;
+ (CustomHudView *)createHUDInCurrVC;
+ (NSUInteger)hideAllHUDsForView:(UIView *)view;
+ (NSUInteger)hideAllHUDsForCurrVC;

@end
