//
//  SouYeModel.h
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "JSONModel.h"


@protocol ItmeModel

@end
@interface ItmeModel : JSONModel

@property(nonatomic,copy) NSString<Optional>*songname;

@property(nonatomic,copy) NSString<Optional>*songphoto;
@property(nonatomic,copy) NSString<Optional>*songer;
@property(nonatomic,copy) NSString<Optional>*thumbnail_url;
@property(nonatomic,copy) NSString<Optional>*filename;
@property(nonatomic,copy) NSString<Optional>*filename192;
@property(nonatomic,copy) NSString<Optional>*filename320;
@property(nonatomic,copy) NSString<Optional>*ida;
@end


@interface SouYeModel : JSONModel



@property(nonatomic,copy)NSString <Optional>*aid;
@property(nonatomic,copy)NSString <Optional>*description1;
@property(nonatomic,copy)NSString <Optional>*title1;

@property(nonatomic,copy)NSString <Optional>*cover_url;
@property(nonatomic,copy)NSString <Optional>*editor;
@property(nonatomic,copy)NSString<Optional>*musicode;
@property(nonatomic,copy)NSString<Optional>*songname;
@property(nonatomic,copy)NSString<Optional>*track_id;
@property(nonatomic,copy)NSString<Optional>*playcount;
@property(nonatomic,copy)NSString<Optional>*view_count;


@property(nonatomic,copy)NSString<Optional>*img;
@property(nonatomic,copy)NSString<Optional>*forurl;
@property(nonatomic,copy)NSString<Optional>*category_name;
@property(nonatomic,copy)NSString<Optional>*member_name;

@property(nonatomic,copy)NSString<Optional>*date;






@property(nonatomic,copy) NSString <Optional>*field2;
@property(nonatomic,copy) NSString <Optional>*mname;
@property(nonatomic,copy) NSString <Optional>*mphoto;
@property(nonatomic,copy) NSString <Optional>*mdesc;
@property(nonatomic,copy) NSString <Optional>*mnum;
@property(nonatomic,copy) NSString <Optional>*play_count;
@property(nonatomic,strong) NSArray <ItmeModel,Optional> *tracks;







@end
