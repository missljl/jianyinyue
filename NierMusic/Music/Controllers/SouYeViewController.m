//
//  SouYeViewController.m
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define SOUYE_FIRST_URL @"http://wawa.fm:9090/wawa/api.php/document/getYuerenList?datatype=jsonp&uid=53416&r=10&page=%ld&callback=data&_=1497594516583"

#define SOUYE_TOU_URL @"http://wawa.fm:9090/wawa/api.php/index/fmfragment1"

#define SOUYE_YEWEN_URL @"http://wawa.fm:9090/wawa/api.php/document/getDocumentByCategory?callback=data&jid=53416&cid=29&datatype=jsonp&r=10&page=%ld&_=1497594892097"
#define SOUYE_LVXING_URL @"http://wawa.fm:9090/wawa/api.php/document/getDocumentByCategory?callback=data&jid=53416&cid=653&datatype=jsonp&r=10&page=%ld&_=1497595303224"



#define SOUYE_ZUIHOU_URL @"http://wawa.fm:9090/wawa/api.php/magazine/magazinelist/r/10/page/%ld"


///宽的比例
#define RATE SCREEN_WIDTH/320.0
//屏幕的宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IMAGEHEIGHT    370
#define KWS(weakSelf) __weak __typeof(&*self) weakSelf=self


#import "SouYeViewController.h"
#import "GongJuLei.h"
#import "MJRefresh.h"
#import "HttpManager.h"
#import "SouYeModel.h"
#import "SouyeCell.h"
#import "SouyeHeadCell.h"
#import "UIImageView+WebCache.h"
#import "HeadView.h"
#import "SandianView.h"
#import "XiaViewController.h"
#import "LeftViewController.h"
#import "LeftTwoModel.h"
#import "XiangqingViewController.h"
#import "ZaoanXIangqingViewController.h"
#import "RightViewController.h"
#import "AppDelegate.h"

#import "SouYeToumode.h"




#import "FavoriteManager.h"
#import "MBProgressHUD.h"
#import "LastVcsectionView.h"
#import "LastFastcell.h"
#import "lastrowcell.h"






@interface SouYeViewController()
@property(nonatomic,strong)UIView *dianview;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *headArray;
@property(nonatomic,strong)HeadView *headview;
@property(nonatomic,strong)SandianView *sandianview;
@property(nonatomic,strong)UIButton *btn;


@property(nonatomic,assign)CGFloat svcoffset;




@property(nonatomic,strong)NSMutableArray *dierciar;
@property(nonatomic,assign)NSInteger currentpage;

@property (strong,nonatomic)UIButton * tmpBtn;
@end


@interface SouYeViewController ()<LeftViewControllerDelegate,HeadDelegate,RightVCdelegate,xiangqingDelegate>
{
    CGRect tr;
    NSInteger pandandiyici;
    XiaViewController *xiaview;
    LastVcsectionView *view;
    NSInteger palyecoutn;
    
    UIButton *palyebtn;
  NSInteger fold[80];
    
    UILabel *l;
    
    NSIndexPath *setionindexpath;
    
    
    UIButton *souyebtn;
    
    
}
@end

@implementation SouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
  
    palyecoutn=900;
    
    _dierciar = [[NSMutableArray alloc]init];
    if (kDevice_Is_iPhoneX == YES){
     
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        
      self.automaticallyAdjustsScrollViewInsets = NO;
        
    }

   self.navigationController.navigationBarHidden = YES;
    
    self.view.userInteractionEnabled =YES;
    self.tableView.userInteractionEnabled = YES;
  
    self.headArray = [[NSMutableArray alloc]init];

    pandandiyici=0;
 
    souyebtn=xiaview.leftbtn;
     _currentpage = 1;
     [self loadDataOr:YES];
    [self headerData];


    self.tableView.contentInset = UIEdgeInsetsMake(IMAGEHEIGHT, 0, 0, 0);  // 应用启动, 滚动到最顶部,显示额外的头部视图
    [self.tableView setContentOffset:CGPointMake(0, -IMAGEHEIGHT)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SouyeCell" bundle:nil] forCellReuseIdentifier:@"souyecell"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"LastFastcell" bundle:nil] forCellReuseIdentifier:@"lastfastcell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"lastrowcell" bundle:nil] forCellReuseIdentifier:@"lastrowcell"];
    

    
    [self addtoubuNSNotDefuser];
    

    
    xiaview = [[XiaViewController alloc]init];
    CGFloat xxianviewy;
    if (kDevice_Is_iPhoneX ==YES) {
        xxianviewy =22;
    }else{
        
        xxianviewy =49;
    }
    
    
    xiaview.view.frame = CGRectMake(0, self.view.frame.size.height-xxianviewy, self.view.frame.size.width, self.view.frame.size.height);
    UIWindow *winde = [[UIApplication sharedApplication].windows lastObject];
    [winde addSubview:xiaview.view];
    
    self.tableView.showsHorizontalScrollIndicator =NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
  
   
    [self addRefreshHeader:NO andHaveFooter:YES];
    NSLog(@"11111111");
    NSLog(@"第二个分支");
}




