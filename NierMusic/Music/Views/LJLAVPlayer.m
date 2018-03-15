//
//  LJLAVPlayer.m
//  Music
//
//  Created by ljl on 17/4/6.
//  Copyright © 2017年 李金龙. All rights reserved.
//


#define DUO_SONGFIELDS @"ID%2CSN%2CUID%2CSK%2CSC%2CSCSR%2CM"

#define DUO_URL @"http://mobileapi.5sing.kugou.com/song/newget?songid=%@&songtype=%@&songfields=%@&version=6.5.20"

#import "LJLAVPlayer.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "HttpManager.h"
#import "AFNetworking.h"
#import "AvplayModel.h"
@interface LJLAVPlayer()

@property(nonatomic,weak)AVPlayerItem *songItem;
@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,weak)AVPlayerLayer *palylayer;
//@property(nonatomic,retain)UIImageView *playerImage;//player的背景图片
@property(nonatomic,copy)NSArray *songArr;//歌曲的数组
@property(nonatomic,copy)NSArray *imageArr;//图片的数组
@property(nonatomic,assign)NSInteger tapCount;//点击次数
@property(nonatomic,retain)id timeObserver;//时间观察
@property(nonatomic,strong)NSMutableArray *imar;

//分享要用到的属性
@property(nonatomic,copy)NSString *imagestr;
@property(nonatomic,copy)NSString *idstring;
@property(nonatomic,copy)NSString *sking;
@end




@implementation LJLAVPlayer
{

    NSString *urlstr;
    
//    AvplayModel *model;

}


-(instancetype)initWithFrame:(CGRect)frame andSongUrlArr:(NSArray *)urlArr andSongImageArr:(NSArray *)imageArr;
{
    self=[super initWithFrame:frame];
    if (self) {
        
        
//        NSLog(@"播放器已经创建完毕这边时将要加载歌曲链接");
        _imar =[NSMutableArray array];
        _tapCount=0;
       _songArr=urlArr;
        _imageArr=imageArr;

        NSString *urlStr=urlArr[0];
        
        if ([urlStr rangeOfString:@"mp3"].location!=NSNotFound) {
            urlstr = urlStr;
            NSURL *url=[NSURL URLWithString:urlStr];
            //初始化songItem和player
            AVPlayerItem *item =[AVPlayerItem playerItemWithURL:url];
            //       _songItem=[[AVPlayerItem alloc]initWithURL:url];
            self.songItem=item;
            //        _player=[AVPlayer playerWithPlayerItem:_songItem];
            [self.player replaceCurrentItemWithPlayerItem:self.songItem];
//            NSLog(@"正在创建播放对象");
            if ([[UIDevice currentDevice]systemVersion].intValue>=10) {
                
                self.player.automaticallyWaitsToMinimizeStalling=NO;
                
            }
            
            [self.player play];
            
            //添加播放器状态的监听
            [self addAVPlayerStatusObserver];
            //添加数据缓存的监听
            [self addNetDataStatusObserver];
            //player的背景图片
            [self plarerImage];

            
            NSString *imagestr=[NSString stringWithFormat:@"%@",imageArr[0]];
            _imagestr = imagestr;
            if (imagestr.length<=30) {
                self.playerImage.image=[UIImage imageNamed:@"CMComment_MusicInfoPanel_songCoverImage"];
            }else{
                
                NSURL *imageUrl=[NSURL URLWithString:imagestr];
                [self.playerImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"CMComment_MusicInfoPanel_songCoverImage"]];
            }

            [self addSubview:self.playerImage];
//            NSLog(@"播放器已经要都准备好了");
            
        }else{
        
            [self duoggequdata];
            
//        这边摇解析
        
//            NSLog(@"yaojie");
        }
        
        
        

   
}
    
  return self;
}
//初始状态
-(void)duoggequdata{

    NSString *duostr =_songArr[_tapCount];
    NSString *duoidstr =_imageArr[_tapCount];
    
    NSString *url =[NSString stringWithFormat:DUO_URL,duostr,duoidstr,DUO_SONGFIELDS];
    HttpManager *manger =[HttpManager shareManager];
    [manger requestWithUrl:url withDictionary:nil withSuccessBlock:^(id responseObject) {
//      NSLog(@"%@",responseObject);
       
        NSDictionary *dic =responseObject[@"data"];
        
   AvplayModel   *model =[[AvplayModel alloc]initWithDictionary:dic error:nil];
        
        _idstring = model.ID;
        _sking = model.SK;
        [_imar addObject:model.user[@"I"]];
        [self duoshouUI:model];
    } withFailureBlock:^(NSError *error) {
        
        
        
        
        
    }];
    
    
    
    
    
    




}
//下一首歌曲解析
-(void)xiayishouData{


    NSString *duostr =_songArr[_tapCount];
    NSString *duoidstr =_imageArr[_tapCount];
    
    NSString *url =[NSString stringWithFormat:DUO_URL,duostr,duoidstr,DUO_SONGFIELDS];
    HttpManager *manger =[HttpManager shareManager];
    [manger requestWithUrl:url withDictionary:nil withSuccessBlock:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
        
        NSDictionary *dic =responseObject[@"data"];
        
        AvplayModel   *model =[[AvplayModel alloc]initWithDictionary:dic error:nil];
        [_imar addObject:model.user[@"I"]];
        [self playerWithItem:model];
//        [self duoshouUI:model];
    } withFailureBlock:^(NSError *error) {
        
        
        
    }];
    
    
    


}



