//
//  WenzhangModel.h
//  Music
//
//  Created by ljl on 17/4/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface WenzhangModel : JSONModel
@property(nonatomic,copy)NSString <Optional>*wenzhangtitle;
@property(nonatomic,copy)NSString <Optional>*wenzhangzuozhe;
@property(nonatomic,copy)NSString <Optional>*wemzhangid;
@property(nonatomic,copy)NSString <Optional>*tag1;
@property(nonatomic,copy)NSString <Optional>*tuimage;
@property(nonatomic,copy)NSString <Optional>*link;

@end
