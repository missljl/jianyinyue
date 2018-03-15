//
//  Fourviews.m
//  Music
//
//  Created by ljl on 17/4/14.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "Fourviews.h"

@implementation Fourviews
{

    NSString *str;
    NSString *imName;
    NSInteger tag1;

}

-(id)initWithFrame:(CGRect)frame creatrViewlabelTitle:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag
{
    
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        str=title;
        imName=imageName;
        tag1=tag;
        [self cnfigUI];
    }
    
    return self;
}

-(void)cnfigUI{


//    UIView *view = [[UIView alloc]initWithFrame:frame];
//    view.userInteractionEnabled = YES;
//    view.tag =tag;
    
    _iamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height-20)];
    _iamgeview.userInteractionEnabled = YES;
    _iamgeview.image = [UIImage imageNamed:imName];
    
    _iamgeview.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_iamgeview];
    
    
    
    
    
    
    
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, _iamgeview.frame.size.width, 19)];
    label.text = str;
    label.userInteractionEnabled = YES;
    label.textColor = [UIColor blueColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];





}

@end