-(void)duoshouUI:(AvplayModel *)model{


    
    if (model.KL.length<1) {
        
        urlstr =[NSString stringWithFormat:@"%@",model.KLM];
        
//        NSURL *url=[NSURL URLWithString:model.KLM];
        
    } else {
      urlstr =[NSString stringWithFormat:@"%@",model.KL];
    }
    NSURL *url=[NSURL URLWithString:urlstr];
    
//    NSLog(@"%@",url);
    //初始化songItem和player
    AVPlayerItem *item =[AVPlayerItem playerItemWithURL:url];
    //       _songItem=[[AVPlayerItem alloc]initWithURL:url];
    self.songItem=item;
    //        _player=[AVPlayer playerWithPlayerItem:_songItem];
    [self.player replaceCurrentItemWithPlayerItem:self.songItem];
    if ([[UIDevice currentDevice]systemVersion].intValue>=10) {
        
        self.player.automaticallyWaitsToMinimizeStalling=NO;
        
    }
    
    
    [self.player play];
    //        [self.player setVolume:1.0];
    //声音设置为0.5;
    //        _volume=5;
    //添加播放器状态的监听
    [self addAVPlayerStatusObserver];
    //添加数据缓存的监听
    [self addNetDataStatusObserver];
    //player的背景图片
    [self plarerImage];
    
    
    NSString *imagestr=[NSString stringWithFormat:@"%@",model.user[@"I"]];
    _imagestr = imagestr;
    if (imagestr.length<=30) {
        self.playerImage.image=[UIImage imageNamed:@"CMComment_MusicInfoPanel_songCoverImage"];
    }else{
        
        NSURL *imageUrl=[NSURL URLWithString:imagestr];
        [self.playerImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"CMComment_MusicInfoPanel_songCoverImage"]];
    }
    
    self.palylayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.playerImage.layer addSublayer:self.palylayer];
    [self addSubview:self.playerImage];






}


- (AVPlayer *)player
{
    if (!_player) {
        
//        NSLog(@"来加载播放器");
        // 初始化Player和Layer
        _player = [[AVPlayer alloc] init];
//        _player.volume=15.0;
        
    }
    return _player;
}



-(void)plarerImage{

 _playerImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

}


#pragma mark---开始播放
-(void)startPlay
{
    
        [_player play];
 }

  
#pragma mark---暂停播放
-(void)puasePlay
{
    [_player pause];
    
    
}
#pragma mark----播放下一首
-(void)nextSong
{
    
    if (_songArr.count<2) {
        [self removeAllNotice];
        _tapCount--;
        if (_tapCount<0) {
            _tapCount=_songArr.count-1;
            
        }
        [self.delegate getshangyishouge:_tapCount];
        NSURL *url=[NSURL URLWithString:_songArr[0]];
        
        AVPlayerItem *item =[[AVPlayerItem alloc]initWithURL:url];
        
        
        self.songItem=item;
        
        [self.player replaceCurrentItemWithPlayerItem:self.songItem];
        
        //添加播放器状态的监听
        [self addAVPlayerStatusObserver];
        //    //添加数据缓存的监听
        [self addNetDataStatusObserver];
        
        if ([[UIDevice currentDevice]systemVersion].intValue>=10) {
            
            self.player.automaticallyWaitsToMinimizeStalling=NO;
            
        }
        
        
        
        [self.player play];
        _imagestr = _imageArr[0];
        NSURL *imageUrl=[NSURL URLWithString:_imageArr[0]];
        [self.playerImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"CMComment_MusicInfoPanel_songCoverImage@2x"]];
        
    }else{
    
    
    
    
    [_player pause];
    //移除所有监听
   [self removeAllNotice];
    _tapCount++;
    if (_tapCount>=_songArr.count) {
        _tapCount=0;
      
    }
//    NSLog(@"1");
   [self.delegate getshangyishouge:_tapCount];
        [self xiayishouData];
    
    }