-(void)dealloc{

    //头部通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ChangeBlockcolor" object:nil];

    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"xiazhongjianbtn" object:nil];
[[NSNotificationCenter defaultCenter]removeObserver:self name:@"xialeftbtn" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"qingshao" object:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"rightbtn" object:nil];
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"rightbtn" object:nil userInfo:@{@"tag":@"0"}];
}


-(BOOL)prefersStatusBarHidden{

  
        return YES;
 
    
  
    
}
//头部点
-(UIView *)dianview{
    if (!_dianview) {
        _dianview = [[UIView alloc]init];
        _dianview.userInteractionEnabled = YES;
          _dianview.backgroundColor = [UIColor whiteColor];
        if (self.view.frame.size.width>320&&self.view.frame.size.width<400) {
        


         

               _dianview.frame = CGRectMake(0,0, self.view.frame.size.width, 30);
                _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 8, 30, 17)];
            

         



        }if (self.view.frame.size.width>400) {
          
            _dianview.frame = CGRectMake(0,0, self.view.frame.size.width, 33);
         

            _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 8, 30, 17)];


        }else{

            if (kDevice_Is_iPhoneX == YES){
                _dianview.frame = CGRectMake(0,0, self.view.frame.size.width, 44);
             
               
                _btn = [[UIButton alloc]initWithFrame:CGRectMake(28, 8, 24, 20)];
            }else {
                
                _dianview.frame = CGRectMake(0,0, self.view.frame.size.width, 22);
               
                _btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 8, 24, 7)];
                
            }
            
         
        }
        [_btn setImage:[UIImage imageNamed:@"menuBtn_sel@2x"] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(tab:) forControlEvents:UIControlEventTouchUpInside];

        [_dianview addSubview:_btn];

        _btn.selected = NO;

  }

    return _dianview;


}
//点点按钮出现的4个标签
-(SandianView *)sandianview
{
    

   NSArray *ar= @[@"interview@2x",@"singelRecommend@2x",@"goodmorningSong@2x",@"carefullSel@2x"];
   NSArray *titlear = @[@"首页精选",@"推荐艺文",@"旅行日记",@"精选音乐"];
    
    if (!_sandianview) {
        _sandianview = [[SandianView alloc]initWithFrame:CGRectMake(0,22, self.view.frame.size.width, 110) andImageviewArray:ar  andtitleName:titlear];
        _sandianview.userInteractionEnabled = YES;
        _sandianview.backgroundColor  = [UIColor whiteColor];
    }
    return _sandianview;
}
//点点击事件
-(void)tab:(UIButton *)btn
{
//    if (@available(iOS 11.0, *)){
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else {
//
//
//
//    }
 
   
    btn.selected = !btn.selected;
    if (btn.selected) {
        
         [btn setImage:[UIImage imageNamed:@"menuBtn_nor@2x"] forState:UIControlStateNormal];
        
        [self isdianxianshi:YES];

        
    }else{
    
    [btn setImage:[UIImage imageNamed:@"menuBtn_sel@2x"] forState:UIControlStateNormal];
    
        [self isdianxianshi:NO];
        

   
    }
  
}

/*点点击事件逻辑
 重点逻辑这边
 先判断选中和没选中，然后在选中(没选中)里面判断滚动和没滚动，然后再再没滚动里面判断是不是第一个界面
 
 */

-(void)isdianxianshi:(BOOL)isdian{

    
       CGFloat stausteheight = kDevice_Is_iPhoneX?44:22;
    
    
    
    if (isdian) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
              self.tableView.scrollEnabled=NO;
            
            
            //这边是选中判断滚动没有
            if (_svcoffset<=0) {
                //没滚工
                
                if (pandandiyici==1||pandandiyici==2||pandandiyici==3) {
                    
                    _sandianview.frame = CGRectMake(0, 22, self.view.frame.size.width, 110);
                    _dianview.frame =CGRectMake(0, 0, self.view.frame.size.width, 140);
                 
                    
                    [_dianview addSubview:self.sandianview];
                    
                    [self.view addSubview:self.dianview];
   
                    
                    
                }else{
                
                
                _sandianview.frame = CGRectMake(0, 22, self.view.frame.size.width, 110);
                _dianview.frame =CGRectMake(0, -IMAGEHEIGHT, self.view.frame.size.width, 140);
   
                
                [_dianview addSubview:self.sandianview];
  
                [self.view addSubview:self.dianview];
             
                }
            }else{
            //滚动
                CGRect frame = self.dianview.frame;
                frame.origin.y = _svcoffset;
                frame.size.height =150;
             self.dianview.frame = frame;

                
                _sandianview.frame = CGRectMake(0, 22, self.view.frame.size.width, 110);

                
                [_dianview addSubview:self.sandianview];
        
            
            
            }
            
            
        }];
        }else{
    
        [UIView animateWithDuration:0.5 animations:^{
            
              self.tableView.scrollEnabled = YES;
            
            _sandianview.frame = CGRectMake(0, -IMAGEHEIGHT-20, self.view.frame.size.width, 0);
            
            if (_svcoffset<=0) {
            
                
                if (pandandiyici==1||pandandiyici==2||pandandiyici==3) {
                 
                    _dianview.frame = CGRectMake(0, 0, self.view.frame.size.width, stausteheight);
                    
                    
                }else{
                
                
                    _dianview.frame =CGRectMake(0, -IMAGEHEIGHT, self.view.frame.size.width, stausteheight);
                }
                
            }else{
            
                if (pandandiyici==1||pandandiyici==2||pandandiyici==3) {
                    CGRect frame = self.dianview.frame;
                    frame.origin.y = _svcoffset-5;
                    frame.size.height=stausteheight;
                    self.dianview.frame = frame;
                    
                    [self.view addSubview:self.dianview];
  
                    
                    
                }else{
                
                
                CGRect frame = self.dianview.frame;
                frame.origin.y = _svcoffset;
                frame.size.height=stausteheight;
                self.dianview.frame = frame;
                
               [self.view addSubview:self.dianview];
             
           
                }
            
            }
            
                }];
          
          
     }



}


