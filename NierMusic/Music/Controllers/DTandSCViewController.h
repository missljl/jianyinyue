//
//  DTandSCViewController.h
//  Music
//
//  Created by ljl on 17/4/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "RootViewController.h"
#import "SoucangModel.h"
@protocol DtandDelegate <NSObject>

-(void)DtandSCwithmodel:(SoucangModel *)model;

@end





@interface DTandSCViewController : RootViewController
@property(nonatomic,copy)NSString *titlestr;
@property(nonatomic,assign)NSInteger DianORWen;
@property(nonatomic,weak)id<DtandDelegate>delegate;


@end
