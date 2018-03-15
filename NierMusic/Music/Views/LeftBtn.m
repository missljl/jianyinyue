//
//  LeftBtn.m
//  Music
//
//  Created by ljl on 17/4/5.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "LeftBtn.h"

@implementation LeftBtn

-(id)initWithFrame:(CGRect)frame{


    if (self = [super initWithFrame:frame]) {
        [self cfingUI];
    }

    return self;

}
-(void)cfingUI{

    self.layer.cornerRadius = 25.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 2.0f;
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:0.9];
    animation.toValue=[NSNumber numberWithFloat:1.0];
    animation.duration=1.5;
    animation.autoreverses=YES;
    animation.repeatCount=500;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"zoom"];


    
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    
    //创建对象就是动画的路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //圆形弧度
    CGPathAddEllipseInRect(path, NULL, CGRectMake(self.frame.origin.x,self.frame.origin.y, 10, 5));
    
    
    //设置的是位置的开始
//    CGPathMoveToPoint(path,NULL,self.frame.origin.x,self.frame.origin.y);
    animation1.path=path;
    
    CGPathRelease(path);
    //是否原路返回
    animation1.autoreverses = YES;
    
    animation1.repeatCount=MAXFLOAT;
    
    animation1.removedOnCompletion = NO;
    
    animation1.fillMode = kCAFillModeForwards;
    
    animation1.duration = 3.5f;
    
    //    animation1.timingFunction=[CAMediaTimingFunctionfunctionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画的节奏kCAMediaTimingFunctionEaseInEaseOut（一开始慢，中间加速，临近结速变慢）
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation1.delegate=self;
    
    [self.layer addAnimation:animation1 forKey:nil];
    
    
    
    
    
    
    
    
    
   
}

@end
