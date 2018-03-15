//
//  HeadView.m
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "HeadView.h"
#import "UIImageView+WebCache.h"


@interface HeadView ()

@property(nonatomic,copy)NSArray *DataArray;
@property(nonatomic,strong)UIImageView *Twoview;
@property(nonatomic,strong)UIImageView *OneView;
@property(nonatomic,strong)NSTimer *time;
@property(nonatomic,strong) Toubtns *view1;
@property(nonatomic,strong)UIPageControl *page;
@property(nonatomic,assign)NSInteger indexpage;


@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGPoint startVB;
@property (assign, nonatomic) CGFloat startVideoRate;
@end


@implementation HeadView



-(id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
;
        self.userInteractionEnabled = YES;
        _DataArray =array ;
            [self configUI];
    }
    return self;
}
-(void)configUI{


  
        
        for (NSInteger i=0; i<_DataArray.count; i++) {
            
            if (i==0||i==1) {
                
            
            SouYeToumode *model =[[SouYeToumode alloc]init];
               
               model =_DataArray[i];

            
            _view1 = [[Toubtns alloc]initWithFrame:CGRectMake(0*i, 0*i, self.frame.size.width, self.frame.size.height-15)];
                
        _view1.userInteractionEnabled = YES;
           _view1.touchDelegate = self;
          
            _view1.tag = 100+i;

              NSString *str= [NSString stringWithFormat:@"%@",model.image];
         [_view1 sd_setImageWithURL:[NSURL URLWithString:str]];
           
            [self addSubview:_view1];
        
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            [_view1 addGestureRecognizer:tap];
            }else{
            
            
            }
        
        }
    
    _Twoview = [self viewWithTag:101];
    _Twoview.alpha = 0;
    _Twoview.userInteractionEnabled=YES;
    
    
    

    
 _time = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timeOn) userInfo:nil repeats:YES];

  
    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2-5, _view1.frame.size.height,10, 15)];
    _page.numberOfPages = 2;
    _page.currentPage = 0;
    [self addSubview:self.page];
    _page.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    _page.currentPageIndicatorTintColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
    
}
-(void)dealloc{
[_time invalidate];
    _time=nil;

}

-(void)timeOn
{
    
    
    [UIView animateWithDuration:1.0 animations:^{
    
        _Twoview.alpha= !_Twoview.alpha;
        _indexpage = !_indexpage;
          _page.currentPage = _indexpage;
    } completion:^(BOOL finished) {
       
    }];
    
    
}





-(void)tap:(UITapGestureRecognizer *)tap{
    
    
    
    if (tap.view.tag==100) {
   
       SouYeToumode *model =_DataArray[tap.view.tag-100];
       
        [self.delegate headViewsid:model];
//        NSLog(@"111model%@",model);
        
    }if (tap.view.tag==101) {
        

       
       SouYeToumode *model =_DataArray[tap.view.tag-100];
//         NSLog(@"22222model%@",model); 
     
      [self.delegate headViewsid:model];
  
    
    }



}


- (void)touchesBeganWithPoint:(CGPoint)point {
    //记录首次触摸坐标
    self.startPoint = point;
    //检测用户是触摸屏幕的左边还是右边，以此判断用户是要调节音量还是亮度，左边是亮度，右边是音量
}

#pragma mark - 拖动
- (void)touchesMoveWithPoint:(CGPoint)point {
    
    
    [_time invalidate];
    
    
    //关闭定时器
//    [_time setFireDate:[NSDate distantFuture]];
    
    //得出手指在Button上移动的距离
    CGPoint panPoint = CGPointMake(point.x - self.startPoint.x, point.y - self.startPoint.y);
    
   
//    NSLog(@"滑动距离%f",panPoint.x/100);
    
    self.view1.alpha = panPoint.x/200;

   
   
    _time = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(timeOn) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_time forMode:NSRunLoopCommonModes];
  
    [[NSRunLoop currentRunLoop] run];
 
    
       //此方法是默认将time加入到主线程的runloop当中
//      NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timeOn) userInfo:nil repeats:YES];
//    
//    _time = [NSTimer timerWithTimeInterval:4.0 target:self selector:@selector(timeOn) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop]addTimer:_time forMode:NSRunLoopCommonModes];
////        [_time fire];
//       [[NSRunLoop currentRunLoop] run];
////    });

    
//    [[NSRunLoop mainRunLoop]addTimer:_time forMode:NSRunLoopCommonModes];
//    [_time fire];
    
//    
    //开启定时器
//  [_time setFireDate:[NSDate distantPast]];
   
   }

#pragma mark - 结束触摸
- (void)touchesEndWithPoint:(CGPoint)point {
    
    
    
    _indexpage = !_indexpage;
    _page.currentPage = _indexpage;
    

    
    
    
    //    if (self.direction == DirectionLeftOrRight) {
    //        [self.player seekToTime:CMTimeMakeWithSeconds(self.showTime * currentRate, 1) completionHandler:^(BOOL finished) {
    //            //            //在这里处理进度设置成功后的事情
    //        }];
    //    }
}










@end
