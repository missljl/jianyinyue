//
//  XiaViewController.m
//  Music
//
//  Created by ljl on 17/4/4.
//  Copyright © 2017年 李金龙. All rights reserved.
//
//下面按钮点击跳出
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define RATE SCREEN_WIDTH/320.0

#import "XiaViewController.h"
#import "XiaTouView.h"
#import "LJLAVPlayer.h"
#import "SoucangModel.h"
#import "SouCangManager.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPMediaItem.h>
#import "UIImageView+WebCache.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "CircularProgressBar.h"



@interface XiaViewController ()<SZKAVPlayerDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong)XiaTouView *zhongjianview;
@property(nonatomic,strong)UISwipeGestureRecognizer *LeftSwipe;
@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)UIImageView *bckimageivew;
@property(nonatomic,strong)UILabel *geminglable;
@property(nonatomic,strong)UILabel *geshoulable;
@property(nonatomic,strong)UILabel *leixinglable;
@property(nonatomic,strong)UILabel *timelable;

//@property(nonatomic,copy)NSArray *songArr;//歌曲数组
//@property(nonatomic,copy)NSArray *songNameArr;//歌曲名称数组
//@property(nonatomic,copy)NSArray *songAuthorArr;//歌曲演唱者数组
//@property(nonatomic,copy)NSArray *songImageArr;//歌曲图片数组

@property(nonatomic,strong)LJLAVPlayer *player;
@property(nonatomic,retain)UIButton *playBt;//播放\暂停按钮

@property(nonatomic,retain)UIButton *lastBt;//上一首按钮
@property(nonatomic,retain)UIButton *nextBt;//下一首按钮
@property(nonatomic,retain)UIImageView *imageveiw;

@property(nonatomic ,retain)UIView *downView;


@property(nonatomic,retain)UIButton *shanchubtn;
@property(nonatomic,retain)UIButton *sharbtn;


@property(nonatomic,assign)NSInteger dijishouIndex;



@property(nonatomic,assign)BOOL isshar;
@property(nonatomic,strong)SoucangModel *soucangmodel;



@property(nonatomic,strong)MBProgressHUD *hud;


@property(nonatomic,assign)NSInteger dd;
//分享用刀的播放器船只肤质给这写属性
@property(nonatomic,copy)NSString *urlstring;
@property(nonatomic,copy)NSString *titiiamgestr;
@property(nonatomic,copy)NSString *idstfing;
@property(nonatomic,copy)NSString *sktring;



@property(nonatomic,copy)NSString *dangqiantimestr;
@property(nonatomic,copy)NSString *zongshijiantiem;

@property(nonatomic,assign)CGFloat playzongtime;
@property(nonatomic,assign)CGFloat playdangtime;
@property(nonatomic,strong)UIProgressView *prolsview;

//@property(nonatomic,strong)UIView *topview;
//@property(nonatomic,strong)UIImageView *bgview;

@end

@implementation XiaViewController
{

    CGFloat dangtime;
    CGFloat zongtime;
    CircularProgressBar *m_cirview;

}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    
    
    

    
    [self topbtns];
    //添加歌曲的信息
   [self addSongInformation];
   [self xiangqingtognzhi];
    //添加播放器的控件
    _dd=1;
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(beginReceivingRemoteControlEvents)]){
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [self becomeFirstResponder];
    }
    
    
}
#pragma mark---歌曲名称数组

