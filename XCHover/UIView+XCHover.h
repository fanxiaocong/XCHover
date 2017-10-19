//
//  UIView+Hover.h
//  SpreadButton
//
//  Created by 樊小聪 on 2017/9/18.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XCHover)

/**
 *  将视图悬浮到父视图上面
 */
- (void)hoverInSuperView;

/**
 *  将视图悬浮到 window 上面
 */
- (void)hoverInWindow;

/**
 *  将视图悬浮到另一个视图的边缘
 *
 *  @param view 容器视图
 */
- (void)hoverInView:(UIView *)view;

@end
