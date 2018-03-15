//
//  SouCangManager.m
//  Music
//
//  Created by ljl on 17/4/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "SouCangManager.h"
#import "FMDatabase.h"
@implementation SouCangManager
{
    FMDatabase *_fmdb;
}
+(id)manager
{
    static SouCangManager *_m = nil;
    if (!_m) {
        _m = [[SouCangManager alloc]init];
    }
    return _m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //path:指数据库文件的位置
        NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"musicSouCang22.db"];
        //        NSLog(@"path%@",path);
        _fmdb = [[FMDatabase alloc]initWithPath:path];
        
        //打开数据库
        //如果这个数据库不存在,则先创建,再打开
        //如果已经存在,直接打开供后面使用
        BOOL success = [_fmdb open];
        if (success) {
            //如果打开成功,创建数据库表
            NSString *sql = @"create table if not exists app(applicationid varchar(32),genName,genshouName,genImage,genUrl)";
            if(![_fmdb executeUpdate:sql])
            {
                NSLog(@"创建数据失败");
            }
        }
    }
    return self;
}
-(void)addModel:(SoucangModel *)model{

    NSString *sql = @"insert into app (applicationid,genName,genshouName,genImage,genUrl) values (?,?,?,?,?)";
    BOOL success = [_fmdb executeUpdate:sql,model.genid,model.genming,model.genshou,model.imageName,model.genUrl];
    if (success) {
        //        NSLog(@"收藏成功");
    }




}
-(void)deleteModel:(SoucangModel *)model
{
    NSString *sql = @"delete from app where applicationid=?";
    [_fmdb executeUpdate:sql,model.genid];
}
-(NSMutableArray *)allModels
{
    NSMutableArray *resArr = [[NSMutableArray alloc]init];
    
    NSString *sql = @"select * from app";
    FMResultSet *result = [_fmdb executeQuery:sql];
    while ([result next]) {
        NSString *appid = [result stringForColumn:@"applicationid"];
        NSString *name = [result stringForColumn:@"genName"];
        NSString *iconurl = [result stringForColumn:@"genshouName"];
        NSString *video = [result stringForColumn:@"genImage"];
        NSString *year = [result stringForColumn:@"genUrl"];
        
        SoucangModel *model = [[SoucangModel alloc]init];
        model.genid = appid;
        model.genming = name;
        model.genshou = iconurl;
        model.imageName = video;
        model.genUrl = year;
        [resArr addObject:model];
    }
    
    return resArr;
}

-(BOOL)isExists:(id)model
{
    NSString *appid;
    if ([model isKindOfClass:[SoucangModel class]]) {
        appid = [(SoucangModel *)model genming];
    }
    else
    {
        appid = model;
    }
    NSString *sql = @"select * from app where genName=?";
    FMResultSet *result = [_fmdb executeQuery:sql,appid];
    return [result next];
}




@end