#pragma mark---添加playerView
-(void)addPlayerViewandSongUrlArr:(NSArray *)urlarr andSongImageArr:(NSArray *)imagear
{
    
//    NSLog(@"搜夜已经穿万只播放器将要创建");
    
    
    //梦层效果
//    
//    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effe.alpha = 0.5;
//    effe.frame = CGRectMake(0, 49, self.view.frame.size.width, self.view.frame.size.height);
//    effe.userInteractionEnabled = YES;
//    

    [self.player puasePlay];
    self.player=nil;

        self.player=[[LJLAVPlayer alloc]initWithFrame:CGRectMake(0,49, WIDTH, WIDTH) andSongUrlArr:[urlarr copy] andSongImageArr:[imagear copy]];
  
 
    

    
    
    

    self.player.delegate=self;
//    NSLog(@"%@",self.player);
   self.player.volume=5;
   
    
    //    这个是清扫手势,一个手势只能监听一个方向
    UISwipeGestureRecognizer *left =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
    //设置手势监听的方向lift左,right右,up上,down下
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    //设置手势血药的手指数
    left.numberOfTouchesRequired =1;
    [self.player addGestureRecognizer:left];
    
    //左手势
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    [self.player addGestureRecognizer:right];
    
//    NSLog(<#NSString * _Nonnull format, ...#>);
    
//    NSLog(@"dddddd");
     _dijishouIndex=0;
    _geminglable.text=self.songNameArr1[_dijishouIndex];
    //歌曲演唱者
    _geshoulable.text=self.songAuthorArr1[_dijishouIndex];
    _zhongjianview.geminglable.text = _geminglable.text;
    _zhongjianview.geshoulable.text = _geshoulable.text;
    
//    [self configPlayingInfo];
    
    _soucangmodel = [[SoucangModel alloc]init];
    
    _soucangmodel.genming = [NSString stringWithFormat:@"%@",_geminglable.text];
    
    _isshar = [[SouCangManager manager]isExists:_soucangmodel.genming];
    [_sharbtn setImage:[UIImage imageNamed:_isshar?@"xuanzhong":@"meixuan"] forState:UIControlStateNormal];

 [self.view addSubview:self.player];
    
  [self addPlayerControls];

    
    
    
    //    [self configPlayingInfo];
  
    
 
   
    
}
#pragma mark----SZKAVPlayerDelegate代理方法


-(void)getSongCurrentTime:(CGFloat)currentTime andTotalTime:(CGFloat)totalTime andProgress:(CGFloat)progress andTapCount:(NSInteger)tapCount
{
//    进度条
    
//    NSLog(@"播放器的船只已经拿到播放界面");
//    [_progressView setProgress:progress];
    //歌曲时间
    NSString *cutime=[self formatTime:currentTime];
    NSString *totaltime =[self formatTime:totalTime];
    zongtime=currentTime;
    dangtime=totalTime;
    _timelable.text=[NSString stringWithFormat:@"%@/%@",cutime,totaltime];
    //歌曲名称
    _dangqiantimestr=cutime;
    _zongshijiantiem=totaltime;
//    NSLog(@"播放器的船只已经肤质完毕");
    m_cirview.time_left =currentTime;
  
    if (totaltime>0&&currentTime) {
        
        [m_cirview setTotalSecondTime:dangtime];
       
        [m_cirview startTimer];
       
    }
    
   [self configPlayingInfo];


   
 }
-(void)gethuangtiem:(CGFloat)huangchon{

   m_cirview.huangchong=huangchon;

}
//-(void)CircularProgressEnd{
//
////    NSLog(@"进度条代理");
//}


- (NSString *)formatTime:(float)num{
    
    int sec =(int)num%60;
    int min =(int)num/60;
    if (num < 60) {
        return [NSString stringWithFormat:@"00:%02d",(int)num];
    }
    return [NSString stringWithFormat:@"%02d:%02d",min,sec];
}
//播放代理
-(void)getshangyishouge:(NSInteger)shu{

     _dijishouIndex=shu;
  
    self.geminglable.text=self.songNameArr1[_dijishouIndex];
    //歌曲演唱者
    self.geshoulable.text=self.songAuthorArr1[_dijishouIndex];
    self.zhongjianview.geminglable.text = _geminglable.text;
    self.zhongjianview.geshoulable.text = _geshoulable.text;
    
    
//   [self configPlayingInfo];
  [self configPlayingInfo];
    
    _soucangmodel = [[SoucangModel alloc]init];
    
    _soucangmodel.genming = [NSString stringWithFormat:@"%@",_geminglable.text];
    
    _isshar = [[SouCangManager manager]isExists:_soucangmodel.genming];
    [_sharbtn setImage:[UIImage imageNamed:_isshar?@"xuanzhong":@"meixuan"] forState:UIControlStateNormal];
    
    

}
#pragma makr---添加歌曲的信息
-(void)addSongInformation
{
    
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, WIDTH, self.view.frame.size.width, self.view.frame.size.height-WIDTH)];
//    _downView.backgroundColor = [UIColor whiteColor];
    _downView.userInteractionEnabled = YES;
    [self.view addSubview:_downView];
    
    
    //歌曲名称
    _geminglable=[[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH+90, WIDTH, 40)];
    _geminglable.text=self.songNameArr1[0];
    _geminglable.textColor = [UIColor blackColor];
