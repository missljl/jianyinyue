//
//  SouCangManager.h
//  Music
//
//  Created by ljl on 17/4/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoucangModel.h"
@interface SouCangManager : NSObject
+(id)manager;

//添加收藏
-(void)addModel:(SoucangModel*)model;

-(void)deleteModel:(SoucangModel *)model;

-(NSMutableArray *)allModels;

-(BOOL)isExists:(id)model;



@end
