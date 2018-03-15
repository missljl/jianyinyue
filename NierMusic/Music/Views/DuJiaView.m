//
//  DuJiaView.m
//  Music
//
//  Created by ljl on 17/4/11.
//  Copyright © 2017年 李金龙. All rights reserved.
//



#import "DuJiaView.h"

@implementation DuJiaView
-(id)initWithFrame:(CGRect)frame{


    if (self = [super initWithFrame:frame]) {
     
        self.clipsToBounds = YES;
        [self configUI];
        
        
      
    }

    return self;

}
-(void)configUI{


    

    _Titlelable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, self.frame.size.width, self.frame.size.height/2)];
_Titlelable.text = @"正在加载";
    _Titlelable.textColor  =[UIColor whiteColor];
    _Titlelable.font = [UIFont systemFontOfSize:13];
    _Titlelable.textAlignment = NSTextAlignmentLeft;
     _Titlelable.clipsToBounds = YES;
    [self addSubview:_Titlelable];
    
    
    _TitleTwolable = [[UILabel alloc]initWithFrame:CGRectMake((_Titlelable.frame.origin.x+10)+_Titlelable.frame.size.width, _Titlelable.frame.origin.y,_Titlelable.frame.size.width, _Titlelable.frame.size.height)];
    _TitleTwolable.text = _Titlelable.text;
    _TitleTwolable.textColor  =[UIColor whiteColor];
    _TitleTwolable.font = [UIFont systemFontOfSize:13];
    _TitleTwolable.textAlignment = NSTextAlignmentLeft;
     _Titlelable.clipsToBounds = YES;
    [self addSubview:_TitleTwolable];
    
    [self addAnimation];
    
    
    _subTitlelable = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width/2)/2, _Titlelable.frame.size.height+1, self.frame.size.width, self.frame.size.height/2-15)];
    _subTitlelable.text = @"我在加载";
    
    
    _subTitlelable.textColor  =[UIColor whiteColor];
    _subTitlelable.font = [UIFont systemFontOfSize:12];
    _subTitlelable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_subTitlelable];
    
    

    

}
- (void)addAnimation{
   CGRect scrollFrame = _Titlelable.frame;
   CGRect secondFrame = _TitleTwolable.frame;
  
    [UIView animateWithDuration:12 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _Titlelable.frame = CGRectMake(-_Titlelable.frame.size.width, _Titlelable.frame.origin.y,_Titlelable.frame.size.width, _Titlelable.frame.size.height);
        _TitleTwolable.frame = CGRectMake(0, _TitleTwolable.frame.origin.y,_TitleTwolable.frame.size.width, _TitleTwolable.frame.size.height);
       
       
    } completion:^(BOOL finished) {
       _Titlelable.frame = scrollFrame;
      _TitleTwolable.frame = secondFrame;
        
        [self addAnimation];
    }];
}
-(void)dealloc{


    [UIView commitAnimations];

}
@end
