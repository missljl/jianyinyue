//
//  GongJuLei.h
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GongJuLei : NSObject


@property(nonatomic,strong)UIView *xianview;




+(UIView *)creatrViewlabelTitle:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag frame:(CGRect)frame;


+(UIImageView *)creatViewImageviewname:(NSString *)imageview andframe:(CGRect)frame;


+(UIView *)creatrviewlabelGeming:(NSString *)geming andlablegeshou:(NSString *)geshou andframe:(CGRect)frame;



@end
