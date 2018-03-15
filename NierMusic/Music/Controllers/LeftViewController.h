//
//  LeftViewController.h
//  Music
//
//  Created by ljl on 17/4/5.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "RootViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol LeftViewControllerDelegate <NSObject>


-(void)leftDataarray:(NSMutableArray *)array;


@end




@interface LeftViewController : RootViewController
@property(nonatomic,weak)id<LeftViewControllerDelegate>delegate;




@end
