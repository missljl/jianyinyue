//
//  ZaoanXIangqingViewController.m
//  Music
//
//  Created by ljl on 17/4/10.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "ZaoanXIangqingViewController.h"
#import "UIImageView+WebCache.h"
#import "HttpManager.h"
#import "XiangqingModel.h"
#import "XQModel.h"
#import "LJLAVPlayer.h"
//#import <MediaPlayer/MediaPlayer.h>
#import "MBProgressHUD.h"
#import "WenzhangModel.h"
#import "WenzhangManager.h"
@interface ZaoanXIangqingViewController ()<UITextViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIButton *leftbtn;
@property(nonatomic,strong)UIButton *rightbtn;
@property(nonatomic,strong)UITextView *textview;
@property(nonatomic,strong)UIImageView *headImageview;
@property(nonatomic,strong)UIButton *palyebtn;
@property(nonatomic,strong)XiangqingModel *model;
@property(nonatomic,strong)XQModel *model1;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)WenzhangModel *wenmodel;
@property(nonatomic,assign)BOOL iswenzhang;
//@property(nonatomic,strong)LJLAVPlayer *play;
@property(nonatomic,assign)NSInteger dd;
@property(nonatomic,assign)NSInteger ssss;

@property(nonatomic,strong)UIView *zhuangtianlanView;


@end

@implementation ZaoanXIangqingViewController
{

 NSInteger ifone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ifone=0;
    _ssss =5;
    [self confiUI];
    [self loadData];
    
    
    
    _wenmodel = [[WenzhangModel alloc]init];
    _wenmodel.wemzhangid=_zaovcid;
    _iswenzhang = [[WenzhangManager manager]isExists:_wenmodel.wemzhangid];
    [_rightbtn setImage:[UIImage imageNamed:_iswenzhang?@"CollectBtn_selected@2x":@"shareBtn@2x"] forState:UIControlStateNormal];
//
    
    
    
    
}
-(void)confiUI{

    
    _textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
 
    
    _textview.delegate =self;
   
    _textview.editable = NO;
    
    _textview.showsHorizontalScrollIndicator =NO;
    _textview.showsVerticalScrollIndicator =NO;
    [self.view addSubview:_textview];
    
    
    
    _dd=1;

    
    _leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 50, 50)];
    [_leftbtn setImage:[UIImage imageNamed:@"backBtn@2x"] forState:UIControlStateNormal];
    [_leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftbtn];
    
    _rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 20, 50, 50)];
