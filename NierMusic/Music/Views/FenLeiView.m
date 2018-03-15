//
//  FenLeiView.m
//  MoverApp
//
//  Created by ljl on 17/3/3.
//  Copyright © 2017年 李金龙. All rights reserved.
//

//屏幕的宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//宽的比例
#define RATE SCREEN_WIDTH/320.0
#define RATE1 SCREEN_HEIGHT/568.0



#import "FenLeiView.h"

@implementation FenLeiView



-(UIView *)congifImageviewName:(NSString *)imageviewName withLabelTitle:(NSString *)labelName  withframe:(CGRect)frame
{

    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.userInteractionEnabled = YES;
    view.contentMode = 2;
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
//    [self addSubview:view];
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageviewName]];
    imageview.frame = CGRectMake(0, 0, 140*RATE, 110*RATE1);
    imageview.userInteractionEnabled = YES;
    [view addSubview:imageview];
    


    UILabel *label = [[UILabel alloc]init];
    label.text = labelName;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.frame = CGRectMake(0, 70*RATE, 140*RATE, 20*RATE1);
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.5;
    label.textAlignment =NSTextAlignmentCenter;
    label.userInteractionEnabled = YES;
    [view addSubview:label];
    
   [view insertSubview:imageview belowSubview:label];
    
    return view;


}

-(UIView *)withLabelTitle:(NSString *)labelName congifImageviewName:(NSString *)imageviewName withframe:(CGRect)frame{



    UIView *view1 = [[UIView alloc]initWithFrame:frame];
    view1.userInteractionEnabled = YES;
    
    
//    view1.contentMode = UIViewContentModeScaleAspectFill;
    view1.layer.cornerRadius = 4;
    view1.layer.borderWidth = 1.0;
    view1.layer.borderColor =[UIColor lightGrayColor].CGColor;
   view1.layer.masksToBounds = YES;
    
    
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageviewName]];
   imageview.contentMode = UIViewContentModeScaleAspectFill;
//    imageview.layer.cornerRadius = 4;
//    imageview.layer.masksToBounds = YES;
    imageview.frame = CGRectMake((view1.frame.size.width/2)/2, 0,view1.frame.size.width/2, view1.frame.size.height-20);
    
    [view1 addSubview:imageview];
    
    imageview.userInteractionEnabled = YES;
    
    
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((view1.frame.size.width/2)/2, imageview.frame.size.height-40,view1.frame.size.width/2, 20)];
    label.text = labelName;
    label.textColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    [view1 addSubview:label];
    label.userInteractionEnabled = YES;
    
    
    
    
    return view1;






}






@end
