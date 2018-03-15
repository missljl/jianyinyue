//
//  WenzhangManager.m
//  Music
//
//  Created by ljl on 17/4/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "WenzhangManager.h"
#import "FMDatabase.h"
@implementation WenzhangManager
{
    FMDatabase *_fmdb;
}
+(id)manager
{
    static WenzhangManager *_m = nil;
    if (!_m) {
        _m = [[WenzhangManager alloc]init];
    }
    return _m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //path:指数据库文件的位置
        NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"musicwenzhang223568.db"];
        //        NSLog(@"path%@",path);
        _fmdb = [[FMDatabase alloc]initWithPath:path];
        
        //打开数据库
        //如果这个数据库不存在,则先创建,再打开
        //如果已经存在,直接打开供后面使用
        BOOL success = [_fmdb open];
        if (success) {
            //如果打开成功,创建数据库表
            NSString *sql = @"create table if not exists app(applicationid varchar(32),wenzhangming,wenzhangzuozhe,tuimage,tag1,link)";
            if(![_fmdb executeUpdate:sql])
            {
                NSLog(@"创建数据失败");
            }
        }
    }
    return self;
}
-(void)addModel:(WenzhangModel *)model{
    
    NSString *sql = @"insert into app (applicationid,wenzhangming,wenzhangzuozhe,tuimage,tag1,link) values (?,?,?,?,?,?)";
    BOOL success = [_fmdb executeUpdate:sql,model.wemzhangid,model.wenzhangtitle,model.wenzhangzuozhe,model.tuimage,model.tag1,model.link];
    if (success) {
        //        NSLog(@"收藏成功");
    }
    
    
    
    
}
-(void)deleteModel:(WenzhangModel *)model
{
    NSString *sql = @"delete from app where applicationid=?";
    [_fmdb executeUpdate:sql,model.wemzhangid];
}
-(NSMutableArray *)allModels
{
    NSMutableArray *resArr = [[NSMutableArray alloc]init];
    
    NSString *sql = @"select * from app";
    FMResultSet *result = [_fmdb executeQuery:sql];
    while ([result next]) {
        NSString *appid = [result stringForColumn:@"applicationid"];
        NSString *name = [result stringForColumn:@"wenzhangming"];
        NSString *iconurl = [result stringForColumn:@"wenzhangzuozhe"];
        NSString *tuimage =[result stringForColumn:@"tuimage"];
          NSString *tage1 =[result stringForColumn:@"tag1"];
         NSString *link = [result stringForColumn:@"link"];
        WenzhangModel *model = [[WenzhangModel alloc]init];
        model.wemzhangid = appid;
        model.wenzhangtitle = name;
        model.wenzhangzuozhe = iconurl;
        model.tuimage=tuimage;
        model.tag1=tage1;
        model.link=link;
               [resArr addObject:model];
    }
    
    return resArr;
}

-(BOOL)isExists:(id)model
{
    NSString *appid;
    if ([model isKindOfClass:[WenzhangModel class]]) {
        appid = [(WenzhangModel *)model wemzhangid];
    }
    else
    {
        appid = model;
    }
    NSString *sql = @"select * from app where applicationid=?";
    FMResultSet *result = [_fmdb executeQuery:sql,appid];
    return [result next];
}


@end
