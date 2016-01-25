//
//  CustomHudView.m
//  GHCustomHUD
//
//  Created by sally on 16/1/25.
//  Copyright © 2016年 koalac. All rights reserved.
//

#import "CustomHudView.h"
#import "UIView+Extension.h"

@interface CustomHudView ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *hudImage;

@end

@implementation CustomHudView

- (instancetype)initCustomHud {
  NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CustomHudView" owner:nil options:nil];
  self = nibArray[0];
  if (self) {
    [self initControl];
    [self startAnima];
  }
  return self;
}

- (void)initControl {
  self.backgroundView.layer.cornerRadius = 8.0;
  self.backgroundView.layer.masksToBounds = YES;
}

#pragma mark - 动画
#pragma mark 开始动画
- (void)startAnima {
  //1.创建旋转动画
  CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];

  //1.1设置通过动画，将layer从哪儿移动到哪儿
  anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
  anima.toValue = [NSNumber numberWithFloat:M_PI * 2];
  anima.repeatCount = HUGE_VALF;
  anima.duration = 1;

  //1.2设置动画执行完毕之后不删除动画
  anima.removedOnCompletion = NO;
  //1.3设置保存动画的最新状态
  anima.fillMode = kCAFillModeForwards;

  //1.4.添加核心动画到layer
  [self.hudImage.layer addAnimation:anima forKey:nil];
}

#pragma mark 暂停layer上面的动画
- (void)pauseLayer:(CALayer *)layer {
  CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
  layer.speed = 0.0;
  layer.timeOffset = pausedTime;
}

#pragma mark 继续layer上面的动画
- (void)resumeLayer:(CALayer *)layer {
  CFTimeInterval pausedTime = [layer timeOffset];
  layer.speed = 1.0;
  layer.timeOffset = 0.0;
  layer.beginTime = 0.0;
  CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
  layer.beginTime = timeSincePause;
}

#pragma mark 暂停动画
- (void)pauseSoccer {
  [self pauseLayer:self.hudImage.layer];
}
#pragma mark 继续动画
- (void)resumeSoccer {
  [self resumeLayer:self.hudImage.layer];
}

#pragma mark - 创建缓冲圈
#pragma mark 创建缓冲圈在当前view中
+ (CustomHudView *)createHUDInView:(UIView *)view {
  CustomHudView *hud = [[self alloc] initCustomHud];
  hud.size = CGSizeMake(view.frame.size.width, view.frame.size.height);
  [view addSubview:hud];
  return hud;
}

#pragma mark 创建缓冲圈在当前顶层的vc中
+ (CustomHudView *)createHUDInCurrVC{
  UIViewController *vc = [self getCurrViewController];
  return [self createHUDInView:vc.view];
}

#pragma mark - 隐藏缓冲圈
- (void)setHidden:(BOOL)hidden{
  [self pauseLayer:self.hudImage.layer];
  [self removeFromSuperview];
}

#pragma mark 隐藏当前view中的所有缓冲圈
+ (NSUInteger)hideAllHUDsForView:(UIView *)view{
  NSArray *huds = [self allHUDsForView:view];
  for (CustomHudView *hud in huds) {
    [hud pauseLayer:hud.hudImage.layer];
    [hud removeFromSuperview];
  }
  return [huds count];
}

#pragma mark 隐藏当前顶层的vc中的所有缓冲圈
+ (NSUInteger)hideAllHUDsForCurrVC{
  UIViewController *vc = [self getCurrViewController];
  return [self hideAllHUDsForView:vc.view];
}

#pragma mark 获取当前view中的所有缓冲圈
+ (NSArray *)allHUDsForView:(UIView *)view {
  NSMutableArray *huds = [NSMutableArray array];
  NSArray *subviews = view.subviews;
  for (UIView *aView in subviews) {
    if ([aView isKindOfClass:self]) {
      [huds addObject:aView];
    }
  }
  return [NSArray arrayWithArray:huds];
}

#pragma mark 获取当前顶层的navController
+ (UIViewController *)getCurrViewController{
  //如果是tabbar构建的项目，可以通过以下方法获取当前顶层vc
//  UITabBarController *tabBarControler = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
//  UINavigationController *navController = tabBarControler.selectedViewController;
//  UIViewController *currVc = [navController.viewControllers lastObject];

  UIViewController *currVc = (id)UIApplication.sharedApplication.delegate.window.rootViewController;
  return currVc;
}

@end
