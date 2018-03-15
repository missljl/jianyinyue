//
//  XQModel.h
//  Music
//
//  Created by ljl on 17/4/9.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface XQModel : JSONModel
@property(nonatomic,copy)NSString <Optional>*song;
@property(nonatomic,copy)NSString <Optional>*cover;
@property(nonatomic,copy)NSString <Optional>*singer;

@property(nonatomic,copy)NSString <Optional>*music_url;
@property(nonatomic,copy)NSString <Optional>*album_music;
@property(nonatomic,copy)NSString <Optional>*music_from;
@property(nonatomic,copy)NSString <Optional>*music_style;


@property(nonatomic,copy)NSString <Optional>*title;
@property(nonatomic,copy)NSString <Optional>*subtitle;
@end
