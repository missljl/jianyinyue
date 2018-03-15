//
//  GongJuLei.m
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "GongJuLei.h"

@implementation GongJuLei



+(UIView *)creatrViewlabelTitle:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag frame:(CGRect)frame{

    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.userInteractionEnabled = YES;
    view.tag =tag;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width,view.frame.size.height-20)];
    imageview.userInteractionEnabled = YES;
    imageview.image = [UIImage imageNamed:imageName];
   
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:imageview];
    
    
    
    
    
    
    
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, imageview.frame.size.width, 19)];
    label.text = title;
    label.userInteractionEnabled = YES;
    label.textColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    
    
    
    


    return view;

}
+(UIImageView *)creatViewImageviewname:(NSString *)imageview andframe:(CGRect)frame
{

    UIImageView *imav = [[UIImageView alloc]initWithFrame:frame];
    imav.image = [UIImage imageNamed:imageview];
    imav.userInteractionEnabled = YES;

    return imav;

}
+(UIView *)creatrviewlabelGeming:(NSString *)geming andlablegeshou:(NSString *)geshou andframe:(CGRect)frame{


    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.userInteractionEnabled = YES;

    UILabel *geminglable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,view.frame.size.width, view.frame.size.height-15)];
    geminglable.text=geming;
    geminglable.textColor = [UIColor blueColor];
    geminglable.font = [UIFont systemFontOfSize:15];
    geminglable.userInteractionEnabled = YES;
    
    [view addSubview:geminglable];
    
    

    UILabel *geshoulable= [[UILabel alloc]initWithFrame:CGRectMake(0, geminglable.frame.size.height+6,view.frame.size.width, 15)];
    geshoulable.text=geshou;
   geshoulable.textColor = [UIColor blueColor];
   geshoulable.font = [UIFont systemFontOfSize:12];
   geshoulable.userInteractionEnabled = YES;
    geshoulable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:geshoulable];

    
    

    return view;

}

@end