//    _geminglable.font = [UIFont systemFontOfSize:17];
        [_geminglable setFont:[UIFont fontWithName:@"Helvetica" size:18.0]];
    _geminglable.textAlignment=NSTextAlignmentCenter;
    
    [self.view addSubview:_geminglable];
    //歌曲作者
    _geshoulable=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_geminglable.frame)-18, WIDTH, 40)];
    _geshoulable.text=self.songAuthorArr1[0];
     _geshoulable.textColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
    _geshoulable.textAlignment=NSTextAlignmentCenter;
      [_geshoulable setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:13.0]];
//    _geshoulable.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_geshoulable];
    //歌曲的时间
    _timelable=[[UILabel alloc]initWithFrame:CGRectMake(0, WIDTH+120+_geshoulable.frame.size.height, WIDTH, 40)];
    _timelable.textAlignment=NSTextAlignmentCenter;
    _timelable.text=@"00:00/00:00";
    _timelable.font = [UIFont systemFontOfSize:12];
    _timelable.textColor =[UIColor lightGrayColor];
    [self.view addSubview:_timelable];
    
    
  
   
    
    
    
    _shanchubtn = [[UIButton alloc]initWithFrame:CGRectMake(30, _downView.frame.size.height-20, 40, 40)];
    [_shanchubtn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_CMTransceiverBottomPanel_unlikeBtn_nornal@2x"] forState:UIControlStateNormal];

    [_shanchubtn addTarget:self action:@selector(shanchubtn:) forControlEvents:UIControlEventTouchUpInside];
        [_downView addSubview:_shanchubtn];
    
    
    _sharbtn = [[UIButton alloc]initWithFrame:CGRectMake(_downView.frame.size.width-70, _downView.frame.size.height-20, 40, 40)];
    
//    [_sharbtn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_CMTransceiverBottomPanel_likeBtn_nornal@2x"] forState:UIControlStateNormal];
   
    [_sharbtn addTarget:self action:@selector(sharbtn:) forControlEvents:UIControlEventTouchUpInside];
     [_downView addSubview:_sharbtn];
    
    
    
    UIButton *fenbtn =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-20,_downView.frame.size.height-20, 40, 40)];
    
    [fenbtn setImage:[UIImage imageNamed:@"shareBtn@2x"] forState:UIControlStateNormal];
    [fenbtn addTarget:self action:@selector(fenben:) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:fenbtn];
//    NSLog(@"%f",_shanchubtn.frame.origin.x+_shanchubtn.frame.size.width);
//    CGFloat witd =_shanchubtn.frame.origin.x+_shanchubtn.frame.size.width;
  
    
//    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(_downView.frame.size.width/2-11, _downView.frame.size.height-15, 22, 22)];
//    [btn setImage:[UIImage imageNamed:@"playlist1"] forState:UIControlStateNormal];
//    
//    [btn addTarget:self action:@selector(suitbn) forControlEvents:UIControlEventTouchUpInside];
//    
//    [_downView addSubview:btn];
    
  
    
    
    
    
    
    
    
    
    
}
-(void)getavplayerurl:(NSString *)urlstring andimagestr:(NSString *)imagestr andidstrng:(NSString *)idstring andsk:(NSString *)string{

//    NSLog(@"%@++++++%@",urlstring,imagestr);
    _urlstring =urlstring;
    _titiiamgestr =imagestr;
    _idstfing = idstring;
    _sktring = string;
    
}

//http://wawa.fm/webview/music.html?id=23700&share=1&from=singlemessage&isappinstalled=1

