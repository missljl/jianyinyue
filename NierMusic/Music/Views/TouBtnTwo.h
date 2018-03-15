//
//  TouBtnTwo.h
//  Music
//
//  Created by ljl on 17/4/2.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJLButtoTwoDelegate <NSObject>

/**
 * 开始触摸
 */
- (void)touchesBeganWithPoint1:(CGPoint)point;

/**
 * 结束触摸
 */
- (void)touchesEndWithPoint1:(CGPoint)point;

/**
 * 移动手指
 */
- (void)touchesMoveWithPoint1:(CGPoint)point;



@end








@interface TouBtnTwo : UIButton


@property (weak, nonatomic) id <LJLButtoTwoDelegate> touch1Delegate;







@end
