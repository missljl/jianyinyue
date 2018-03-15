//
//  LJLAVPlayer.h
//  Music
//
//  Created by ljl on 17/4/6.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol SZKAVPlayerDelegate <NSObject>
/**

 *
 *  @param currentTime 当前时间
 *  @param totalTime   总共时间
 *  @param progress    歌曲进度
 *  @param tapCount    点击次数
 */
-(void)getSongCurrentTime:(CGFloat )currentTime andTotalTime:(CGFloat)totalTime andProgress:(CGFloat)progress andTapCount:(NSInteger)tapCount;

-(void)getshangyishouge:(NSInteger )shu;
-(void)gethuangtiem:(CGFloat)huangchon;
-(void)getavplayerurl:(NSString *)urlstring andimagestr:(NSString *)imagestr andidstrng:(NSString *)idstring andsk:(NSString *)string;

@end





@interface LJLAVPlayer : UIView


@property(nonatomic,retain)id<SZKAVPlayerDelegate>delegate;
/**
 *  volume 0.0~1.0
 */
@property(nonatomic,assign)CGFloat volume;

@property(nonatomic,assign)CMTime zongtime;
@property(nonatomic,assign)CMTime dangtiem;
@property(nonatomic,assign)CGFloat jindu;
@property(nonatomic,assign)NSInteger cent;
@property(nonatomic,strong)UIImageView  *playerImage;
@property(nonatomic,assign)CGFloat huanchong;

/**
 *
 *
 *  @param frame  AVPlayerLayer的frame
 *  @param urlArr 歌曲网址的数组
 *  @param urlArr 歌曲背景图片网址的数组
 *
 *  @return   SZKAVPlayer
 */
-(instancetype)initWithFrame:(CGRect)frame
               andSongUrlArr:(NSArray *)urlArr
             andSongImageArr:(NSArray *)imageArr;
/**
 *  开始播放
 */
-(void)startPlay;
/**
 *  暂停播放
 */
-(void)puasePlay;
/**
 *  播放下一首
 */
-(void)nextSong;
/**
 *  播放上一首
 */
-(void)lastSong;




@end
