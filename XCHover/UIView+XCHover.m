//
//  UIView+Hover.m
//  SpreadButton
//
//  Created by 樊小聪 on 2017/9/18.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import "UIView+XCHover.h"

// 悬浮后，距离边缘的距离
static CGFloat const hoverEdgeMargin  = 10.f;

#define SELF_WIDTH  self.bounds.size.width
#define SELF_HEIGHT self.bounds.size.height


@implementation UIView (XCHover)

/**
 *  将视图悬浮到父视图上面
 */
- (void)hoverInSuperView
{
    [self hoverInView:self.superview];
}

/**
 *  将视图悬浮到 window 上面
 */
- (void)hoverInWindow
{
    [self hoverInView:[UIApplication sharedApplication].keyWindow];
}

/**
 *  将视图悬浮到另一个视图的边缘
 *
 *  @param view 容器视图
 */
- (void)hoverInView:(UIView *)view
{
    /// 将视图添加到容器视图
    if (self.superview != view)
    {
        [view addSubview:self];
        self.center = CGPointMake(hoverEdgeMargin + SELF_WIDTH * 0.5,
                                  hoverEdgeMargin + SELF_HEIGHT * 0.5);
    }
    
    /// 添加 滑动手势
    self.superview.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}

#pragma mark - 🎬 👀 Action Method 👀

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint location = [pan locationInView:self.superview];
    
    switch (pan.state)
    {
        case UIGestureRecognizerStateChanged:
        {
            /// 更新 view 的位置
            self.center = location;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            /// 当手势停止的时候，重新设置 view 的位置

            CGFloat superWidth  = self.superview.bounds.size.width;
            CGFloat superHeight = self.superview.bounds.size.height;
            CGFloat selfWidth   = SELF_WIDTH;
            CGFloat selfHeight  = SELF_HEIGHT;
            
            // 需要进行悬浮的最小距离，当超过这个距离的时候，就需要进行悬浮操作
            CGFloat magneticDistance = superHeight * 0.15;
            
            // 最终显示的位置
            CGPoint destPosition;
            
            if (location.y < magneticDistance)
            {   //上面
                destPosition = CGPointMake(location.x, selfWidth * 0.5 + hoverEdgeMargin);
            }
            else if (location.y > superHeight - magneticDistance)
            {   //下面
                destPosition = CGPointMake(location.x, superHeight - selfHeight * 0.5 - hoverEdgeMargin);
            }
            else if (location.x > superWidth * 0.5)
            {   //右边
                destPosition = CGPointMake(superWidth - (selfWidth * 0.5 + hoverEdgeMargin), location.y);
            }
            else
            {   //左边
                destPosition = CGPointMake(selfWidth * 0.5 + hoverEdgeMargin, location.y);
            }
            
            // 最大、最小 X/Y 边界值
            CGFloat maxDestPositionX = superWidth - hoverEdgeMargin - selfWidth * 0.5;
            CGFloat minDestPositionX = hoverEdgeMargin + selfWidth * 0.5;
            CGFloat maxDestPositionY = superHeight - hoverEdgeMargin - selfHeight * 0.5;
            CGFloat minDestPositionY = hoverEdgeMargin + selfHeight * 0.5;
            
            destPosition.x = MIN(destPosition.x, maxDestPositionX);
            destPosition.x = MAX(destPosition.x, minDestPositionX);
            destPosition.y = MIN(destPosition.y, maxDestPositionY);
            destPosition.y = MAX(destPosition.y, minDestPositionY);
            
            self.layer.position = destPosition;
            
            /// 开始动画
            CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
            anim.removedOnCompletion = NO;
            anim.fromValue = [NSValue valueWithCGPoint:location];
            anim.toValue   = [NSValue valueWithCGPoint:destPosition];
            anim.duration  = .5f;
            anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [self.layer addAnimation:anim forKey:NULL];
            
            break;
        }
        default:
            break;
    }
}

@end
