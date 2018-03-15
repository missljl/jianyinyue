//
//  XiangqingViewController.m
//  Music
//
//  Created by ljl on 17/4/7.
//  Copyright © 2017年 李金龙. All rights reserved.
//
#define KScreen_Width [UIScreen mainScreen].bounds.size.width
#define KScreen_Height [UIScreen mainScreen].bounds.size.height


#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define WWDEVICECODE @"SWRP%07%03P%05S%04%00TW%0F%06P%01%03%07%0F%03%02WW%07%0E%05UT%02%04%02%0E%02%07TS%01%05T"
#define XIANGQING_WEB_URL @"http://wawa.fm/webview/musician_detail.html?uid=53416&id=%@&uid=53416&wwdeviceid=eadf15f3e26ba90f751954aa183cb424841be73b&wwcode=6&wwdevicecode=%@&ioshow=1&wwplatform=wwios&wwplay=0"

#define XIANGQING_HEAD_URL @"http://wawa.fm:9090/wawa/api.php/document/getdocument?datatype=jsonp&id=%@&uid=53416&platform=wwios&callback=data&_=1497594744926"


#define TWOANDTHR_WWDEVICECODE @"%5DY%5C%5E%09%0D%5E%0B%5D%0A%0EZY%01%08%5E%0F%0D%09%01%0D%0CYY%09%00%0B%5BZ%0C%0A%0C%00%0C%09Z%5D%0F%0BZ"
#define XIANGQING_TWOANDTHR_URL @"http://wawa.fm/webview/content.html?uid=53416&id=%@&uid=53416&wwdeviceid=eadf15f3e26ba90f751954aa183cb424841be73b&wwcode=8&wwdevicecode=%@&ioshow=1&wwplatform=wwios&wwplay=0"


#define XIANGQING_SOUYETOU_URL @"http://wawa.fm:9090/wawa/api.php/ad/getad?datatype=jsonp&id=%@&uid=53416&callback=data&_=1497696432216"


#import "XiangqingViewController.h"
#import "palyeView.h"
#import "HttpManager.h"
#import "XiangqingModel.h"
#import "UIImageView+WebCache.h"
#import "XQModel.h"
#import "XiaViewController.h"
#import "DuJiaView.h"
#import "WenzhangModel.h"
#import "WenzhangManager.h"
#import "MBProgressHUD.h"
#import "XQheadmodel.h"
#import <WebKit/WebKit.h>
//#import "LJLAVPlayer.h"
//#import <MediaPlayer/MediaPlayer.h>
@interface XiangqingViewController ()<WKNavigationDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIButton *leftbtn;
@property(nonatomic,strong)UIButton *rightbtn;
@property(nonatomic,strong)UIImageView *headImageview;
@property(nonatomic,strong)palyeView *palyView;
@property(nonatomic,strong)UITextView *textview;
@property(nonatomic,strong)XiangqingModel *model;
@property(nonatomic,strong)UIImageView *duogimageivew;
@property(nonatomic,strong)NSMutableArray *titlearray;
@property(nonatomic,strong)UIView *zhuangtailanview;
@property(nonatomic,strong)DuJiaView *dujiaview;

@property(nonatomic,strong) MBProgressHUD *hud;
@property(nonatomic,strong) MBProgressHUD *hud1;
@property(nonatomic,strong)WenzhangModel *wenmodel;
@property(nonatomic,assign)BOOL iswenzhang;

//@property(nonatomic,strong)LJLAVPlayer *play;
@property(nonatomic,assign)NSInteger dd;

@property(nonatomic,strong)NSMutableArray *ar;
@property(nonatomic,strong)NSMutableArray *ar1;

@property(nonatomic,strong)WKWebView *webview;




@end

@implementation XiangqingViewController
{

    NSMutableArray *fanxiegangar;
    XQModel *model1;
    UIView *view;
    UIView *view1;
    NSInteger ifone;
    UIImageView *imagevc;
    NSMutableAttributedString *attri1;
    XQheadmodel *headmodel;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    _titlearray = [[NSMutableArray alloc]init];
  
    fanxiegangar  = [[NSMutableArray alloc]init];
    _ar =[[NSMutableArray alloc]init];
    _ar1 = [[NSMutableArray alloc]init];
  
    _dd=1;
    
    ifone=0;
  
    [self cfigUI];
    
    
  
    
    
    
    
    _wenmodel = [[WenzhangModel alloc]init];
    _wenmodel.wemzhangid=_strid;
    _iswenzhang = [[WenzhangManager manager]isExists:_wenmodel.wemzhangid];
    [_rightbtn setImage:[UIImage imageNamed:_iswenzhang?@"CollectBtn_selected@2x":@"shareBtn@2x"] forState:UIControlStateNormal];
  

    
}

