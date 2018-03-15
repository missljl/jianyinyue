//
//  Toubtns.h
//  Music
//
//  Created by ljl on 17/4/2.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LJLButtonDelegate <NSObject>

/**
 * 开始触摸
 */
- (void)touchesBeganWithPoint:(CGPoint)point;

/**
 * 结束触摸
 */
- (void)touchesEndWithPoint:(CGPoint)point;

/**
 * 移动手指
 */
- (void)touchesMoveWithPoint:(CGPoint)point;



@end



@interface Toubtns : UIImageView
@property (weak, nonatomic) id <LJLButtonDelegate> touchDelegate;


@end
