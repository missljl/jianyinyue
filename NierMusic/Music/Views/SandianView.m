//
//  SandianView.m
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//
#define KWS(weakSelf) __weak __typeof(&*self) weakSelf=self

#import "SandianView.h"
#import "GongJuLei.h"



#import "Fourviews.h"
@interface SandianView()

@property(nonatomic,copy)NSArray *imageNamear;
@property(nonatomic,copy)NSArray *titleNar;
@property(nonatomic,strong)UIView *xianview;
@property(nonatomic,strong)UIView *view;
@end



@implementation SandianView


-(id)initWithFrame:(CGRect)frame andImageviewArray:(NSArray *)imagenamerarr andtitleName:(NSArray *)titleArray{


    if (self=[super initWithFrame:frame]) {
        self.imageNamear = imagenamerarr;
        self.titleNar = titleArray;
        self.userInteractionEnabled = YES;
        [self configUI];
    }
    return self;

}
-(void)configUI

{
    
    CGFloat width = 100;
    CGFloat height = 139;
    CGFloat spaceX = ((self.frame.size.width-100-3*width)/3.0);//x之间间隔;
//    CGFloat spaceY = (300-2*height)/2.0;//y间隔
    
    
    for (NSInteger i=0; i<_imageNamear.count; i++) {
        
//        _view = [[Fourviews alloc]initWithFrame:CGRectMake((0+(width+spaceX)*i),0, width, height) creatrViewlabelTitle:_titleNar[i] imageName:_imageNamear[i] tag:100+i];
        
       _view = [GongJuLei creatrViewlabelTitle:_titleNar[i] imageName:_imageNamear[i] tag:100+i frame:CGRectMake((0+(width+spaceX)*i),0, width, height)];
        _view.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_view addGestureRecognizer:tap];
        
        [self addSubview:_view];
     
    
                }
    _xianview = [[UIView alloc]initWithFrame:CGRectMake(20,109 , 60, 2)];
    _xianview.backgroundColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
    [self addSubview:_xianview];
    

}

-(void)tap:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag-100;
    
//    NSLog(@"%ld",index);
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeBlockcolor" object:nil userInfo:@{@"tag":@"0",@"tag":@"1",@"tag":@"2",@"tag":@"3"}];
//
 CGFloat spaceX = ((self.frame.size.width-100-3*100)/3.0);//x之间间隔;
//    [UIView animateWithDuration:0.18 animations:^{
//       
//            _xianview.center =CGPointMake(0+(100+spaceX)*index, _xianview.center.y);
//        
//    }];
//
    
    switch (index) {
        case 0:{
            
//            CGFloat spaceX = ((self.frame.size.width-100-3*100)/3.0);//x之间间隔;
            [UIView animateWithDuration:0.18 animations:^{
                
                _xianview.frame = CGRectMake(20, 109, 60, 2);
                
            }];
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeBlockcolor" object:nil userInfo:@{@"tag":@"0"}];
        }
            break;
        case 1:{
            
            [UIView animateWithDuration:0.18 animations:^{
                _xianview.frame = CGRectMake((115+spaceX)*index, 109, 60, 2);

//              _xianview.center =CGPointMake((_view.frame.size.width+spaceX), _xianview.center.y);
                
            }];
            
 
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeBlockcolor" object:nil userInfo:@{@"tag":@"1"}];}
            break;
        case 2:{
            
            
            [UIView animateWithDuration:0.18 animations:^{
                 _xianview.frame = CGRectMake((110+spaceX)*index, 109, 60, 2);
//                _xianview.center =CGPointMake(_view.iamgeview.center.x, _xianview.center.y);
                
            }];
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeBlockcolor" object:nil userInfo:@{@"tag":@"2"}];}
            break;
        case 3:{
            
            [UIView animateWithDuration:0.18 animations:^{
                 _xianview.frame = CGRectMake((105+spaceX)*index, 109, 60, 2);
//                _xianview.center =CGPointMake(_view.iamgeview.center.x, _xianview.center.y);
                
            }];
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeBlockcolor" object:nil userInfo:@{@"tag":@"3"}];}
            break;
            default:
            break;
    }
   
    
    
}
@end
