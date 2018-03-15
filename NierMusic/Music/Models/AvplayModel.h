//
//  AvplayModel.h
//  Music
//
//  Created by 1111 on 2017/6/17.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface AvplayModel : JSONModel


@property(nonatomic,copy)NSString <Optional>*KL;
@property(nonatomic,copy)NSString <Optional>*KL128;
@property(nonatomic,copy)NSString <Optional>*KLM;

@property(nonatomic,copy)NSDictionary <Optional>*user;
@property(nonatomic,copy)NSString <Optional>*SK;

@property(nonatomic,copy)NSString <Optional>*ID;

@end
