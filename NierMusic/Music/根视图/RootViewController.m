//
//  RootViewController.m
//  Music
//
//  Created by ljl on 17/3/29.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "RootViewController.h"
#import "SandianView.h"
@interface RootViewController ()<UIScrollViewDelegate>
{

    UIImageView *view2;
    UIImageView *view;
    NSTimer *time;
    
//    UISwipeGestureRecognizer *Rightswipe1;
    

}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
}
-(BOOL)prefersStatusBarHidden{
    
    
    return YES;
    
    
    
    
}




-(void)addBarBtnItemWithTitle:(NSString *)title withImageName:(NSString *)imageName withPosition:(NSInteger)position
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
      if (title.length>0) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    if (imageName.length>0) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
    }
//    UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if (position==LEFT_BARITEM) {
        
        btn.frame = CGRectMake(0, 10, 44, 44);
        
        [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
//        self.navigationItem.leftBarButtonItem =BarItme;
    }else{
        btn.frame = CGRectMake(self.view.frame.size.width-60, 22, 50, 25);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"BtnBackgroundImg_Nornal@2x"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
    
}
-(void)leftClick
{
}
-(void)rightClick
{
    
}





//    NSArray *ar = @[@"interview@2x",@"singelRecommend@2x",@"goodmorningSong@2x",@"carefullSel@2x"];
//    NSArray *titlear = @[@"首页精选",@"编辑推荐",@"独家访谈",@"早晚安曲"];
//    UIView *view22 = [[SandianView alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 150) andImageviewArray:ar andtitleName:titlear];
//    [self.view addSubview:view22];
//    
//    
//    
//    
//    
//    view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 200)];
//    view.backgroundColor = [UIColor whiteColor];
//    view.userInteractionEnabled = YES;
//    view.image = [UIImage imageNamed:@"110.jpg"];
//    [self.view addSubview:view];
//    
//    
//    
//    
//    //点击手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//    //设置点击的次数
//    tap.numberOfTapsRequired =1;
//    //手指的点击数
//    tap.numberOfTouchesRequired=1;
//    //给视图添加手势.下面这个党费是UIview的方法
//    [view addGestureRecognizer:tap];
//    
//    UISwipeGestureRecognizer *Rightswipe1 =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
//    //设置手势监听的方向lift左,right右,up上,down下
//    Rightswipe1.direction = UISwipeGestureRecognizerDirectionRight;
//    //设置手势血药的手指数
//    Rightswipe1.numberOfTouchesRequired =1;
//    [view addGestureRecognizer:Rightswipe1];
//    view.tag = 100;
//    //左手势
//    UISwipeGestureRecognizer *LeftSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
//    LeftSwipe1.direction = UISwipeGestureRecognizerDirectionLeft;
//    [view addGestureRecognizer:LeftSwipe1];
//    
//    time = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timeon) userInfo:nil repeats:YES];
//    
//    
//    
//    
//  view2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 200)];
//    view2.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:view2];
//    view2.userInteractionEnabled = YES;
//    view2.image = [UIImage imageNamed:@"115.jpg"];
//    //这个是清扫手势,一个手势只能监听一个方向
//    UISwipeGestureRecognizer *Rightswipe =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
////    //设置手势监听的方向lift左,right右,up上,down下
//    Rightswipe.direction = UISwipeGestureRecognizerDirectionRight;
////    //设置手势血药的手指数
//    Rightswipe.numberOfTouchesRequired =1;
//    [view2 addGestureRecognizer:Rightswipe];
//    view2.tag=101;
//    //左手势
//    UISwipeGestureRecognizer *LeftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
//    LeftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
//    [view2 addGestureRecognizer:LeftSwipe];
//    
//    
//    
//    
//    //点击手势
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//    //设置点击的次数
//    tap1.numberOfTapsRequired =1;
//    //手指的点击数
//    tap1.numberOfTouchesRequired=1;
//    //给视图添加手势.下面这个党费是UIview的方法
//    [view2 addGestureRecognizer:tap1];
//    
//    
//    
//    
//    
//    
//    view.alpha=0;
//    view2.alpha=1;
//    
//    
////    self.view.backgroundColor = [UIColor redColor];
//    // Do any additional setup after loading the view.
//}
//
//




