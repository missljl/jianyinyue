//
//  SouYeModel.m
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "SouYeModel.h"



@implementation ItmeModel


+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ida"}];
}

@end



@implementation SouYeModel

//+(JSONKeyMapper *)keyMapper{
//    
//    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"id":@"aid",@"title":@"title1",@"description":@"description1",@"url":@"forurl"}];
//    
//}

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"aid",@"title":@"title1",@"description":@"description1",@"url":@"forurl"}];
}



@end