-(NSMutableArray *)dataArray
{

    if (!_dataArray) {
        _dataArray =[[NSMutableArray alloc]init];
        
    }

    return _dataArray;
}
//一开始加载
-(void)loadDataOr:(BOOL)isHead1{

    

    
    NSString *str =[NSString stringWithFormat:SOUYE_FIRST_URL,(long)_currentpage];
    AFHTTPSessionManager *mange =[AFHTTPSessionManager manager];
    mange.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mange GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      

        [self.tableView.mj_footer endRefreshing];
        
                if (_currentpage==1) {
        
        
                    [_dataArray removeAllObjects];
                }
 
        
        
     NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
      NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"data(" withString:@""];
        NSString *s =[strUrl stringByReplacingOccurrencesOfString:@")" withString:@""];
        

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
  
      NSArray *dic1 =dict[@"list"];
        for (NSDictionary *dic in dic1) {
           
            SouYeModel *model =[[SouYeModel alloc]initWithDictionary:dic error:nil];
        
            [self.dataArray addObject:model];
            
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [self.tableView.mj_footer endRefreshing];
        
        NSLog(@"%@",error);
    }];
    
    
    
    
    
    


}
-(void)headerData{

    
    
 
    
    
    
    
    //头滚动试图
    NSString *TOUstr =[NSString stringWithFormat:SOUYE_TOU_URL];
  
    
    HttpManager *toumanger =[HttpManager shareManager];
    [toumanger requestWithUrl:TOUstr withDictionary:nil withSuccessBlock:^(id responseObject) {
        NSArray *touar =responseObject[@"ad"];
        for (NSDictionary *toudic in touar) {
            
            SouYeToumode *model =[[SouYeToumode alloc]initWithDictionary:toudic error:nil];
            
            [_headArray addObject:model];
          
        }
        if (_headArray.count<2) {
            SouYeToumode *model = [[SouYeToumode alloc]init];
            model.link = @"http://wawa.fm/webview/article.html?type=banner&id=220";
            model.image = @"http://cdn.wawa.fm/group1/M00/01/60/CvrcZ1k0zT-AcfubAAUs-v4dC_U898.png";
            model.aid = @"220";
            [_headArray addObject:model];
        }
        
        [self isheader:YES];
        
        
    } withFailureBlock:^(NSError *error) {
        
    }];




}



//首页头部视图
-(void)isheader:(BOOL)isheader{

    if (isheader) {
        _headview.userInteractionEnabled = YES;
        _headview= [[HeadView alloc]initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, IMAGEHEIGHT) WithArray:_headArray];
    _headview.tag=800;
    _headview.delegate = self;

    
        //[self.view sendSubviewToBack:_headview];
    }
}
-(void)headViewsid:(SouYeToumode *)model{


//    NSLog(@"%@",model.aid);
    XiangqingViewController *xiang = [[XiangqingViewController alloc]init];
    
    xiang.strid =model.link;
    xiang.isdujia=3;
    xiang.twoheadimage =model.image;
    xiang.toustrd=model.aid;
    xiang.trok_id1 = @"12453";
    xiang.delegate =self;
    //要加一个trok判断
    [self.navigationController pushViewController:xiang animated:YES];


}


