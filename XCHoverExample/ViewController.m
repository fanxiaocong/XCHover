//
//  ViewController.m
//  XCHoverExample
//
//  Created by 樊小聪 on 2017/10/19.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewController.h"
#import "UIView+XCHover.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *hoverWindowLB;
@property (weak, nonatomic) IBOutlet UILabel *hoverSuperLB;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.hoverSuperLB hoverInSuperView];
    [self.hoverWindowLB hoverInWindow];
}

@end
