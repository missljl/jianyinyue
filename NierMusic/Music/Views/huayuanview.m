//
//  huayuanview.m
//  UIBezierPah&cashaplayer
//
//  Created by 1111 on 2017/7/4.
//  Copyright © 2017年 1111. All rights reserved.
//

#import "huayuanview.h"






@implementation huayuanview



-(id)initWithFrame:(CGRect)frame{


    if (self=[super initWithFrame:frame]) {
        [self confitui];
    }
    return self;
}
-(void)confitui{

    //初始化cashapelayer
    self.shapelayer =[CAShapeLayer layer];
    
    self.shapelayer.fillColor =[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0].CGColor;
    
    
    //设置线条的宽度和颜色
    self.shapelayer.lineWidth =2.0f;
    self.shapelayer.strokeColor =[UIColor whiteColor].CGColor;
    
    
    //创建出圆形贝塞尔曲线  这个方法是根据一个矩形画内切曲线。通常用它来画圆或者椭圆
    
    CGFloat d =self.frame.size.width/4;
    
    CGFloat f=self.frame.size.height/2;
    UIBezierPath *circlepaht =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width/2-d,self.frame.size.height/2-d, f, f)];

    self.shapelayer.path=circlepaht.CGPath;

    [self.layer addSublayer:self.shapelayer];
    
    //    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.shapelayer addAnimation:pathAnimation forKey:nil];
    //
    //
    //    /*
    //     现在我们要用到CAShapeLayer的两个参数，strokeEnd和strokeStart
    //     Stroke:用笔画的意思
    //     在这里就是起始笔和结束笔的位置
    //     Stroke为1的话就是一整圈，0.5就是半圈，0.25就是1/4圈。以此类推
    //
    //     */
    //
    //
    //    //  如果我们把起点设为0，终点设为1.0    设置stroke起始点
    self.shapelayer.strokeStart = 0;
    self.shapelayer.strokeEnd = 1.0;


    
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(0,0, 80, 80)];
      lable.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    lable.text =@"简音悦";
  
    lable.alpha=0;
    lable.font =[UIFont systemFontOfSize:17];
    lable.textAlignment =NSTextAlignmentCenter;
    lable.textColor =[UIColor whiteColor];
    [self addSubview:lable];
    
   [UIView animateWithDuration:2 animations:^{
      
       lable.alpha=1;
       
//       CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//       animation.fromValue=[NSNumber numberWithFloat:0.9];
//       animation.toValue=[NSNumber numberWithFloat:1.2];
//       animation.duration=1.5;
//       animation.autoreverses=YES;
//       animation.repeatCount=500;
//       animation.removedOnCompletion=NO;
//       animation.fillMode=kCAFillModeForwards;
//       [lable.layer addAnimation:animation forKey:@"zoom"];
       
       
   }];
    
    
    
    
    
    
}

@end
