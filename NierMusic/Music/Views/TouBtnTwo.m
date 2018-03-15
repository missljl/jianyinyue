//
//  TouBtnTwo.m
//  Music
//
//  Created by ljl on 17/4/2.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "TouBtnTwo.h"

@implementation TouBtnTwo


///触摸开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    //获取触摸开始的坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentP = [touch locationInView:self];
    [self.touch1Delegate touchesBeganWithPoint1:currentP];
}

//触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint currentP = [touch locationInView:self];
    [self.touch1Delegate touchesEndWithPoint1:currentP];
}

//移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentP = [touch locationInView:self];
    [self.touch1Delegate touchesMoveWithPoint1:currentP];
}



@end