//这个是section中cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (pandandiyici==0||pandandiyici==1||pandandiyici==2) {
        
    
    
    if (self.view.frame.size.width>320&&self.view.frame.size.width<400) {
        
        return 320;
        
    }if (self.view.frame.size.width>400) {
        
        return 350;
        
    }else{
    
    
    
        return 280;
    }
    }else{
    
        if (fold[indexPath.section]==0) {
            
            return 0;
            
        }else{
            palyecoutn =indexPath.section;
            if (indexPath.row==0) {
                

                return 330;
                
                

            }else{
            
                return 80;
            }
            
        
        }
    
    
    
    
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (pandandiyici==3) {
        
        if (fold[section]==0) {
            
            

            return 0;
          
        }else{
          
            SouYeModel *model =_dataArray[section];

            return model.tracks.count;
          
        }
        
    }else{
    
    
        return _dataArray.count;
    
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (pandandiyici==0) {
        
        static NSString *cellId = @"souyecell";
        
        
        SouyeCell   *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        SouYeModel *model = _dataArray[indexPath.row];
        
        cell.soutitlelabel.font = [UIFont boldSystemFontOfSize:18];
        cell.soutitlelabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(18)];
        cell.soutitlelabel.textColor =[UIColor blackColor];
     
        NSString *str= [NSString stringWithFormat:@"%@",model.cover_url];
            [cell.souyeimageview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"CMComment_TextPanel_IMage"]];
        
        NSArray *titlar =[model.title1 componentsSeparatedByString:@"："];
        //    cell.backgroundColor =[UIColor lightGrayColor];
        cell.soulable.text =titlar[0];
        //    cell.soulable.font =[UIFont systemFontOfSize:<#(CGFloat)#>]
        cell.soulable.font = [UIFont boldSystemFontOfSize:18];
        cell.soulable.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(18)];
        cell.soutitlelabel.text =titlar[1];

        cell.souyewenlabel.text =[NSString stringWithFormat:@"文/%@    🎧:%@次     👀:%@次",model.editor,model.playcount,model.view_count];
        cell.souyewenlabel.textColor =[UIColor lightGrayColor];
        cell.soulable.hidden=NO;
        
        
        return cell;
    }if (pandandiyici==1||pandandiyici==2) {
        
        static NSString *cellId = @"souyecell";
        
        
        SouyeCell   *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        SouYeModel *model = _dataArray[indexPath.row];
        
        cell.soutitlelabel.font = [UIFont boldSystemFontOfSize:18];
        cell.soutitlelabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(18)];
        cell.soutitlelabel.textColor =[UIColor blackColor];
        
        NSString *str= [NSString stringWithFormat:@"%@",model.cover_url];
        [cell.souyeimageview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"CMComment_TextPanel_IMage"]];
        cell.soutitlelabel.text =model.title1;
//        cell.soutitlelabel.font = [UIFont boldSystemFontOfSize:18];
        cell.souyewenlabel.text =[NSString stringWithFormat:@"🏷️:%@",model.member_name];
        cell.souyewenlabel.textColor =[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
        cell.soulable.hidden=YES;
        return cell;
    }if (pandandiyici==3) {
        
        SouYeModel *model =_dataArray[indexPath.section];
      
        ItmeModel *model1 =model.tracks[indexPath.row];
       
        if (indexPath.row==0) {
             static NSString *cellId1 = @"lastfastcell";
            
            LastFastcell *cell = [tableView dequeueReusableCellWithIdentifier:cellId1 forIndexPath:indexPath];

            [cell setIntroductionText:model.mdesc];
            
            
            cell.userInteractionEnabled =NO;
             return cell;
           
        }if (indexPath.row>0) {
            
            static NSString *cellId = @"lastrowcell";
            
            
             lastrowcell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
            

            cell.lastrowtitlelable.text =model1.songname;
            [cell.lastrowimageview sd_setImageWithURL:[NSURL URLWithString:model1.songphoto]];
            cell.lastrowsubtitlelable.text =model1.songer;
            cell.lastrowsectedview.hidden=YES;
            
    
            if ([setionindexpath isEqual:indexPath])
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            else
                
                cell.accessoryType = UITableViewCellAccessoryNone;
            
            
            

            
             return cell;
        }
        
    }
 
 
    return nil;
    
}



