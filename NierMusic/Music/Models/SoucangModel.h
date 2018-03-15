//
//  SoucangModel.h
//  Music
//
//  Created by ljl on 17/4/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface SoucangModel : JSONModel
@property(nonatomic,copy)NSString <Optional>*genming;
@property(nonatomic,copy)NSString <Optional>*genshou;
@property(nonatomic,copy)NSString <Optional>*imageName;

@property(nonatomic,copy)NSString <Optional>*genUrl;
@property(nonatomic,copy)NSString <Optional>*genid;
@end