//    [_rightbtn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_playBtn"] forState:UIControlStateNormal];
    [_rightbtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightbtn];
    
    _zhuangtianlanView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 22)];
    _zhuangtianlanView.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
    _zhuangtianlanView.alpha = 0;
    [self.view addSubview:_zhuangtianlanView];

}
-(void)loadData{
    
    NSString *strurl = [NSString stringWithFormat:@"http://r.chrrs.com/api/article/details?aid=%@",_zaovcid];
//
//[[HttpManager shareManager]requestWithUrl:strurl withDictionary:nil withSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//    
//  
//    
//    NSDictionary *data = responseObject[@"data"];
//    NSDictionary *artic = data[@"ArticleDetails"];
//    
//    _model = [[XiangqingModel alloc]initWithDictionary:artic error:nil];
//    [self DatacfingUI];
//    
//   
//} withFailureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//    
//}];
    

//[[HttpManager shareManager]requestWithUrl:strurl withDictionary:nil withSuccessBlock:^
//    (AFHTTPRequestSerializer *operation, id responseObject) {
//    
//        NSDictionary *data = responseObject[@"data"];
//        NSDictionary *artic = data[@"ArticleDetails"];
//        
//        _model = [[XiangqingModel alloc]initWithDictionary:artic error:nil];
//        [self DatacfingUI];
//   
//        
//        
//} withFailureBlock:^(AFHTTPRequestSerializer *operation, NSError *error) {
//    
//}];
    
    [[HttpManager shareManager]requestWithUrl:strurl withDictionary:nil withSuccessBlock:^(id responseObject) {
      
        
        NSDictionary *data = responseObject[@"data"];
        NSDictionary *artic = data[@"ArticleDetails"];
        
        _model = [[XiangqingModel alloc]initWithDictionary:artic error:nil];
        [self DatacfingUI];

        
        
    } withFailureBlock:^(NSError *error) {
        
    }];
    
    

}
-(void)DatacfingUI{
    NSString *str = [NSString stringWithFormat:@"\"%@\"",_model.title];
 NSString *ss = [NSString stringWithFormat:@"\n\r\n%@\n\n%@\n\n%@",str,_model.content,_model.author];

    NSMutableParagraphStyle *paragestryle = [[NSMutableParagraphStyle alloc]init];
    paragestryle.lineHeightMultiple = 20.f;
    paragestryle.maximumLineHeight = 20.f;
    paragestryle.minimumLineHeight = 20.f;
    
    
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 17;
    
    
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@2.2f};
    
    
    NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:ss attributes:attributes];
    
    [attri1 addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:18.0]
     
                   range:NSMakeRange(0, attri1.length)];
    
    
    
    [attri1 addAttribute:NSForegroundColorAttributeName
     
                   value:[UIColor lightGrayColor]
     
                   range:NSMakeRange(0, attri1.length)];
    [attri1 addAttribute:NSForegroundColorAttributeName
     
                   value:[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0]
     
                   range:NSMakeRange(3, _model.title.length+4)];

    
    //NSTextAttachment可以将要插入的图片作为特殊字符处理
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    
    
  
      NSString *urlstr = [NSString stringWithFormat:@"http://reflux.chrrs.com%@",_model.bgImg];
    
    
    attch.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstr]]];
    
    attch.bounds = CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.width/2+20);

    //创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
 
    
    [attri1 insertAttributedString:string atIndex:0];
    
    
    
    
    
//    _textview.bounces = NO;
    _textview.attributedText = attri1;
    _textview.textAlignment = NSTextAlignmentCenter;
    
//    
//  NSString  *musiclist= [_model.musicList stringByReplacingOccurrencesOfString:@"[" withString:@""];
//    musiclist = [musiclist stringByReplacingOccurrencesOfString:@"]" withString:@""];
//     NSString *zuistr= [musiclist stringByReplacingOccurrencesOfString:@"\"\"" withString:@""];
//    NSData *jsondata = [zuistr dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:nil];
    
//    _model1 = [[XQModel alloc]initWithDictionary:dic error:nil];
//  
//    NSMutableArray *ar = [NSMutableArray arrayWithObject:_model1.music_url];
//    NSMutableArray *ar1 = [NSMutableArray arrayWithObject:_model.coverImg];
//    _play = [[LJLAVPlayer alloc]initWithFrame:CGRectMake(10, 10, 10, 10) andSongUrlArr:ar andSongImageArr:ar1];
//    _play.hidden=YES;
//    _play.delegate =self;
//    _play.volume=4;
//        [_play puasePlay];
//    [self configPlayingInfo];
//    [self.view addSubview:_play];
   
    
}