//组的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (pandandiyici==3) {
        
        return 230;
        
    }else{
    
        return 0;
    
    }
}
//组的样式
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (pandandiyici==3) {
        
        view =[[LastVcsectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 225) ];
        view.userInteractionEnabled =YES;
        

        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0,view.frame.size.height, self.view.frame.size.width, 5)];
        //创建的阴影线
        view1.backgroundColor = [UIColor lightGrayColor];
        view1.alpha = 0.5;
        [view addSubview:view1];
    view.tag = 500+section;

    SouYeModel *model =_dataArray[section];
    
    [view.playImageview sd_setImageWithURL:[NSURL URLWithString:model.mphoto]];
        view.titlelabel.text =model.mname;
        view.riqilabel.text =[NSString stringWithFormat:@"第%@期      🎧:%@人听过",model.mnum,model.play_count];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapcilick:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        
        [view addGestureRecognizer:tap];
        
        return view;

    }else{
        
        
            return nil;
        
        }
}
-(void)tapcilick:(UITapGestureRecognizer *)tap{

   
NSInteger index = tap.view.tag-500;
    
    
   
    
    

    
    
    
    if (palyecoutn==900||palyecoutn==index) {

        fold[index] = !fold[index];
//         [self tabCick:view.palyebtn];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];

    }else{

        
        //            fold[index]=!fold[index];
        fold[palyecoutn]=0;
      [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:palyecoutn] withRowAnimation:UITableViewRowAnimationFade];
        fold[index]=1;

        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    
    }
 

}

/*这里面的逻辑是多个按钮状态切换*/
-(void)tabCick:(UIButton *)tap

{
    if (_tmpBtn==nil) {
        tap.selected=YES;
        _tmpBtn=tap;
//        NSLog(@"1播放");
        
    }else if (_tmpBtn!=nil&&_tmpBtn==tap){
        tap.selected=!tap.selected;

        
    }else if (_tmpBtn!=tap&&_tmpBtn!=nil){
//        NSLog(@"3播放");
        _tmpBtn.selected =NO;
        tap.selected=YES;
        _tmpBtn=tap;
    }
    
    

    
}
//section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (pandandiyici==3) {
        
    
        return _dataArray.count;}else{
        
        
            return 1;
        
        }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
   

    if (pandandiyici==0) {
        
        XiangqingViewController *xiang = [[XiangqingViewController alloc]init];
        xiang.delegate =self;
        xiang.buttonFrame = souyebtn.frame;
        
    xiang.strid = [_dataArray[indexPath.row]aid];
        xiang.trok_id1 = [_dataArray[indexPath.row]track_id];
       xiang.isdujia=0;

    [self.navigationController pushViewController:xiang animated:YES];
   }
    

    if (pandandiyici==1) {
        XiangqingViewController *xiang = [[XiangqingViewController alloc]init];
        xiang.delegate =self;
        xiang.buttonFrame = souyebtn.frame;

        xiang.strid = [_dataArray[indexPath.row]aid];
        xiang.isdujia =1;
        
        xiang.twoheadimage =[_dataArray[indexPath.row]cover_url];
        xiang.twotitle =[_dataArray[indexPath.row]title1];
        xiang.twotubtitle =[_dataArray[indexPath.row]description1];

        
        [self.navigationController pushViewController:xiang animated:YES];
  
        
    }if (pandandiyici==2) {

        XiangqingViewController *xiang = [[XiangqingViewController alloc]init];
        xiang.delegate =self;
        xiang.buttonFrame = souyebtn.frame;
        xiang.strid = [_dataArray[indexPath.row]aid];
        xiang.isdujia =1;
        xiang.twoheadimage =[_dataArray[indexPath.row]cover_url];
        xiang.twotitle =[_dataArray[indexPath.row]title1];
        xiang.twotubtitle =[_dataArray[indexPath.row]description1];
        
        [self.navigationController pushViewController:xiang animated:YES];
    
    }
    
    if (pandandiyici==3) {
        
        SouYeModel *model =_dataArray[indexPath.section];
        ItmeModel *model1 =model.tracks[indexPath.row];

        if (model1.filename==nil||model1.songname==nil||model1.songer==nil) {
            
      MBProgressHUD   *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"歌曲正在来的路上，请稍等一下在次点击播放....";
            hud.label.font = [UIFont systemFontOfSize:13];
            
            hud.label.textColor = [UIColor lightGrayColor];
            
            hud.bezelView.color = [UIColor whiteColor];
        
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }else{
        
        
        if (setionindexpath) {
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:setionindexpath];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        setionindexpath = indexPath;
        

       cell.selectionStyle = UITableViewCellSelectionStyleNone;

      
        xiaview.songArr1 = [[NSMutableArray alloc]init];
        xiaview.songImageArr1 = [[NSMutableArray alloc]init];
        //
        xiaview.songNameArr1 = [[NSMutableArray alloc]init];
        xiaview.songAuthorArr1 = [[NSMutableArray alloc]init];
            xiaview.trok_idarray = [[NSMutableArray alloc]init];
        ////
        
        
        NSString *songurl = model1.filename320;
        
        
        [xiaview.songArr1 addObject:songurl];
        
        [xiaview.songImageArr1 addObject:model1.songphoto];
        
        NSString *name =model1.songname;
        
        [xiaview.songNameArr1 addObject:name];
        
        [xiaview.songAuthorArr1  addObject:model1.songer];
            [xiaview.trok_idarray addObject:model1.ida];
        [xiaview  addPlayerViewandSongUrlArr:xiaview.songArr1 andSongImageArr:xiaview.songImageArr1];
        
        
        }
        
        
    }

