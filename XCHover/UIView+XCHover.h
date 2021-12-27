//
//  UIView+Hover.h
//  SpreadButton
//
//  Created by 樊小聪 on 2017/9/18.
//  Copyright © 2017年 lzy. All rights reserved.
//

/*
 *  备注：左右悬浮 🐾
 */

#import <UIKit/UIKit.h>

@interface UIView (XCHover)

/// 将视图悬浮到父视图上面
//
//  vInsets  垂直偏移量（默认 0 0）
- (void)hoverInSuperView;
- (void)hoverInSuperViewWithVInsets:(UIEdgeInsets)vInsets;

/// 将视图悬浮到 window 上面
//
//  vInsets  垂直偏移量（默认 top：statusBar高度；bottom：safeAreaInsets.bottom）
- (void)hoverInWindow;
- (void)hoverInWindowWithVInsets:(UIEdgeInsets)vInsets;

/// 将视图悬浮到另一个视图的边缘
//
//  view    容器视图
//  vInsets  垂直偏移量（默认 0 0）
- (void)hoverInView:(UIView *)view;
- (void)hoverInView:(UIView *)view vInsets:(UIEdgeInsets)vInsets;

@end