-(void)cfigUI{

    
    _webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.webview.scrollView.showsHorizontalScrollIndicator =NO;
    self.webview.scrollView.showsVerticalScrollIndicator = NO;
    
    
    //WithFrame:CGRectMake(0, 280, self.view.frame.size.width, self.view.frame.size.height-320)];
    _webview.backgroundColor =[UIColor whiteColor];
    
   _webview.scrollView.contentInset = UIEdgeInsetsMake(280, 0, 0, 0);
   [self.webview.scrollView setContentOffset:CGPointMake(0, -280)];


    
    

_webview.navigationDelegate =self;

    _webview.scrollView.delegate=self;
    [self.view addSubview:_webview];
    
    
     CGFloat xxianviewy = (kDevice_Is_iPhoneX)?44:22;
    _zhuangtailanview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, xxianviewy)];
    _zhuangtailanview.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
    _zhuangtailanview.alpha = 0;
    [self.view addSubview:_zhuangtailanview];
    
    
    
    
    
    _headImageview = [[UIImageView alloc]init];
    _headImageview.frame=CGRectMake(0, -280, KScreen_Width, 250);
    _headImageview.userInteractionEnabled = YES;
    _headImageview.contentMode =UIViewContentModeScaleAspectFill;
//    _headImageview.image = [UIImage imageNamed:@"CMComment_TextPanel_IMage@2x"];
  
    [self.webview.scrollView addSubview:self.headImageview];
    
    if (_isdujia==1) {
        

        
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:XIANGQING_TWOANDTHR_URL,_strid,TWOANDTHR_WWDEVICECODE]];
        NSURLRequest *reqst =[[NSURLRequest alloc]initWithURL:url];
        
        [_webview loadRequest:reqst];
        
        
        
        _dujiaview = [[DuJiaView alloc]initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, 60)];
        _dujiaview.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
        [self.view addSubview:_dujiaview];
        _dujiaview.alpha=0;
        
        UIColor *color= [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 49)];
        view.backgroundColor = color;
//        view.alpha=0;
        [_dujiaview addSubview:view];
        
        view1 = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 0, 60, 49)];
        view1.backgroundColor = color;
//        view1.alpha=0;
        [_dujiaview addSubview:view1];
        [self cnfigUIheadimageview];
        
        
    }if (_isdujia==0) {
        

        [self.view addSubview:_zhuangtailanview];
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:XIANGQING_WEB_URL,_strid,WWDEVICECODE]];
        NSURLRequest *reqst =[[NSURLRequest alloc]initWithURL:url];
        
        [_webview loadRequest:reqst];
        
        
        
    _palyView =[[palyeView alloc]initWithFrame:CGRectMake(40, _headImageview.frame.size.height-30, self.view.frame.size.width-80, 60) andwithtaggt:self andwithsemc:@selector(playbtn:)];
    _palyView.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
    
    [self.view addSubview:self.palyView];
        
        UILabel *a =[[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
        a.backgroundColor =[UIColor whiteColor];
        [self.webview.scrollView addSubview:a];
        [self loadData];
        
    
    }if (_isdujia==3) {
        
    //搜夜头部
        
        
        _palyView =[[palyeView alloc]initWithFrame:CGRectMake(40, _headImageview.frame.size.height-30, self.view.frame.size.width-80, 60) andwithtaggt:self andwithsemc:@selector(playbtn:)];
        _palyView.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
        
        [self.view addSubview:self.palyView];
        

        
        
        
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",_strid]];
        NSURLRequest *reqst =[[NSURLRequest alloc]initWithURL:url];
          [_webview loadRequest:reqst];
        
        [self loadData1];
    
    }
    

    
    
    
    
    _leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 50, 50)];
    [_leftbtn setImage:[UIImage imageNamed:@"backBtn@2x"] forState:UIControlStateNormal];
    [_leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftbtn];
    
    _rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 20, 50, 50)];
    
 
    
  
    [_rightbtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightbtn];

 
    
    
       
}
//首页歌曲链接个图片网络情切
-(void)loadData{

    

    NSString *url = [NSString stringWithFormat:XIANGQING_HEAD_URL,_strid];
  
    AFHTTPSessionManager *mange =[AFHTTPSessionManager manager];
    mange.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mange GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"详情页面正在加载");
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str);
        NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"data(" withString:@""];
        NSString *s =[strUrl stringByReplacingOccurrencesOfString:@")" withString:@""];