//滑动事件
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    if (pandandiyici==0) {
       const CGFloat speed = 0.6; // speed <= 1
    
    CGRect org = CGRectMake(0, -IMAGEHEIGHT, self.view.frame.size.width, IMAGEHEIGHT);
    org.origin.y = scrollView.contentOffset.y * speed - IMAGEHEIGHT * (1 - speed);
    tr = org;
        
        
        
    }if (pandandiyici==1||pandandiyici==2) {

    }if (pandandiyici==3) {

             CGFloat sectionHeaderHeight = 230;
                if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
                    NSLog(@"------");
                    scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
                } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                     NSLog(@"++");
                    scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
                }
    }
    
    
            _svcoffset = scrollView.contentOffset.y;
    
            CGRect frame = self.dianview.frame;
            frame.origin.y = scrollView.contentOffset.y;
            self.dianview.frame = frame;
    
         [self.view addSubview:self.dianview];
    
 
    
    
    
    
    
}
-(void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    self.headview.frame = tr;
  
    [self.tableView insertSubview:self.headview atIndex:0];
    
}




//头部点击通知
-(void)addtoubuNSNotDefuser{


  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(des:) name:@"ChangeBlockcolor" object:nil];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xiazhongjianbtn:) name:@"xiazhongjianbtn" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xialeftbtn:) name:@"xialeftbtn" object:nil];

   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xiaqingshao:) name:@"qingshao" object:nil];
    

  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xiarightbtn:) name:@"rightbtn" object:nil];

    
    
}
//xiaview中间视图
-(void)xiazhongjianbtn:(NSNotification*)not{

    NSDictionary *dic= not.userInfo;
    
    NSInteger idex =[dic[@"tag"]integerValue];
  
    
    if (idex==0) {
        
        
        
        if (xiaview.songAuthorArr1>0) {
            
        
            


            //弹簧效果参数1动画持续时间，2延迟几秒，3动画祝你细数，4动画开始速度，5动画效果参数
           [UIView animateWithDuration:1.0 delay:0.5 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
               xiaview.view.frame = CGRectMake(0, -49, self.view.frame.size.width, self.view.frame.size.height+49);
               
               
           } completion:^(BOOL finished) {
            
              
               MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:xiaview.view animated:YES];
               
               hud.mode = MBProgressHUDModeCustomView;
           
            
               hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CMGeneTransceiverVC_TipImage1"]];
           
           
          
               hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
               hud.contentColor= [UIColor clearColor];
               hud.bezelView.backgroundColor = [UIColor clearColor];
               
               [hud hideAnimated:YES afterDelay:1.5];
   
               
               
               
           }];
            


        }else{
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            hud.mode = MBProgressHUDModeCustomView;

            hud.minSize = CGSizeMake(80, 80);
            
            //12设置背景框的实际大小  readonly
            
            
            
            hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.contentColor= [UIColor clearColor];
            hud.bezelView.backgroundColor = [UIColor clearColor];

            hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ContentOccurError"]];

            [hud hideAnimated:YES afterDelay:2];
       
        
        }
    
    }
}
//下左边视图
-(void)xialeftbtn:(NSNotification *)not{

    
    
    LeftViewController *left = [[LeftViewController alloc]init];

    left.delegate = self;

    
[self presentViewController:left animated:YES completion:^{
    
}];

    
    
    
    
    
}


-(void)xiarightbtn:(NSNotification *)not{


    
    //系统封装动画
//    CATransition *animation = [CATransition animation];
//    //设置运动轨迹的速度
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    //设置动画类型为立方体动画
//    animation.type = @"SuckEffect";
//    //设置动画时长
//    animation.duration =0.5f;
//    //设置运动的方向
//    animation.subtype =kCATransitionFromRight;
//    //控制器间跳转动画
//    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    
    RightViewController *rigvc = [[RightViewController alloc]init];
    //这条注释是由于添加广告是sy界面已经提前完成所以不需要了

    rigvc.delegate = self;
    rigvc.modalTransitionStyle =UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:rigvc animated:YES completion:^{
        
    }];
    
    




}
//右边代理
-(void)rightvcWithmodel:(SoucangModel *)model{
     
    
  
        
        xiaview.songArr1 = [[NSMutableArray alloc]init];
        xiaview.songImageArr1 = [[NSMutableArray alloc]init];
//
        xiaview.songNameArr1 = [[NSMutableArray alloc]init];
        xiaview.songAuthorArr1 = [[NSMutableArray alloc]init];
////

        NSString *songurl = model.genUrl;
   
        
        [xiaview.songArr1 addObject:songurl];

        [xiaview.songImageArr1 addObject:model.imageName];
        
        NSString *name =model.genming;
        
        [xiaview.songNameArr1 addObject:name];
        
        [xiaview.songAuthorArr1  addObject:model.genshou];
        [xiaview  addPlayerViewandSongUrlArr:xiaview.songArr1 andSongImageArr:xiaview.songImageArr1];
        
   
        

    

}

