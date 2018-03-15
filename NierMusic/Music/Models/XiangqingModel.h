//
//  XiangqingModel.h
//  Music
//
//  Created by ljl on 17/4/8.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface XiangqingModel : JSONModel
@property(nonatomic,copy)NSString <Optional>*aid;
@property(nonatomic,copy)NSString <Optional>*coverImg;
@property(nonatomic,copy)NSString <Optional>*tag;

@property(nonatomic,copy)NSString <Optional>*bannerImg;
@property(nonatomic,copy)NSString <Optional>*newvvBanner;
@property(nonatomic,copy)NSString <Optional>*author;
@property(nonatomic,copy)NSString <Optional>*bgImg;
@property(nonatomic,copy)NSString <Optional>*img;

@property(nonatomic,copy)NSString <Optional>*musicInfo;
@property(nonatomic,copy)NSString <Optional>*subtitle;
@property(nonatomic,copy)NSString <Optional>*title;

@property(nonatomic,copy)NSString <Optional>*top;
@property(nonatomic,copy)NSString <Optional>*updated_at;

@property(nonatomic,copy)NSString <Optional>*content;

@property(nonatomic,copy)NSString <Optional>*musicList;
@property(nonatomic,copy)NSString <Optional>*infoTitle;

@end