-(void)leftClick{

    [self.navigationController popViewControllerAnimated:YES];
    [self.view removeFromSuperview];
//    [_play puasePlay];
//    [_play removeFromSuperview];
    
}
-(void)rightClick:(UIButton *)btn{

    
    
    
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.bezelView.color = [UIColor whiteColor];
    if (_iswenzhang) {
        [[WenzhangManager manager]deleteModel:_wenmodel];
        
        UIImageView *imagev = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qxsc"]];
        imagev.frame = CGRectMake(0, 0, 50, 50);
        _hud.customView = imagev;
        
        _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _hud.contentColor= [UIColor clearColor];
        _hud.bezelView.backgroundColor = [UIColor clearColor];
        [_hud hideAnimated:YES afterDelay:1];
        
    }else{
        _wenmodel = [[WenzhangModel alloc]init];
        _wenmodel.wemzhangid = _zaovcid;
        _wenmodel.wenzhangtitle =_model.title;
        _wenmodel.wenzhangzuozhe = _model.author;
        _wenmodel.tag1=[NSString stringWithFormat:@"%ld",(long)_ssss];
        NSLog(@"_wenmotag%@",_wenmodel.tag1);
        [[WenzhangManager manager]addModel:_wenmodel];
        
        _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sc"]];
        _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _hud.contentColor= [UIColor clearColor];
        _hud.bezelView.backgroundColor = [UIColor clearColor];
        [_hud hideAnimated:YES afterDelay:1];
        
        
        
    }
    _iswenzhang=!_iswenzhang;
    [_rightbtn setImage:[UIImage imageNamed:_iswenzhang?@"CollectBtn_selected@2x":@"shareBtn@2x"] forState:UIControlStateNormal];
   
    
    
    
    
    
    
    
//    if (btn.selected) {
//        ifone=1;
//        btn.selected = NO;
//        [btn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_playBtn"] forState:UIControlStateNormal];
//        [_play puasePlay];
//        _dd=0;
//        
//    }else{
//        
//        
//           if (_model1.music_url.length>30) {
//           [_play startPlay];
//            btn.selected = YES;
//               _dd=1;
//        [btn setImage:[UIImage imageNamed:@"CMGoodMorningSongVC_playBtn@2x"] forState:UIControlStateNormal];
//               //发通知给播放界面我要播放机歌曲了你暂停一下
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"zaoxiangqing" object:nil userInfo:@{@"tag":@"6"}];
//               
//        }else{
//            btn.selected = NO;
//            [btn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_playBtn"] forState:UIControlStateNormal];
//            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            _hud.mode = MBProgressHUDModeCustomView;
//            _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SongError"]];
//            _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//            _hud.contentColor= [UIColor clearColor];
//            _hud.bezelView.backgroundColor = [UIColor clearColor];
//            [_hud hideAnimated:YES afterDelay:1];
//            _dd=0;
//            [self loadData];
//           
//        }
    
       
        
        
//    }

    
//    //抖动效果
//    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.5;
//    
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    [btn.layer addAnimation:animation forKey:nil];
//    
//    



}


//-(void)dealloc{
//    // [[NSNotificationCenter defaultCenter]postNotificationName:@"xialeftbtn" object:nil userInfo:@{@"tag":@"0"}];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"xiazhangting" object:nil];
//    
//}
//-(void)xiatongzhi{
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xiatongzhi:) name:@"xiazhanting" object:nil];
//    
//    
//    
//}
////播放界面如果播放音乐了那么就停止播放本界面的歌曲
//-(void)xiatongzhi:(NSNotification *)not{
//    
//    
//    NSDictionary *dic= not.userInfo;
//    
//    NSInteger idex =[dic[@"tag"]integerValue];
//  
//    if (idex==0) {
//        
//        _rightbtn.selected = NO;
//        [_rightbtn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_playBtn"] forState:UIControlStateNormal];
//        [_play puasePlay];
//        
//        
//    }
//    
//}