//左边代理
-(void)leftDataarray:(NSMutableArray *)array{

    
   
    
    xiaview.songArr1 = [[NSMutableArray alloc]init];
    xiaview.songImageArr1 = [[NSMutableArray alloc]init];

//    
    xiaview.songNameArr1 = [[NSMutableArray alloc]init];
    xiaview.songAuthorArr1 = [[NSMutableArray alloc]init];
//
    for (NSInteger i=0; i<array.count; i++) {
        
        LeftTwoModel *model = array[i];
        
//        NSLog(@"%@",model.ID);
        [xiaview.songNameArr1 addObject:model.SN];
        [xiaview.songAuthorArr1 addObject:model.S];
        [xiaview.songArr1 addObject:model.ID];
        [xiaview.songImageArr1 addObject:model.SK];
      

        
    }
  [xiaview  addPlayerViewandSongUrlArr:xiaview.songArr1 andSongImageArr:xiaview.songImageArr1];

}



//清扫通知
-(void)xiaqingshao:(NSNotification *)not{

    NSDictionary *dic= not.userInfo;
    
    NSInteger idex =[dic[@"tag"]integerValue];
    
    if (idex==1) {
       
       
        //弹簧效果参数1动画持续时间，2延迟几秒，3动画祝你细数，4动画开始速度，5动画效果参数
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
//UIViewAnimationOptionCurveEaseIn
              CGFloat xxianviewy = (kDevice_Is_iPhoneX)?69:49;
          xiaview.view.frame = CGRectMake(0,self.view.frame.size.height-xxianviewy, self.view.frame.size.width, 49);
        } completion:^(BOOL finished) {
          
            
            
            
        }];
        
        
        

        
    }


}
//导航4个按钮点击通知
-(void)des:(NSNotification *)not
{
    
    NSDictionary *dic= not.userInfo;
    
    NSInteger idex =[dic[@"tag"]integerValue];
       pandandiyici= idex;
    switch (idex) {
        case 0:{
          
           // HeadView *hadeviw = [self.view viewWithTag:800];
           // [hadeviw removeFromSuperview];
            
            [_dataArray removeAllObjects];
           // [_headArray removeAllObjects];
            
            
            _currentpage=1;
            [self loadDataOr:YES];
       
            self.tableView.contentInset = UIEdgeInsetsMake(IMAGEHEIGHT, 0, 0, 0);  // 应用启动, 滚动到最顶部,显示额外的头部视图
            [self.tableView setContentOffset:CGPointMake(0, -IMAGEHEIGHT)];
            
            [self.tableView reloadData];
            self.headview.hidden =NO;
        }
            break;
        case 1:
        
        {
        [_dataArray removeAllObjects];

              _currentpage=1;
            NSString *yiwen =[NSString stringWithFormat:SOUYE_YEWEN_URL,(long)_currentpage];
          
            [self loadhettpPostUrl:yiwen];
            
         [self.tableView reloadData];
            
           self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);  // 应用启动, 滚动到最顶部,显示额外的头部视图
            
           self.tableView.frame = CGRectMake(0, 3, self.view.frame.size.width, self.view.frame.size.height);
            self.headview.hidden=YES;
            //HeadView *hadeviw = [self.view viewWithTag:800];
           // [hadeviw removeFromSuperview];
            
        }
            
         break;
        case 2:{
            
            
           [_dataArray removeAllObjects];
//            //           NSDictionary *dic = @{@"sumPage":@"0",@"tag":@"main"};
          _currentpage=1;
           NSString *yiwen =[NSString stringWithFormat:SOUYE_LVXING_URL,(long)_currentpage];
//            
          [self loadhettpPostUrl:yiwen];
//            
          [self.tableView reloadData];
//            
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);  // 应用启动, 滚动到最顶部,显示额外的头部视图
//            
           self.tableView.frame = CGRectMake(0, 3, self.view.frame.size.width, self.view.frame.size.height);
            self.headview.hidden=YES;
           
            

           
        }  break;
        case 3:{
           _currentpage=1;
            NSString *a =[NSString stringWithFormat:SOUYE_ZUIHOU_URL,(long)_currentpage];
           [_dataArray removeAllObjects];

            [self lastdata1:a];
            
            [self.tableView reloadData];
            
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);  // 应用启动, 滚动到最顶部,显示额外的头部视图
           
            self.tableView.frame = CGRectMake(0, 15, self.view.frame.size.width, self.view.frame.size.height);
            self.headview.hidden=YES;
           

            
            
        } break;
              default:
            break;
    }
    
    
    