-(void)fenben:(UIButton*)btn{

    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//         [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx7be8d736b4f1182c" appSecret:@"22eb288fa407e1805ae1b78e5e5ddcf8" redirectURL:nil];
//        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine  appKey:@"wx7be8d736b4f1182c" appSecret:@"22eb288fa407e1805ae1b78e5e5ddcf8" redirectURL:nil];
//        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatFavorite  appKey:@"wx7be8d736b4f1182c" appSecret:@"22eb288fa407e1805ae1b78e5e5ddcf8" redirectURL:nil];
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建音乐内容对象self.geminglable.text,self.geshoulable.text
        UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:[NSString stringWithFormat:@"【简音悦】%@",self.geminglable.text] descr:[NSString stringWithFormat:@"【简音悦】%@",self.geshoulable.text] thumImage:[UIImage imageNamed:@"fenxiang"]];
        //设置音乐网页播放地址
       NSString *palyersongstring = _songArr1[_dijishouIndex];
       if (palyersongstring.length<15) {
//            
//            
           shareObject.musicUrl = [NSString stringWithFormat:@"http://5sing.kugou.com/m/Song/Detail/%@/%@?from=singlemessage&isappinstalled=1",_sktring,_idstfing];
//
       }else{
//        
//        
       shareObject.musicUrl = [NSString stringWithFormat:@"http://wawa.fm/webview/music.html?id=%@&share=1&from=singlemessage&isappinstalled=1",_trok_idarray[_dijishouIndex]];
        }
        //点击歌曲链接(放夜听下载链接)
//     shareObject.musicUrl = @"https://itunes.apple.com/cn/app/%E5%A4%9C%E5%90%AC-%E6%95%85%E4%BA%8B%E6%B1%87-%E9%82%82%E9%80%85%E6%AF%8F%E4%B8%80%E4%B8%AA%E6%95%85%E4%BA%8B/id1260351154?mt=8";
//        歌曲链接
//        shareObject.musicDataUrl = @"http://audio.xmcdn.com/group18/M03/CB/B9/wKgJKllsOSLDpajUADsw8KrTdSo483.mp3";
             shareObject.musicDataUrl = _urlstring;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        
        
//        
//        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//        NSString* thumbURL = _titiiamgestr;
//       UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"【简音悦】%@",self.geminglable.text ] descr:[NSString stringWithFormat:@"【简音悦】%@",self.geshoulable.text ] thumImage:thumbURL];
////       shareObject.musicUrl = @"http://wawa.fm";
////        shareObject.musicDataUrl =_urlstring;
//        shareObject.webpageUrl = @"http://wawa.fm";
//        //分享消息对象设置分享内容对象
//        messageObject.shareObject = shareObject;
        
        
//        
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];

        
        
        
        
        
        // 根据获取的platformType确定所选平台进行下一步操作
    }];
//UMShareMusicObject *shaobject = [UMShareMusicObject sha]
    
   
    
    
    
}


-(void)suitbn{

    
    


}
-(void)shanchubtn:(UIButton *)btn{

    
  _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    _hud.mode = MBProgressHUDModeText;
    _hud.label.text = @"这首歌成功从播放列表里删除";
    _hud.label.font = [UIFont systemFontOfSize:13];
    
    _hud.label.textColor = [UIColor lightGrayColor];
    
    _hud.bezelView.color = [UIColor whiteColor];
    _hud.delegate = self;
    
    [_hud hideAnimated:YES afterDelay:1.5];
    
  

}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    
    [hud removeFromSuperview];
    
    if (_songArr1.count==1) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _hud.mode = MBProgressHUDModeText;
        _hud.label.text = @"播放队列里面只有这一首歌,无法删除";
        _hud.label.font = [UIFont systemFontOfSize:13];
        
        _hud.label.textColor = [UIColor lightGrayColor];
        
        _hud.bezelView.color = [UIColor whiteColor];
//        _hud.delegate = self;
        
        [_hud hideAnimated:YES afterDelay:1.5];
  
        
        
        
    }else{
    
        [self.player lastSong];
    }
}

