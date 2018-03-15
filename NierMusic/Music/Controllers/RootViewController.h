//
//  RootViewController.h
//  Music
//
//  Created by ljl on 17/4/5.
//  Copyright © 2017年 李金龙. All rights reserved.
//
#define LEFT_BARITEM 1
//右边按钮
#define RIGHT_BARITEM 2


#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController



-(void)addBarBtnItemWithTitle:(NSString *)title withImageName:(NSString *)imageName withPosition:(NSInteger) position;
-(void)leftClick;
-(void)rightClick;



@end