//    NSLog(@"当前播放第%ld首歌",_tapCount);
    //替换songItem
//    [self playerWithItem];
    //添加播放器状态的监听
//    [self addAVPlayerStatusObserver];
    //添加数据缓存的监听
//    [self addNetDataStatusObserver];

}
#pragma mark---播放上一首
-(void)lastSong
{
    
    
    
    if (_songArr.count<2) {
        [self removeAllNotice];
        _tapCount--;
        if (_tapCount<0) {
            _tapCount=_songArr.count-1;
            
        }
        [self.delegate getshangyishouge:_tapCount];
        NSURL *url=[NSURL URLWithString:_songArr[0]];
        
        AVPlayerItem *item =[[AVPlayerItem alloc]initWithURL:url];
        
        
        self.songItem=item;
        
        [self.player replaceCurrentItemWithPlayerItem:self.songItem];
        
        //添加播放器状态的监听
        [self addAVPlayerStatusObserver];
        //    //添加数据缓存的监听
        [self addNetDataStatusObserver];
        
        if ([[UIDevice currentDevice]systemVersion].intValue>=10) {
            
            self.player.automaticallyWaitsToMinimizeStalling=NO;
            
        }
        
        
        [self.player play];
        
        
        _imagestr = _imageArr[0];
        NSURL *imageUrl=[NSURL URLWithString:_imageArr[0]];
        [self.playerImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"CMComment_MusicInfoPanel_songCoverImage@2x"]];
        
    }else{
    
    
//    NSLog(@"0");
    //移除所有监听
    [_player pause];
   [self removeAllNotice];
    _tapCount--;
    if (_tapCount<0) {
        _tapCount=_songArr.count-1;
      
    }
   [self.delegate getshangyishouge:_tapCount];
        [self xiayishouData];
    
    }
//    NSLog(@"当前播放第%ld首歌",_tapCount);
    //替换songItem
//[self playerWithItem];
    //添加播放器状态的监听
//   [self addAVPlayerStatusObserver];
////    //添加数据缓存的监听
//  [self addNetDataStatusObserver];


}
#pragma mark---根据点击次数切换songItem
-(void)playerWithItem:(AvplayModel *)model
{
//    [self.player pause];
//     [self removeAllNotice];
    
    
    if (model.KL.length<1) {
        
        urlstr =[NSString stringWithFormat:@"%@",model.KLM];
        
        //        NSURL *url=[NSURL URLWithString:model.KLM];
        
    }else{
        urlstr =[NSString stringWithFormat:@"%@",model.KL];
    }
    
//    NSLog(@"%@",urlstr);
//    NSString *urlStr=model.KL;
    
    
    NSURL *url=[NSURL URLWithString:urlstr];

    AVPlayerItem *item =[[AVPlayerItem alloc]initWithURL:url];
    
    

    self.songItem=item;
    
    [self.player replaceCurrentItemWithPlayerItem:self.songItem];
    
    //添加播放器状态的监听
    [self addAVPlayerStatusObserver];
    //    //添加数据缓存的监听
    [self addNetDataStatusObserver];
    
    if ([[UIDevice currentDevice]systemVersion].intValue>=10) {
        
        self.player.automaticallyWaitsToMinimizeStalling=NO;
        
    }
    
    
    [self.player play];
    
    NSURL *imageUrl=[NSURL URLWithString:model.user[@"I"]];
    _imagestr = model.user[@"I"];
    [self.playerImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"CMComment_MusicInfoPanel_songCoverImage@2x"]];
    
    
    
    
//    //添加播放器状态的监听
//    [self addAVPlayerStatusObserver];
//    //    //添加数据缓存的监听
//    [self addNetDataStatusObserver];
    
 
    
    
    
}
#pragma mark----设置player的volume
-(void)setPlayerVolume
{
    self.player.volume=_volume;
   
}