-(void)sharbtn:(UIButton*)btn{


    if (_isshar) {
        //收藏
     
//        NSLog(@"^^^^^^");
        [[SouCangManager manager]deleteModel:_soucangmodel];
//        [_sharbtn setImage:[UIImage imageNamed:@"meixuan"] forState:UIControlStateNormal];

    }else {
       
        _soucangmodel = [[SoucangModel alloc]init];
        _soucangmodel.genming = _songNameArr1[_dijishouIndex];
        _soucangmodel.genshou = _songAuthorArr1[_dijishouIndex];
        _soucangmodel.imageName = _songImageArr1[_dijishouIndex];
        _soucangmodel.genUrl =_songArr1[_dijishouIndex];
        _soucangmodel.genid =[NSString stringWithFormat:@"%ld",(long)_dijishouIndex];
    
        [[SouCangManager manager]addModel:_soucangmodel];
        //开始播放

    
    }
  
    
    _isshar=!_isshar;
       [_sharbtn setImage:[UIImage imageNamed:_isshar?@"xuanzhong":@"meixuan"] forState:UIControlStateNormal];
    

    //抖动效果
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;

    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_sharbtn.layer addAnimation:animation forKey:nil];



}

#pragma mark---添加播放器的播放，下一首，上一首按钮控件
-(void)addPlayerControls
{
    
    m_cirview =[[CircularProgressBar alloc]initWithFrame:CGRectMake(114*RATE, WIDTH+2.2, 100*RATE, 100)];
//    m_cirview.delegate =self;
   
    [self.view addSubview:m_cirview];
 
    
//    //进度条
//    _progressView=[[UIProgressView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_songTime.frame)+20, WIDTH, 10)];
//    [self.view addSubview:_progressView];
    //播放\暂停按钮
  _playBt=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, WIDTH+20, 60, 60)];
    
   _playBt.center = CGPointMake(CGRectGetWidth(m_cirview.frame)/2, CGRectGetHeight(m_cirview.frame)/2);
    
    
    [_playBt setBackgroundImage:[UIImage imageNamed:@"CMGeneTransceiverVC_pauseBtn@2x.png"] forState:UIControlStateNormal];
    [_playBt addTarget:self action:@selector(playBtClick:) forControlEvents:UIControlEventTouchUpInside];
  [m_cirview addSubview:_playBt];
    
//    m_cirview =[[CircularProgressBar alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-27, WIDTH+17, 62, 62)];
//    m_cirview.delegate =self;
//    [self.view addSubview:m_cirview];
    
    
    
  }
#pragma mark---播放暂停按钮点击
-(void)playBtClick:(UIButton *)sender
{
    if (sender.selected==NO) {
            [_player puasePlay];
        _dd=0;
        [_playBt setBackgroundImage:[UIImage imageNamed:@"CMGeneTransceiverVC_playBtn@2x"] forState:UIControlStateNormal];
        sender.selected=YES;
        
        
    }else if(sender.selected==YES){
        
//          [[NSNotificationCenter defaultCenter]postNotificationName:@"xiazhanting" object:nil userInfo:@{@"tag":@"0"}];
        //开始播放
        [self.player startPlay];
        _dd=1;
        [_playBt setBackgroundImage:[UIImage imageNamed:@"CMGeneTransceiverVC_pauseBtn@2x.png"] forState:UIControlStateNormal];
        sender.selected=NO;
        }
    //抖动效果
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_playBt.layer addAnimation:animation forKey:nil];
    
  
    
    
    
    
    
}
#pragma mark---上一首按钮点击
-(void)lastBtClick
{
    //暂停
    [self.player puasePlay];
    //上一首
    [self.player lastSong];
    //改变播放按钮的图片
    _playBt.selected=NO;
   
  [self configPlayingInfo];
    
    
}
#pragma mark----下一首按钮点击
-(void)nextBtClick
{
    
   
    //暂停
    [self.player puasePlay];
    //下一首
    [self.player nextSong];
    //改变播放按钮的图片
//    [_playBt setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    _playBt.selected=NO;
   [self configPlayingInfo];
    
    
}
/////////////////////////////////3个按钮点击事件和清扫手势
-(void)topbtns{

    
//    _topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
//    _topview.userInteractionEnabled = YES;
   self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_topview];
    
   _btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 11, 26, 26)];
    [_btn setImage:[UIImage imageNamed:@"homeVC_TransceiverPlayBar_DNAButton"] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(leftbtn) forControlEvents:UIControlEventTouchUpInside];
    self.leftbtn=_btn;
    [self.view addSubview:_btn];
    


    _zhongjianview = [[XiaTouView alloc]initWithFrame:CGRectMake(40, 0,self.view.frame.size.width-100, 49)];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhongjiantap)];
    [_zhongjianview addGestureRecognizer:tap];
    
    [self.view addSubview:self.zhongjianview];
    
    
    
    
    UIButton *rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-45, 11, 26, 26)];
    [rightbtn setImage:[UIImage imageNamed:@"homeVC_TransceiverPlayBar_SettingButton@2x"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightbtn) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightbtn];
    
    
    
    
    //    这个是清扫手势,一个手势只能监听一个方向
    UISwipeGestureRecognizer *RightsUp =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
    //设置手势监听的方向lift左,right右,up上,down下
    RightsUp.direction = UISwipeGestureRecognizerDirectionUp;
    //设置手势血药的手指数
    RightsUp.numberOfTouchesRequired =1;
    [self.view addGestureRecognizer:RightsUp];
    
    //左手势
    _LeftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGeture:)];
    _LeftSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:_LeftSwipe];
    
    
    
    
    
    
    

}
-(void)zhongjiantap{

    
    
       [[NSNotificationCenter defaultCenter]postNotificationName:@"xiazhongjianbtn" object:nil userInfo:@{@"tag":@"0"}];
        
  



}
-(void)rightbtn{


 [[NSNotificationCenter defaultCenter]postNotificationName:@"rightbtn" object:nil userInfo:@{@"tag":@"0"}];


}


