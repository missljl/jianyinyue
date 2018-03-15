//
//  WenzhangManager.h
//  Music
//
//  Created by ljl on 17/4/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WenzhangModel.h"
@interface WenzhangManager : NSObject
+(id)manager;

//添加收藏
-(void)addModel:(WenzhangModel*)model;

-(void)deleteModel:(WenzhangModel *)model;

-(NSMutableArray *)allModels;

-(BOOL)isExists:(id)model;
@end
