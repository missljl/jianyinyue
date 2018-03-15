//
//  AppDelegate.m
//  Music
//
//  Created by ljl on 17/3/29.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

#import "YindaoYeViewContoller.h"
#import <AVFoundation/AVFoundation.h>
#import "LJLAVPlayer.h"

#import <UMSocialCore/UMSocialCore.h>

//#import "UmViewController.h"
#import "SouYeViewController.h"
//#import "UMVideoAd.h"

//逆流
//596dd7d28630f5198b0002eb
//wx7be8d736b4f1182c
//22eb288fa407e1805ae1b78e5e5ddcf8
@interface AppDelegate ()
{
    UITextView *textview;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   


    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"596da591cae7e74f5a0008fe"];
    
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxbd4f58d11f3237a1" appSecret:@"ad0be92f5f19a087e47228553aec60e1" redirectURL:nil];
      [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine  appKey:@"wxbd4f58d11f3237a1" appSecret:@"ad0be92f5f19a087e47228553aec60e1" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatFavorite  appKey:@"wxbd4f58d11f3237a1" appSecret:@"ad0be92f5f19a087e47228553aec60e1" redirectURL:nil];
//     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
    //后台播放锁屏也能播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
   [application beginReceivingRemoteControlEvents];
    //这个是给应用添加能接受远程控制（比如远程控制播放界面也要设置）
    [self becomeFirstResponder];
   
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
  
   self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    textview = [[UITextView alloc]init];
    textview.frame = CGRectMake(0, 0, 0, 0);
    [textview becomeFirstResponder];

    
    
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //第一次启动
        //        NSLog(@"第一次");
        
         UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[YindaoYeViewContoller new]];
        
        
//        YindaoYeViewContoller *yindaovc = [[YindaoYeViewContoller alloc]init];
        self.window.rootViewController = nav;
        
    }else{
        
        
        
        
        
     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[SouYeViewController new]];
 self.window.rootViewController = nav;
        
        //不是第一次启动了
        //        NSLog(@"不是第一次");
    }
    
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types != UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }else{
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound   categories:nil]];
   }
//    
    
    
    
    
    
    
    
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - **************** 调用过用户注册通知方法后执行（也就是调用完registerUserNotificationSettings：方法后执行）
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}
#pragma mark - **************** 进入前台后设置消息信息
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}
#pragma mark - **************** 私有方法
//添加本地通知
-(void)addLocalNotification{
    //定义本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc]init];
//    设置调用时间
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10.0];//通知触发时间，10s之后
    notification.repeatInterval = 2; //通知重复次数
    
    //设置通知属性
    notification.alertBody = @"哦哦，亲，有新鲜音乐更新了快来尝鲜吧";//通知主体
    notification.applicationIconBadgeNumber = 1;//应用程序右上角显示的未读消息数
    notification.alertAction = @"打开应用";//待机界面的滑动动作提示
    notification.alertLaunchImage = @"LaunchImage";//通过点击通知打开应用时的启动图片，这里使用程序启动图片
//    notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    //    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
    //设置用户信息
    notification.userInfo = @{@"id":@1,@"user":@"XF"};
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    
}
#pragma mark - **************** 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}








- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    
    
   //由于封面控制加上这句话就可以
//  [application beginBackgroundTaskWithExpirationHandler:NULL];
    
    
    
    
    
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    
//    NSLog(@"3333");
//切入后台是，接受远程控制
    [application beginReceivingRemoteControlEvents];
    
    
    
    
    
    
    
    
    
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
