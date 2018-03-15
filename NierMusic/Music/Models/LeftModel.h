//
//  LeftModel.h
//  Music
//
//  Created by ljl on 17/4/5.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface LeftModel : JSONModel


@property(nonatomic,copy)NSString <Optional>*created_at;
@property(nonatomic,copy)NSString <Optional>*geneId;
@property(nonatomic,copy)NSString <Optional>*geneName;

@property(nonatomic,copy)NSString <Optional>*updated_at;

@end
