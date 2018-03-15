//
//  HeadView.h
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "Toubtns.h"
#import "SouYeModel.h"
#import "SouYeToumode.h"
@protocol HeadDelegate <NSObject>

-(void)headViewsid:(SouYeToumode *)model;

@end




@interface HeadView : UIView<LJLButtonDelegate>


-(id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array;
@property(nonatomic,strong)Toubtns *view2;
@property(nonatomic,weak)id<HeadDelegate>delegate;
@end
