//
//  XQheadmodel.h
//  Music
//
//  Created by 1111 on 2017/6/16.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface XQheadmodel : JSONModel

@property(nonatomic,copy)NSString <Optional>*filename;
@property(nonatomic,copy)NSString <Optional>*filename192;
@property(nonatomic,copy)NSString <Optional>*filename320;

@property(nonatomic,copy)NSString <Optional>*thumbnail_url;
@property(nonatomic,copy)NSString <Optional>*songphoto;
@property(nonatomic,copy)NSString<Optional>*songer;
@property(nonatomic,copy)NSString<Optional>*songname;



@end
