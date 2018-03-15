//
//  XiaTouView.m
//  Music
//
//  Created by ljl on 17/4/6.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "XiaTouView.h"
#import "GongJuLei.h"
@implementation XiaTouView
//{
//    UILabel *geminglable;
//    UILabel *geshoulable;
//
//
//}
-(id)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self configUI];
        
    }
    return self;

}
-(void)configUI{
    
    

    
    _geminglable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height-17)];
  _geminglable.text=@"还没有选歌噢";
    _geminglable.textColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
    _geminglable.font = [UIFont systemFontOfSize:16];
    _geminglable.textAlignment = NSTextAlignmentCenter;
    _geminglable.userInteractionEnabled = YES;
    
    [self addSubview:_geminglable];
    
    
    
   _geshoulable= [[UILabel alloc]initWithFrame:CGRectMake(0, _geminglable.frame.size.height-5,self.frame.size.width, 17)];
   _geshoulable.text=@"点击左侧选择喜欢的歌曲";
    _geshoulable.textColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
    _geshoulable.font = [UIFont systemFontOfSize:13];
    _geshoulable.userInteractionEnabled = YES;
    _geshoulable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_geshoulable];
    

    
    
    
    
    


}



@end
