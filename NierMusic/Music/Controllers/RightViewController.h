//
//  RightViewController.h
//  Music
//
//  Created by ljl on 17/4/5.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "RootViewController.h"


#import "SoucangModel.h"
@protocol RightVCdelegate <NSObject>

-(void)rightvcWithmodel:(SoucangModel *)model;

@end

@interface RightViewController : RootViewController
@property(nonatomic,weak)id<RightVCdelegate>delegate;
@end