-(BOOL)prefersStatusBarHidden{
    
    return NO;
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat yOffset  = scrollView.contentOffset.y;
//    
//    CGFloat xOffset = (yOffset +250)/2;
//    
//    //    NSLog(@"%f,%f",yOffset,xOffset);
//    if (yOffset < -280) {
//        
//        CGRect rect = _headImageview.frame;
//        rect.origin.y = yOffset;
//        rect.size.height =  -yOffset ;
//        rect.origin.x = xOffset;
//        rect.size.width = KScreen_Width + fabs(xOffset)*2;
//        
//        _headImageview.frame = rect;
//        
//        
//        
//        
//    }//
//    
//    
//    
//    
//    
//    
//    
//    
//    /////////////////////////////////////////
//    
//    CGFloat q = 280+yOffset;
//    CGFloat a=q/5;
//    CGFloat g=q/30;
//    CGRect frame1 = _palyView.frame;
//    frame1.origin.x=40-a;
//    frame1.size.width=self.view.frame.size.width-80+a*2;
//    frame1.origin.y=250-a*5;
//    frame1.size.height=70-g;
//    
//    CGFloat alpha = (yOffset+280)/280;
//    
//    
//    
//    CGRect playm = _palyView.playImageview.frame;
//    
//    UIColor *color= [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
//    
//    //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 49)];
//    //    view.backgroundColor = color;
//    //    view.alpha=0;
//    //    [_dujiaview addSubview:view];
//    //
//    //    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 0, 60, 49)];
//    //    view1.backgroundColor = color;
//    //    view1.alpha=0;
//    //    [_dujiaview addSubview:view1];
//    
//    
//    
//    if (_isdujia==1) {
//        CGFloat q = 280+yOffset;
//        CGFloat a=q/5;
//        CGFloat g=q/30;
//        CGRect frame1 = _dujiaview.frame;
//        frame1.origin.x=40-a;
//        frame1.size.width=self.view.frame.size.width-80+a*2;
//        frame1.origin.y=250-a*5;
//        frame1.size.height=70-g;
//        
//        if (frame1.origin.y<=22) {
//            
//            frame1.origin.y=22;
//            frame1.size.height=49;
//            frame1.size.width = self.view.frame.size.width;
//            frame1.origin.x=0;
//            
//            view.alpha=1;
//            view1.alpha=1;
//            
//        }else{
//            view.alpha=0;
//            view1.alpha=0;
//            
//            
//        }
//        
//        _dujiaview.frame = frame1;
//        
//        
//    }else{
//        
//        if (frame1.origin.y<=22) {
//            
//            
//            
//            frame1.origin.y=22;
//            frame1.size.height=49;
//            frame1.size.width = self.view.frame.size.width;
//            frame1.origin.x=0;
//            playm.size.height=49;
//            _palyView.playImageview.frame=playm;
//            
//            
//            
//        }else{
//            
//            playm.size.height =frame1.size.height;
//            _palyView.playImageview.frame=playm;
//            
//            
//        }
//        CGRect btnfeame = _palyView.palyebtn.frame;
//        
//        
//        if (yOffset<-280) {
//            
//            btnfeame.origin.x = _palyView.frame.size.width-60;
//            _palyView.palyebtn.frame = btnfeame;
//            
//        }else{
//            
//            
//            if (frame1.origin.y<=22) {
//                btnfeame.origin.x=self.view.frame.size.width-90;
//                btnfeame.origin.y = 11;
//                btnfeame.size.width =25;
//                btnfeame.size.height=25;
//            }else{
//                
//                
//                if (yOffset==-280) {
//                    
//                    btnfeame.origin.x=btnfeame.origin.x;
//                    
//                }else{
//                    btnfeame.size.width =25+(30*(1-alpha));
//                    btnfeame.size.height=25+(30*(1-alpha));
//                    
//                    btnfeame.origin.x =self.view.frame.size.width-80-(60*(1-alpha));
//                }
//            }
//            
//            _palyView.palyebtn.frame = btnfeame;
//            
//            
//        }
//        
//        
//        
//        
//        
//        _palyView.playImageview.backgroundColor = color;
//        _palyView.playImageview.alpha =1-alpha;
//        
//        
//        
//        _palyView.frame = frame1;
//    }
    
    CGFloat yOffset  = scrollView.contentOffset.y;
       CGFloat alpha = (yOffset+1)/1;
//    CGFloat alpha = yOffset;
    _zhuangtianlanView.alpha = alpha;
    
    
    
    
    
}