-(void)leftbtn{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"xialeftbtn" object:nil userInfo:@{@"tag":@"0"}];


}

-(void)swipeGeture:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction==UISwipeGestureRecognizerDirectionUp) {
        //        _imageView.alpha =0.1;
        [UIView animateWithDuration:0.5 animations:^{

        }];
       
    }else if (swipe.direction==UISwipeGestureRecognizerDirectionDown){
        

        
            [[NSNotificationCenter defaultCenter]postNotificationName:@"qingshao" object:nil userInfo:@{@"tag":@"1"}];

        
    }else if (swipe.direction ==UISwipeGestureRecognizerDirectionLeft){
       
        [self lastBtClick];
    
    }else if (swipe.direction==UISwipeGestureRecognizerDirectionRight){
        
        [self nextBtClick];
    
    
    
    
    }
}
-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"xiangqing" object:nil];
//     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"zaoxiangqing" object:nil];

}
///////有些歌不能播放所以要发出删除的通知
-(void)xiangqingtognzhi{

  
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xiangqing:) name:@"xiangqing" object:nil];
//       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zaoxiangqing:) name:@"zaoxiangqing" object:nil];
}
-(void)xiangqing:(NSNotification *)not{


    NSDictionary *dic= not.userInfo;
    
    NSInteger idex =[dic[@"tag"]integerValue];
    
         if (idex==0) {
//             NSLog(@"走了没");
              [self playBtClick:_playBt];
             
         }if (idex==1) {
             

             _playBt.selected=NO;
             [self playBtClick:_playBt];
             
         }
    
    
    
    

}




-(BOOL)prefersStatusBarHidden{

    return NO;


}

-(void)viewDidAppear:(BOOL)animated{


    [super viewDidAppear:animated];
    UIDevice *device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ( [device respondsToSelector:@selector(isMultitaskingSupported)] )
    {
        backgroundSupported = device.multitaskingSupported;
    }
    
    if ( backgroundSupported == YES )
    {
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        //注意这里，告诉系统已经准备好了
        [self becomeFirstResponder];
    }
    
    


}
-(BOOL)canBecomeFirstResponder{
    
    return YES;
    
}


-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    
//    NSLog(@"dddd");
    
    if(event.type==UIEventTypeRemoteControl){
        switch(event.subtype){
                
                
            case UIEventSubtypeRemoteControlPlay:
                
//              NSLog(@"11111");
            {  [self playBtClick:self.playBt];
//                [self.player startPlay];
               // 切换播放、暂停按钮
                break;}
                
            case UIEventSubtypeRemoteControlPreviousTrack:{
               
              [self lastBtClick];// 播放上一曲按钮
                break;}
                
            case UIEventSubtypeRemoteControlNextTrack:{
                
              [self nextBtClick];
            
//                [self.player nextSong];
                // 播放下一曲按钮
                break;}
                
            case UIEventSubtypeRemoteControlTogglePlayPause:{
//                NSLog(@"222");
                //暂停
//             [self.player puasePlay];
                
                                [self playBtClick:self.playBt];
                
            

                
                // 播放下一曲按钮
                break;
            }
            case UIEventSubtypeRemoteControlPause:{
//                [self.player lastSong];
                [self playBtClick:self.playBt];
          

            
                break;}
            default:
                break;
    
        }


}
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    
    return UIStatusBarStyleLightContent;
}

