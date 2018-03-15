//
//  LastVcsectionView.m
//  Music
//
//  Created by 1111 on 2017/6/22.
//  Copyright © 2017年 李金龙. All rights reserved.
//
/*
 
 biaoti:
 多少期
 收听次数
 tupian
 
 */
#import "LastVcsectionView.h"

@implementation LastVcsectionView
{

//    NSString *biaotitle;
//    NSString *riqi;
//    NSString *dianjicishu;
//    NSString *tupianname;
  
        id _target;
        SEL _antion;
        
    

}
-(id)initWithFrame:(CGRect)frame {

    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled =YES;
//        _target=taght;
//        _antion=antion;
        [self cfigUI];
        
    }

    return self;

}
-(void)cfigUI{

    _titlelabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 10,self.frame.size.width, 20)];
    _titlelabel.font =[UIFont systemFontOfSize:16];
    _titlelabel.textAlignment =NSTextAlignmentLeft;
//      self.userInteractionEnabled =YES;
    [self addSubview:_titlelabel];
    
    _riqilabel =[[UILabel alloc]initWithFrame:CGRectMake(10, _titlelabel.frame.origin.y+_titlelabel.frame.size.height+5, self.frame.size.width, 15)];
    _riqilabel.font =[UIFont systemFontOfSize:13];
    _riqilabel.textColor =[UIColor lightGrayColor];
    [self addSubview:_riqilabel];
    
    CGFloat f =self.frame.size.height-_titlelabel.frame.size.height-_riqilabel.frame.size.height-20;
    _playImageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, _riqilabel.frame.origin.y+_riqilabel.frame.size.height+5, self.frame.size.width, f)];
    _playImageview.userInteractionEnabled =YES;
    [self addSubview:_playImageview];
    
    
//    _palyebtn =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-70, _playImageview.frame.origin.y-30, 60, 60)];
////    CMGeneTransceiverVC_pauseBtn
//    [_palyebtn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_playBtn"] forState:UIControlStateNormal];
//      [_palyebtn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_pauseBtn"] forState:UIControlStateSelected];
//    [_palyebtn addTarget:_target action:_antion forControlEvents:UIControlEventTouchUpInside];
//   
//    [self addSubview:_palyebtn];
//
    
    
    
    
    
    

}
@end
