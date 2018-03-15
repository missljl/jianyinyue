//
//  palyeView.h
//  Music
//
//  Created by ljl on 17/4/7.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface palyeView : UIView


@property(nonatomic,strong)UIImageView *playImageview;
@property(nonatomic,strong)UILabel *mingzilable;
@property(nonatomic,strong)UILabel *geshoulable;
@property(nonatomic,strong)UIButton *palyebtn;
-(id)initWithFrame:(CGRect)frame andwithtaggt:(id)taght andwithsemc:(SEL)semc;

@end