//
//        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
  
        NSDictionary *track =dict[@"track"];
       headmodel =[[XQheadmodel alloc]initWithDictionary:track error:nil];
//        NSLog(@"详情页面有数据来");
        [self cnfigUIheadimageview];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    

}
-(void)loadData1{
    

    
    
    NSString *url = [NSString stringWithFormat:XIANGQING_SOUYETOU_URL,_toustrd];
    
    AFHTTPSessionManager *mange =[AFHTTPSessionManager manager];
    mange.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mange GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",str);
        NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"data(" withString:@""];
        NSString *s =[strUrl stringByReplacingOccurrencesOfString:@")" withString:@""];
        //
        //
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"%@",dict);
        
        NSDictionary *track =dict[@"track"];
        headmodel =[[XQheadmodel alloc]initWithDictionary:track error:nil];
        
        [self cnfigUIheadimageview];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
 
    
    
    
    
    

    
    
    
    
    
    
    
    
    
}




-(void)cnfigUIheadimageview{

  
    
    
    if (_isdujia==1) {
        
        
        
        
        NSString *str = [NSString stringWithFormat:@"%@",_twoheadimage];
        [_headImageview sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"010"]];
        

        
        _dujiaview.Titlelable.text = _twotitle;
        _dujiaview.TitleTwolable.text=_twotitle;
        _dujiaview.subTitlelable.text = _twotubtitle;
        
    }if (_isdujia==0) {
        
    

 

        
        NSString *str = [NSString stringWithFormat:@"%@",headmodel.thumbnail_url];
        [_headImageview sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"010"]];
        
  _palyView.mingzilable.text =headmodel.songname;
    _palyView.geshoulable.text = headmodel.songer;
    
     NSString      *tustr = [NSString stringWithFormat:@"%@",headmodel.songphoto];
      
    [_palyView.playImageview sd_setImageWithURL:[NSURL URLWithString:tustr]placeholderImage:[UIImage imageNamed:@"CMComment_TextPanel_IMage"]];

//        NSLog(@"已经辅助了");
        
        
    }if (_isdujia==3) {
        
    
        
        NSString *str = [NSString stringWithFormat:@"%@",headmodel.thumbnail_url];
        [_headImageview sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"010"]];
    
        
        _palyView.mingzilable.text =headmodel.songname;
        _palyView.geshoulable.text = headmodel.songer;
        
        NSString      *tustr = [NSString stringWithFormat:@"%@",headmodel.songphoto];
        
        [_palyView.playImageview sd_setImageWithURL:[NSURL URLWithString:tustr]placeholderImage:[UIImage imageNamed:@"CMComment_TextPanel_IMage"]];
    }

    
    
    
}