-(void)configPlayingInfo


{
   
  
    if
        (NSClassFromString(@"MPNowPlayingInfoCenter"))
    {
        
        NSMutableDictionary
        *
        dict
        =
        [[NSMutableDictionary
          alloc]
         init];
        
        
        
        [dict setObject:[NSNumber numberWithDouble:zongtime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        //
        //
        [dict setObject:[NSNumber numberWithDouble:dangtime] forKey:MPMediaItemPropertyPlaybackDuration];
        //
        //        //音乐当前已经播放时间
        
        
        [dict
         setObject:[NSString stringWithFormat:@"%@",self.geminglable.text]
         forKey:MPMediaItemPropertyTitle];
        
        
        [dict   setObject:self.geshoulable.text forKey:MPMediaItemPropertyArtist];
        
        
        
        [dict setObject:[NSNumber numberWithDouble:self.dd] forKey:MPNowPlayingInfoPropertyPlaybackRate];
        
        
        
        
       
        
        
        
        
//     NSString *im = [NSString stringWithFormat:@"%@",_songImageArr1[_dijishouIndex]];
//      
//        if (im.length>30) {
//        
//                 NSString *str = [NSString stringWithFormat:@"%@",_songImageArr1[_dijishouIndex]];
//        
//      
//                 UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
//         
//                 [dict
//                  setObject:[[MPMediaItemArtwork
//                              alloc]
//                             initWithImage:image]forKey:MPMediaItemPropertyArtwork];}
//        else{
        
//        UIImage *image = _player.playerImage.image;
        
        if (_player.playerImage.image !=nil) {
        [dict setObject:[[MPMediaItemArtwork alloc]initWithImage:_player.playerImage.image] forKey:MPMediaItemPropertyArtwork];
            
//       [dict setObject:[[MPMediaItemArtwork alloc]in] forKey:<#(nonnull id<NSCopying>)#>]
//            
        }else{
         [dict setObject:[[MPMediaItemArtwork alloc]initWithImage:[UIImage imageNamed:@"33"]] forKey:MPMediaItemPropertyArtwork];
        }
        
        
    [[MPNowPlayingInfoCenter defaultCenter]setNowPlayingInfo:dict];
        
//
//        [dict setObject:[[MPMediaItemArtwork alloc]initWithImage:_player.playerImage.image] forKey:MPMediaItemPropertyArtwork];
//        [dict setObject:[[MPMediaItemArtwork  alloc]initWithImage:[UIImage imageNamed:@"dd"] forKey:MPMediaItemPropertyArtwork]];
//        }
        
        
//        [dict setObject:[NSNumber numberWithDouble:_playdangtime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
//        //
//        //
//        [dict setObject:[NSNumber numberWithDouble:_playzongtime] forKey:MPMediaItemPropertyPlaybackDuration];
//        //
//        //        //音乐当前已经播放时间
//        [dict setObject:[NSNumber numberWithDouble:_dd] forKey:MPNowPlayingInfoPropertyPlaybackRate];
//        
        
        
        
        
        
        
        
        
////        [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_player.dangtiem)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
//        
//        
//       [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(_player.zongtime)] forKey:MPMediaItemPropertyPlaybackDuration];
//       
//        //音乐当前已经播放时间
//       [dict setObject:[NSNumber numberWithFloat:1] forKey:MPNowPlayingInfoPropertyPlaybackRate];
        
        
      
        
        
        
        
//        [[MPNowPlayingInfoCenter
//          defaultCenter]
//         setNowPlayingInfo:nil];
//        
        
        
        
//        [[MPNowPlayingInfoCenter
//          defaultCenter]
//         setNowPlayingInfo:dict];
//        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
    }
    
    
}









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