//-(void)timeon{
//
//    
//    [UIView animateWithDuration:2.0 animations:^{
//        
//        view.alpha=!view.alpha;
//        view2.alpha=!view2.alpha;
//        
//        
//        
//        //           _imageView.center =CGPointMake(0, _imageView.center.y);
////        view2.alpha=!view2.alpha;
////        view.alpha=!view.alpha;
//    }];
//    
//    
//    
//    
//    
////    view.alpha=!view.alpha;
////    view2.alpha=!view2.alpha;
////    [UIView animateWithDuration:0.8 animations:^{
//////        _scrView.contentOffset =CGPointMake(_scrView.contentOffset.x+WITDH, 0);
////        
////        
////        
////    } completion:^(BOOL finished) {
//////        [self scrollViewDidEndDecelerating:_scrView];
////    }];
//
//    NSLog(@"file");
//
//}
//
//
//
//
//
//
//
//-(void)swipeGeture:(UISwipeGestureRecognizer *)swipe
//{
//    
//    //如果认为的停止动画,或者认为的停止的动画,就要在调用一下动画的方法
//    [time invalidate];
//    
//    CGFloat f = swipe.direction;
//    NSLog(@"%f",f);
//    if (swipe.direction==UISwipeGestureRecognizerDirectionRight) {
////        _imageView.alpha =0.1;
//        
//        
//     [UIView animateWithDuration:2 animations:^{
////           _imageView.center =CGPointMake(320, _imageView.center.y);
////          view2.alpha =0.1;
//             view2.alpha =!view2.alpha;
//            view.alpha=!view.alpha;
////             view.alpha =1;
//            
//          
//            
//        
//     }];
//        NSLog(@"右面是帅哥,不能去");
//    }else if (swipe.direction==UISwipeGestureRecognizerDirectionLeft)
//    {
////        _imageView.alpha=1;
//        NSLog(@"左面是墙,不能去");
//       [UIView animateWithDuration:2 animations:^{
//        
////           _imageView.center =CGPointMake(0, _imageView.center.y);
//            view2.alpha=!view2.alpha;
//            view.alpha=!view.alpha;
//       }];
//        
//        
//    }
//    
//    time = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timeon) userInfo:nil repeats:YES];
//    
// 
//    
//    
//    
//    
//}
//
//-(void)tapGesture:(UITapGestureRecognizer *)tap
//{
//    NSInteger tag = tap.view.tag-100;
//    if (tag==0) {
//        NSLog(@"点的是1");
//    }else{
//    
//        NSLog(@"点的是2");
//    
//    }
//    
//    NSLog(@"我是单击手势");
//    
//    
//    
//}
//




//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    CGFloat index = scrollView.center.x/100;
//    
//       CGFloat offset=scrollView.contentOffset.x;
//    NSLog(@"%f",offset);
//    if (offset<100) {
//        NSLog(@"zuo");
//        
//        
//    }else{
//    
//        NSLog(@"you");
//    
//    }
//    
//    //如果认为的停止动画,或者认为的停止的动画,就要在调用一下动画的方法
//    [_timer invalidate];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timeOn) userInfo:nil repeats:NO];
//    
//    
//    if (scrollView.contentOffset.x==2*WITDH) {
//        scrollView.contentOffset =CGPointMake(WITDH, 0);
//        //       _leftView.frame= CGRectMake(0, 0, self.frame.size.width, HTGHT);
//        _contindex= (_contindex+1)%_DataArray.count;
//        model = _DataArray[(_contindex-1+_DataArray.count)%_DataArray.count];
//        [_leftView sd_setImageWithURL:[NSURL URLWithString:model.vthumburl]];
//        
//        model=_DataArray[_contindex];
//        [_centerView sd_setImageWithURL:[NSURL URLWithString:model.vthumburl]];
//        
//        
//        model = _DataArray[(_contindex+1)%_DataArray.count];
//        [_rigView sd_setImageWithURL:[NSURL URLWithString:model.vthumburl]];
//        
//    }else if (scrollView.contentOffset.x==0){
//        scrollView.contentOffset = CGPointMake(WITDH, 0);
//        
//        _contindex =(_contindex-1+_DataArray.count)%_DataArray.count;
//        
//        model=_DataArray[(_contindex-1+_DataArray.count)%_DataArray.count];
//        [_leftView sd_setImageWithURL:[NSURL URLWithString:model.vthumburl]];
//        
//        model = _DataArray[_contindex];
//        [_centerView sd_setImageWithURL:[NSURL URLWithString:model.vthumburl]];
//        
//        model =_DataArray[(_contindex+1)%_DataArray.count];
//        [_rigView sd_setImageWithURL:[NSURL URLWithString:model.vthumburl]];
//    }
//    
//    
//    
//    _pageC.currentPage = _contindex;
//    
    
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
