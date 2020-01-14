//
//  UIView+Hover.h
//  SpreadButton
//
//  Created by 樊小聪 on 2017/9/18.
//  Copyright © 2017年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XCHover)

/// 将视图悬浮到父视图上面
//
//  offset  偏移量（默认 10）
- (void)hoverInSuperView;
- (void)hoverInSuperViewOffset:(CGFloat)offset;

/// 将视图悬浮到 window 上面
//
//  offset  偏移量（默认 10）
- (void)hoverInWindow;
- (void)hoverInWindowOffset:(CGFloat)offset;

/// 将视图悬浮到另一个视图的边缘
//
//  view    容器视图
//  offset  偏移量（默认 10）
- (void)hoverInView:(UIView *)view;
- (void)hoverInView:(UIView *)view offset:(CGFloat)offset;

@end