#pragma mark----添加观察者获取当前时间,总共时间,进度
-(void)addTimeObserve
{
//    NSLog(@"播放器已经可以播放了我开始监听播放器播放时间");
    __block  AVPlayerItem *songItem=_songItem;
    __block typeof(self) bself = self;
    

//    }else{
    _timeObserver=[_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //设置player的声音
        [bself setPlayerVolume];
        
        //当前时间
        float current=CMTimeGetSeconds(time);
        
        _zongtime=songItem.duration;
        
        

        //总共时间
        float total=CMTimeGetSeconds(songItem.duration);
        //进度
        float progress=current/total;
        _jindu=progress;
        _cent=bself.tapCount;
    //        //将值传入知道delegate方法中
//        NSLog(@"已经监听玩播放器时间将要船只q");
        [bself.delegate getSongCurrentTime:CMTimeGetSeconds(time) andTotalTime:CMTimeGetSeconds(songItem.duration) andProgress:progress andTapCount:bself.tapCount];
        
//        NSLog(@"%%%%%%");
    }];
    
//    }
}
#pragma mark---移除时间观察者
-(void)removeTimeObserver
{
    if (_timeObserver) {
        [self.player removeTimeObserver:_timeObserver];
        _timeObserver=nil;
    }
}
#pragma mark---float转00:00类型
- (NSString *)formatTime:(float)num{
    
    int sec =(int)num%60;
    int min =(int)num/60;
    if (num < 60) {
        return [NSString stringWithFormat:@"00:%02d",(int)num];
    }
    return [NSString stringWithFormat:@"%02d:%02d",min,sec];
}
#pragma mark----监听播放器的加载状态
-(void)addAVPlayerStatusObserver
{
    [self.songItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark----数据缓冲状态的监听
-(void)addNetDataStatusObserver
{
    [self.songItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark----KVO方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
//    NSLog(@"正在坚挺播放器是否要播放通知");
    //播放器缓冲状态
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerItemStatusUnknown:{
//               NSLog(@"未知状态，此时不能播放");
                
            }
                break;
            case  AVPlayerItemStatusReadyToPlay:{
//                NSLog(@"播放器可以播放了将要添加时间坚挺");
//                NSLog(@"&&&&&&&&&&");
                    [self addTimeObserve];
//                    //添加播放完成的通知
                    [self addPlayToEndObserver];
                [self.delegate getavplayerurl:urlstr andimagestr:_imagestr andidstrng:_idstring andsk:_sking];
            
           }
                break;
            case  AVPlayerItemStatusFailed:{
//               NSLog(@"加载失败，网络或者服务器出现问题");
            }
                break;
            default:
                break;
        }
    }
    //数据缓冲状态
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        //缓冲时间的数组
        NSArray *array=_songItem.loadedTimeRanges;
        //本次缓冲的时间范围
       CMTimeRange timeRange=[array.firstObject CMTimeRangeValue];
       CGFloat totalBuffer=CMTimeGetSeconds(timeRange.start)+CMTimeGetSeconds(timeRange.duration);//缓冲总长度
       
        if (isnan(totalBuffer)) {
           
            NSLog(@"nan");
            
        }else{
        
        
            [self.delegate gethuangtiem:totalBuffer];
        
        }
//        NSLog(@"%f",d);
//     NSLog(@"%f",totalBuffer);
//        CMTime duration11 = self.player.currentItem.duration;
//        CGFloat totalDuration = CMTimeGetSeconds(duration11);
//        NSLog(@"总时长>>>>%f",totalDuration);
//        NSLog(@"百分比%f",totalBuffer/totalDuration);
    }
}
#pragma mark---移除媒体加载状态的监听
-(void)removeAVPlayerObserver
{
    [self.songItem removeObserver:self forKeyPath:@"status"];
}
#pragma mark---移除数据加载状态的监听
-(void)removeNetDataObserver
{
    [self.songItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
#pragma mark----播放完成后发送通知
-(void)addPlayToEndObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.songItem];
//    NSLog(@"________");
}
#pragma mark---通知的方法
-(void)playFinished:(NSNotification *)notice
{
//   NSLog(@"播放完成，自动进入下一首");
    //播放下一首
    [self nextSong];
}
#pragma mark----移除通知
-(void)removePlayToEndNotice
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark-----移除所有监听
-(void)removeAllNotice
{
    //移除时间进度的监听
    [self removeTimeObserver];
    //移除播放完成的通知
    [self removePlayToEndNotice];
    //移除播放器状态的监听
    [self removeAVPlayerObserver];
    //移除数据缓存的监听
    [self removeNetDataObserver];
}









@end