[self tab:_btn];
    
    
}
//最后一个界面
-(void)lastdata1:(NSString *)lasturl{

//    HttpManager *manger =[HttpManager shareManager]
    
    AFHTTPSessionManager *manger =[AFHTTPSessionManager manager];
    
    [manger GET:lasturl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.tableView.mj_footer endRefreshing];
        
        if (_currentpage==1) {
            
            
            [_dataArray removeAllObjects];
        }
        
        NSArray *a =responseObject;
        for (NSDictionary *dic in a) {
            
            SouYeModel *model1 =[[SouYeModel alloc]initWithDictionary:dic error:nil];
            [_dataArray addObject:model1];
            
        }
//        NSLog(@"%@",_dataArray);
        [self.tableView reloadData];

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}








//艺文和旅行界面网络请求
-(void)loadhettpPostUrl:(NSString *)posturl{

    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   [manager GET:posturl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//       NSLog(@"%@dd",responseObject);
       [self.tableView.mj_footer endRefreshing];
       
       if (_currentpage==1) {
           
           
           [_dataArray removeAllObjects];
       }
       
       
       
       NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
       NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"data(" withString:@""];
       NSString *s =[strUrl stringByReplacingOccurrencesOfString:@")" withString:@""];
       
       
       NSMutableArray *dict = [NSJSONSerialization JSONObjectWithData:[s dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//       NSLog(@"%@",dict);
       
       for (NSDictionary *dic in dict) {
           
           SouYeModel *model =[[SouYeModel alloc]initWithDictionary:dic error:nil];
           
           [self.dataArray addObject:model];
           
       }
       

       [self.tableView reloadData];
       
       
       
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
     [self.tableView.mj_footer endRefreshing];
       NSLog(@"%@",error);
   }];
    
 
    
    
    
    
}

-(void)addRefreshHeader:(BOOL)ishavHeader andHaveFooter:(BOOL) havFooter
{
    //风格要一致,要么用block,要么用第一个
    if (ishavHeader) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        //这个是开始加载数据
        [self.tableView.mj_header beginRefreshing];
    }
    if(havFooter){

        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        
        //        tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        //这个是开始加载数据
        [self.tableView.mj_footer beginRefreshing];
        
        
        
        
    
    }


}

////加载跟多
-(void)loadMore{

    
    
    if (pandandiyici==0) {
        _currentpage++;
        [self loadDataOr:YES];
    }if (pandandiyici==1) {
        
        _currentpage++;
        
        NSString *cpage = [NSString stringWithFormat:SOUYE_YEWEN_URL,(long)_currentpage];

        [self loadhettpPostUrl:cpage];
  
        
    }if (pandandiyici==2) {
        
        _currentpage++;
        
        NSString *cpage = [NSString stringWithFormat:SOUYE_LVXING_URL,(long)_currentpage];
 
        [self loadhettpPostUrl:cpage];
        
        
        
    }if (pandandiyici==3) {

        _currentpage++;
        NSString *a =[NSString stringWithFormat:SOUYE_ZUIHOU_URL,(long)_currentpage];

        [self lastdata1:a];
  
        
    }
  }
//详情页面毁掉
-(void)xiangqinggequUrl:(NSString *)url andxiangqinggequimage:(NSString *)imagestr andxiangqinggeming:(NSString *)geming andxiangqinggeshou:(NSString *)geshou andxiangqingtrok_id:(NSString *)trok_id{


    
    xiaview.songArr1 = [[NSMutableArray alloc]init];
    xiaview.songImageArr1 = [[NSMutableArray alloc]init];
     xiaview.songNameArr1 = [[NSMutableArray alloc]init];
    xiaview.songAuthorArr1 = [[NSMutableArray alloc]init];
    xiaview.trok_idarray = [[NSMutableArray alloc]init];
    //

        [xiaview.songArr1 addObject:url];
        NSString *url1 = [NSString stringWithFormat:@"%@",imagestr];
        
        [xiaview.songImageArr1 addObject:url1];
        
       NSString *name =geming;

       [xiaview.songNameArr1 addObject:name];

       [xiaview.songAuthorArr1  addObject:geshou];
         [xiaview.trok_idarray addObject:trok_id];

    [xiaview  addPlayerViewandSongUrlArr:xiaview.songArr1 andSongImageArr:xiaview.songImageArr1];

   
}

- (CGRect)buttonFrame{
    return souyebtn.frame;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