-(void)playbtn:(UIButton *)btn{

    
    
    
    if (btn.selected) {
        
        btn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"CMCommentVC_CMMusicInfoPanel_playBtn_normal"] forState:UIControlStateNormal];
       ifone=1;
         [[NSNotificationCenter defaultCenter]postNotificationName:@"xiangqing" object:nil userInfo:@{@"tag":@"0"}];

        
    }else{

//        
        if (headmodel.filename==nil||headmodel.songname==nil||headmodel.songer==nil) {
            
            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            _hud.mode = MBProgressHUDModeText;
            _hud.label.text = @"歌曲正在来的路上，请稍等一下....";
            _hud.label.font = [UIFont systemFontOfSize:13];
            
            _hud.label.textColor = [UIColor lightGrayColor];
            
            _hud.bezelView.color = [UIColor whiteColor];
//            _hud.delegate = self;
            
            [_hud hideAnimated:YES afterDelay:2.0];
 
            btn.selected=NO;

        }else{

       btn.selected = YES;
       [self.delegate xiangqinggequUrl:headmodel.filename320 andxiangqinggequimage:headmodel.thumbnail_url andxiangqinggeming:headmodel.songname andxiangqinggeshou:headmodel.songer andxiangqingtrok_id:_trok_id1];
//            NSLog(@"播放器已经肤质了");
                [btn setImage:[UIImage imageNamed:@"CMCommentVC_CMMusicInfoPanel_playBtn_selected"] forState:UIControlStateNormal];
//        }
            }
    
    }



}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    
   CGFloat xOffset = (yOffset +280)/2;


    if (yOffset < -280) {
       
        CGRect rect = _headImageview.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = KScreen_Width + fabs(xOffset)*2;
        
       _headImageview.frame = rect;
        
       
        
        
    }//
    
    
    
    /////////////////////////////////////////
    
    CGFloat q = 280+yOffset;
    CGFloat a=q/5;
    CGFloat g=q/30;
    CGRect frame1 = _palyView.frame;
    frame1.origin.x=40-a;
    frame1.size.width=self.view.frame.size.width-80+a*2;
    frame1.origin.y=250-a*5;
    frame1.size.height=70-g;
    
      CGFloat alpha = (yOffset+280)/280;
   
    
    
    CGRect playm = _palyView.playImageview.frame;
    
     UIColor *color= [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
    

    
    
    if (_isdujia==1) {
         CGFloat alpha = (yOffset+280)/280;
        
      _dujiaview.alpha = alpha;
        
        
    }if (_isdujia==0||_isdujia==3) {
        
     CGFloat xxianviewy = (kDevice_Is_iPhoneX)?44:22;
    
        if (frame1.origin.y<=22) {
            
            
            
            frame1.origin.y=xxianviewy;
            frame1.size.height=49;
            frame1.size.width = self.view.frame.size.width;
            frame1.origin.x=0;
            playm.size.height=49;
            _palyView.playImageview.frame=playm;
           
            
            
        }else{
            
            playm.size.height =frame1.size.height;
            _palyView.playImageview.frame=playm;
            
            
        }
        CGRect btnfeame = _palyView.palyebtn.frame;
        
        
        if (yOffset<-280) {
          
            btnfeame.origin.x = _palyView.frame.size.width-60;
            _palyView.palyebtn.frame = btnfeame;
            
        }else{
            
            
            if (frame1.origin.y<=xxianviewy) {
                btnfeame.origin.x=self.view.frame.size.width-90;
                btnfeame.origin.y = 11;
                btnfeame.size.width =25;
                btnfeame.size.height=25;
            }else{
                
                
                if (yOffset==-280) {
                    
                    btnfeame.origin.x=btnfeame.origin.x;
                    
                }else{
                    btnfeame.size.width =25+(30*(1-alpha));
                    btnfeame.size.height=25+(30*(1-alpha));
                    
                    btnfeame.origin.x =self.view.frame.size.width-80-(60*(1-alpha));
                   }
            }
            
            _palyView.palyebtn.frame = btnfeame;
            
            
        }
    
        _palyView.playImageview.backgroundColor = color;
        _palyView.playImageview.alpha =1-alpha;
      
        
        
        _palyView.frame = frame1;
    }
    
       _zhuangtailanview.alpha = alpha;
    
    
    
    

}