//-(void)viewDidAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication]beginReceivingRemoteControlEvents];
//    [self becomeFirstResponder];
//    
//    
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    
//    [super viewWillDisappear:animated];
//    
//    [[UIApplication sharedApplication]endReceivingRemoteControlEvents];
//    [self resignFirstResponder];
//    
//    
//}
//-(BOOL)canBecomeFirstResponder{
//    
//    return YES;
//    
//}
//
//
//-(void)remoteControlReceivedWithEvent:(UIEvent *)event
//{
//    if(event.type==UIEventTypeRemoteControl){
//        switch(event.subtype){
//                
//                
//            case UIEventSubtypeRemoteControlPlay:
//                [self rightClick:_rightbtn];
//                // 切换播放、暂停按钮
//                break;
//                
//            case UIEventSubtypeRemoteControlPreviousTrack:
//                
//                [_play lastSong];// 播放上一曲按钮
//                break;
//                
//            case UIEventSubtypeRemoteControlNextTrack:
//                
//                [_play nextSong];
//                
//                
//                // 播放下一曲按钮
//                break;
//                
//            case UIEventSubtypeRemoteControlTogglePlayPause:
//                
//                //暂停
//                //
//                [self rightClick:_rightbtn];
//                
//                
//                
//                
//                // 播放下一曲按钮
//                break;
//            case UIEventSubtypeRemoteControlPause:
//                
//                [self rightClick:_rightbtn];
//                
//                
//                break;
//            default:
//                break;
//                
//        }
//        
//        
//    }
//}
//
////-(UIStatusBarStyle)preferredStatusBarStyle {
////
////
////    return UIStatusBarStyleLightContent;
////}
//
//-(void)getSongCurrentTime:(CGFloat)currentTime andTotalTime:(CGFloat)totalTime andProgress:(CGFloat)progress andTapCount:(NSInteger)tapCount{
//    
//    
//    
//    NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithDictionary:[[MPNowPlayingInfoCenter defaultCenter]nowPlayingInfo]];
//    //        [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(bself.player.currentTime)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
//    
//    [dict1 setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
//    //
//    //
//    [dict1 setObject:[NSNumber numberWithDouble:totalTime] forKey:MPMediaItemPropertyPlaybackDuration];
//    //
//    //        //音乐当前已经播放时间
//
//    
//        [dict1
//         setObject:[NSString stringWithFormat:@"%@",_model1.song]
//         forKey:MPMediaItemPropertyTitle];
//    
//    
//        [dict1   setObject:_model1.singer forKey:MPMediaItemPropertyArtist];
//    
////    [dict1 setObject: forKey:MPMediaItemPropertyTitle];
////    
////    
////    [dict1   setObject:_palyView.geshoulable.text forKey:MPMediaItemPropertyArtist];
//  [dict1 setObject:[NSNumber numberWithDouble:_dd] forKey:MPNowPlayingInfoPropertyPlaybackRate];
////    
//    
//    
//    [[MPNowPlayingInfoCenter defaultCenter]setNowPlayingInfo:dict1];
//    
//    
//    
//    
//    
//}
//-(void)getshangyishouge:(NSInteger)shu{
//    
//    
//}
//
//-(void)configPlayingInfo
//
//
//{
//    
//    
//    if
//        (NSClassFromString(@"MPNowPlayingInfoCenter"))
//    {
//        
//        NSMutableDictionary
//        *
//        dict1
//        =
//        [[NSMutableDictionary
//          alloc]
//         init];
//        
//        
//        NSString *str = [NSString stringWithFormat:@"http://reflux.chrrs.com%@",_model.bgImg];
//        //        NSString *im = [NSString stringWithFormat:@"%@",_model.];
//        
//        if (str.length>30) {
//            
//            //            NSString *str1 = [NSString stringWithFormat:@"%@",str;
//            
//            
//            UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
//            
//            [dict1
//             setObject:[[MPMediaItemArtwork
//                         alloc]
//                        initWithImage:image]forKey:MPMediaItemPropertyArtwork];
//        }
//        else{
//            
//            [dict1
//             setObject:[[MPMediaItemArtwork
//                         alloc]
//                        initWithImage:[UIImage imageNamed:@"22.jpg"]]forKey:MPMediaItemPropertyArtwork];
//        }
//        
//        ////        [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_player.dangtiem)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
//        //
//        //
//        //       [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_player.zongtime)] forKey:MPMediaItemPropertyPlaybackDuration];
//        //
//        //        //音乐当前已经播放时间
//        //       [dict setObject:[NSNumber numberWithFloat:1] forKey:MPNowPlayingInfoPropertyPlaybackRate];
//        
//        
//        
//        
//        
//        
//        
//        [[MPNowPlayingInfoCenter
//          defaultCenter]
//         setNowPlayingInfo:nil];
//        
//        
//        
//        
//        [[MPNowPlayingInfoCenter
//          defaultCenter]
//         setNowPlayingInfo:dict1];
//        
//        
//    }
//    //
//    //    
//}
//
//





- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
}


@end
