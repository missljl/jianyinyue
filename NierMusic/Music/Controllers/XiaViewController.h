//
//  XiaViewController.h
//  Music
//
//  Created by ljl on 17/4/4.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface XiaViewController : UIViewController
-(BOOL)prefersStatusBarHidden;







@property(nonatomic,strong)NSMutableArray *songArr1;//歌曲数组
@property(nonatomic,strong)NSMutableArray *songNameArr1;//歌曲名称数组
@property(nonatomic,strong)NSMutableArray *songAuthorArr1;//歌曲演唱者数组
@property(nonatomic,strong)NSMutableArray *songImageArr1;//歌曲图片数组

@property(nonatomic,strong)UIButton *leftbtn;

@property(nonatomic,strong)NSMutableArray *trok_idarray;

-(void)addPlayerViewandSongUrlArr:(NSArray *)urlarr andSongImageArr:(NSArray *)imagear;



@end
