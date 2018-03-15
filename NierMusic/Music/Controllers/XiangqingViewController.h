//
//  XiangqingViewController.h
//  Music
//
//  Created by ljl on 17/4/7.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "RootViewController.h"

@protocol xiangqingDelegate <NSObject>

-(void)xiangqinggequUrl:(NSString *)url andxiangqinggequimage:(NSString *)imagestr andxiangqinggeming:(NSString *)geming andxiangqinggeshou:(NSString*)geshou andxiangqingtrok_id:(NSString *)trok_id;

@end



@interface XiangqingViewController : RootViewController
@property(nonatomic,copy)NSString* strid;
@property(nonatomic,assign)NSInteger isdujia;
@property(nonatomic,assign)NSInteger issoucang;



//第二个界面和第三个界面船只
@property(nonatomic,copy)NSString *twoheadimage;
@property(nonatomic,copy)NSString *twotitle;
@property(nonatomic,copy)NSString *twotubtitle;


@property(nonatomic,copy)NSString *toustrd;
@property(nonatomic,copy)NSString *trok_id1;

@property (nonatomic, assign) CGRect buttonFrame;

@property(nonatomic,weak)id<xiangqingDelegate>delegate;

@end
