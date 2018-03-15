//
//  palyeView.m
//  Music
//
//  Created by ljl on 17/4/7.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "palyeView.h"

@implementation palyeView
{
    id _target;
    SEL _antion;

}


-(id)initWithFrame:(CGRect)frame andwithtaggt:(id)taght andwithsemc:(SEL)semc{

    if (self =[super initWithFrame:frame]) {
        _target=taght;
        _antion=semc;
        [self configUI];
    }

    return self;

}
-(void)configUI{


    _playImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/4, self.frame.size.height)];
  
  
    [self addSubview:_playImageview];

    _mingzilable = [[UILabel alloc]initWithFrame:CGRectMake(_playImageview.frame.size.width+3, 0, self.frame.size.width/3+45, 20)];
    _mingzilable.textColor = [UIColor whiteColor];
    _mingzilable.text = @"正在加载";
    _mingzilable.font = [UIFont systemFontOfSize:12];
    _mingzilable.textAlignment =NSTextAlignmentLeft;

    [self addSubview:_mingzilable];
    _geshoulable  =[[UILabel alloc]initWithFrame:CGRectMake(_playImageview.frame.size.width+3, _mingzilable.frame.size.height+3, _mingzilable.frame.size.width, 15)];
   
    _geshoulable.textColor =[UIColor whiteColor];
    _geshoulable.font = [UIFont systemFontOfSize:11];
    _geshoulable.textAlignment = NSTextAlignmentLeft;
    _geshoulable.text = @"正在加载";
    [self addSubview:_geshoulable];
    
    
    
    
    _palyebtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-60, 5,50, self.frame.size.height-10)];
    [_palyebtn setImage:[UIImage imageNamed:@"CMCommentVC_CMMusicInfoPanel_playBtn_normal@2x"] forState:UIControlStateNormal];
    
    [_palyebtn addTarget:_target action:_antion forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_palyebtn];
    
    
    
    
    


}




@end