-(BOOL)prefersStatusBarHidden{
    
    return NO;
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(void)rightClick{

    
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
        
        if (_isdujia==0) {
            
            
            _wenmodel = [[WenzhangModel alloc]init];
            _wenmodel.wemzhangid = _strid;
            _wenmodel.wenzhangtitle =headmodel.songname;
            _wenmodel.wenzhangzuozhe = headmodel.songer;
            _wenmodel.tag1=[NSString stringWithFormat:@"%ld",(long)_isdujia];

            [[WenzhangManager manager]addModel:_wenmodel];
            
            
            
            
            
            
        }if (_isdujia==1) {
            
            
            _wenmodel = [[WenzhangModel alloc]init];
            _wenmodel.wemzhangid = _strid;
            _wenmodel.wenzhangtitle =_twotitle;
            _wenmodel.wenzhangzuozhe = _twotubtitle;
            _wenmodel.tag1=[NSString stringWithFormat:@"%ld",(long)_isdujia];
            _wenmodel.tuimage =_twoheadimage;
//             NSLog(@"%@",_wenmodel.tag1);
            [[WenzhangManager manager]addModel:_wenmodel];
  
            
            
        }if (_isdujia==3) {
            
            _wenmodel = [[WenzhangModel alloc]init];
            _wenmodel.wemzhangid = _strid;
            _wenmodel.wenzhangtitle =headmodel.songname;
            _wenmodel.wenzhangzuozhe = headmodel.songer;
            _wenmodel.tag1=[NSString stringWithFormat:@"%ld",(long)_isdujia];
            _wenmodel.tuimage =_twoheadimage;
            _wenmodel.link=_toustrd;
//             NSLog(@"%@",_wenmodel.tag1);
            [[WenzhangManager manager]addModel:_wenmodel];
  
//            xiang.strid =model.link;
//            xiang.isdujia=3;
//            xiang.twoheadimage =model.image;
//            xiang.toustrd=model.aid;
        }
            
        

//        
        _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sc"]];
              _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _hud.contentColor= [UIColor clearColor];
        _hud.bezelView.backgroundColor = [UIColor clearColor];
        [_hud hideAnimated:YES afterDelay:1];
 
        
    
    }
    _iswenzhang=!_iswenzhang;
    [_rightbtn setImage:[UIImage imageNamed:_iswenzhang?@"CollectBtn_selected@2x":@"shareBtn@2x"] forState:UIControlStateNormal];
    
    
    

}

-(void)leftClick{
    
    
    if (_issoucang==5) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{

        
       
    [self.navigationController popViewControllerAnimated:YES];
         [self.view removeFromSuperview];

    }

}




#pragma mark - 获取这个字符串ASting中的所有abc的所在的index
- (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
    
    if (findText == nil && [findText isEqualToString:@""])
    {
        
        return nil;
        
    }
    
    NSRange rang = [text rangeOfString:findText]; //获取第一次出现的range
    
    if (rang.location != NSNotFound && rang.length != 0)
    {
        
        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];//将第一次的加入到数组中
        
        NSRange rang1 = {0,0};
        
        NSInteger location = 0;
        
        NSInteger length = 0;
        
        for (int i = 0;; i++)
        {
            
            if (0 == i)
            {
                
                //去掉这个abc字符串
                location = rang.location + rang.length;
                
                length = text.length - rang.location - rang.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            else
            {
                
                location = rang1.location + rang1.length;
                
                length = text.length - rang1.location - rang1.length;
                
                rang1 = NSMakeRange(location, length);
                
            }
            
            //在一个range范围内查找另一个字符串的range
            
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            
            if (rang1.location == NSNotFound && rang1.length == 0)
            {
                
                break;
                
            }
            else//添加符合条件的location进数组
                
                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
          
        }
        
        return arrayRanges;
        
    }
    
    return nil;
    
}
-(void)getshangyishouge:(NSInteger)shu{

   
}


#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
//    NSLog(@"didStartProvisionalNavigation开始加载");
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
//    NSLog(@"didCommitNavigation正在加载");
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
//    NSLog(@"didFinishNavigation加载完成");
    
//    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    [self.webview evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'" completionHandler:nil];
    
        if (_isdujia==0||_isdujia==3) {
       [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('song')[0].style.display = 'none'" completionHandler:nil];
            
         [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('btn')[0].style.display = 'none'" completionHandler:nil];
            [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('recommend')[0].style.display = 'none'" completionHandler:nil];
               [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('commit')[0].style.display = 'none'" completionHandler:nil];
               [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('footer')[0].style.display = 'none'" completionHandler:nil];

        }if (_isdujia==1) {
    
            [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('resource')[0].style.display = 'none'" completionHandler:nil];
            
            [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('recommend')[0].style.display = 'none'" completionHandler:nil];
            [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('commit')[0].style.display = 'none'" completionHandler:nil];
                   [self.webview evaluateJavaScript:@"document.documentElement.getElementsByClassName('footer')[0].style.display = 'none'" completionHandler:nil];
        }
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


















@end
