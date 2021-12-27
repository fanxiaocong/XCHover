//
//  UIView+Hover.m
//  SpreadButton
//
//  Created by 樊小聪 on 2017/9/18.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "UIView+XCHover.h"
#import <objc/runtime.h>

#define SELF_WIDTH  self.bounds.size.width
#define SELF_HEIGHT self.bounds.size.height

@implementation UIView (XCHover)

#pragma mark - 🔓 👀 Public Method 👀

- (void)hoverInSuperView
{
    [self hoverInSuperViewWithVInsets:UIEdgeInsetsZero];
}

- (void)hoverInSuperViewWithVInsets:(UIEdgeInsets)vInsets
{
    [self hoverInView:self.superview vInsets:vInsets];
}


- (void)hoverInWindow
{
    UIEdgeInsets insets = UIEdgeInsetsMake([self _fetchTopHeight], 0, [self _fetchBottomHeight], 0);
    [self hoverInWindowWithVInsets:insets];
}

- (void)hoverInWindowWithVInsets:(UIEdgeInsets)vInsets
{
    [self hoverInView:[UIApplication sharedApplication].keyWindow vInsets:vInsets];
}


- (void)hoverInView:(UIView *)view
{
    [self hoverInView:view vInsets:UIEdgeInsetsZero];
}

- (void)hoverInView:(UIView *)view vInsets:(UIEdgeInsets)vInsets
{
    /// 将视图添加到容器视图
    if (self.superview != view) {
        [view addSubview:self];
        self.center = CGPointMake(SELF_WIDTH * 0.5,
                                  vInsets.top + SELF_HEIGHT * 0.5);
    }

    /// 添加 滑动手势
    self.superview.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    // 绑定 offset 值
    [self setVInsets:vInsets];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

#pragma mark - 🎬 👀 Action Method 👀

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGRect rect = self.bounds;
    CGPoint location = [pan locationInView:self.superview];
    // 偏移值
    UIEdgeInsets vInsets = [pan.view vInsets];
    switch (pan.state) {
        case UIGestureRecognizerStateChanged: {
            /// 更新 view 的位置
            self.center = location;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            /// 当手势停止的时候，重新设置 view 的位置
            CGFloat superWidth  = self.superview.bounds.size.width;
            CGFloat superHeight = self.superview.bounds.size.height;
            CGFloat selfWidth   = SELF_WIDTH;
            CGFloat selfHeight  = SELF_HEIGHT;
            
            if (location.y < vInsets.top + selfHeight*0.5) {
                location.y = vInsets.top + selfHeight*0.5;
            } else if (location.y > (superHeight-selfHeight*0.5-vInsets.bottom)) {
                location.y = superHeight-selfHeight*0.5-vInsets.bottom;
            }
            
            if (location.x > superWidth * 0.5) {
                location.x = superWidth - selfWidth * 0.5;
            } else {
                location.x = selfWidth * 0.5;
            }
            rect.origin = CGPointMake(location.x-selfWidth*0.5, location.y-selfHeight*0.5);
            [UIView animateWithDuration:0.1 animations:^{
                self.frame = rect;
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 🔒 👀 Privite Method 👀

/// 顶部距离
- (CGFloat)_fetchTopHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

/// 底部距离
- (CGFloat)_fetchBottomHeight
{
   if (@available(iOS 11.0, *)) {
       UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
       return mainWindow.safeAreaInsets.bottom;
   }
   return 0;
}

- (void)setVInsets:(UIEdgeInsets)vInsets
{
    objc_setAssociatedObject(self, @selector(vInsets), [NSValue valueWithUIEdgeInsets:vInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)vInsets
{
    NSValue *vInsetsValue = objc_getAssociatedObject(self, _cmd);
    return [vInsetsValue UIEdgeInsetsValue];
}

@end
