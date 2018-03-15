//
//  LeftViewController.m
//  Music
//
//  Created by ljl on 17/4/5.
//  Copyright © 2017年 李金龙. All rights reserved.
//


#define SONGFIELD @"ID%2CSN%2CSK%2CSW%2CSS%2CST%2CSI%2CCT%2CM%2CS%2CZQ%2CWO%2CZC%2CHY%2CYG%2CCK%2CD%2CRQ%2CDD%2CE%2CR%2CRC%2CSG%2CC%2CCS%2CLV%2CLG%2CSY%2CUID%2CPT%2CSCSR%2CSC"

#define USERFIELD @"ID%2CNN%2CI%2CB%2CP%2CC%2CSX%2CE%2CM%2CVT%2CCT%2CTYC%2CTFC%2CTBZ%2CTFD%2CTFS%2CSC%2CYCRQ%2CFCRQ%2CCC%2CBG%2CDJ%2CRC%2CMC%2CAU%2CSR%2CSG%2CVG%2CISC%2CF"

#define URL @"http://mobileapi.5sing.kugou.com/song/getsonglistsong?id=%@&songfields=%@&userfields=%@&version=6.5.20"




///宽的比例
#define RATE SCREEN_WIDTH/320.0
//屏幕的宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


//自定义颜色
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


#import "LeftViewController.h"
#import "LazyFadeInView.h"
#import "AFNetworking.h"
#import "HttpManager.h"
#import "LeftBtn.h"
#import "LeftModel.h"
#import "LeftTwoModel.h"
#import "XiaViewController.h"
#import "huayuanview.h"

#import "FavoriteManager.h"

#import "QXViewController.h"



#import "MBProgressHUD.h"

#import "AppDelegate.h"

#import "XWInteractiveTransition.h"
#import "XWCircleSpreadTransition.h"


#import "AppPayManager.h"
#import <StoreKit/StoreKit.h>

@interface LeftViewController ()<LazyFadeInViewDelegate,MBProgressHUDDelegate,UIViewControllerTransitioningDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property(nonatomic,strong)UIScrollView *svc;
@property(nonatomic,strong)LeftBtn *btn;

@property (assign, nonatomic) BOOL flag;
@property(nonatomic,strong)NSMutableArray *btnsarray;
@property(nonatomic,strong)NSMutableArray *setlebtnsgeneid;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSTimer *time;
@property(nonatomic,strong)CAShapeLayer *shapelayer;
@property(nonatomic,strong)huayuanview *xianview;

@property(nonatomic,strong)MBProgressHUD *hud;
@property (nonatomic, strong) XWInteractiveTransition *interactiveTransition;
@end

@implementation LeftViewController
{
    UIButton *lastbtn;
    NSInteger dianjibtnindex;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _setlebtnsgeneid = [[NSMutableArray alloc]init];
    _btnsarray = [[NSMutableArray alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
    [self configUILable];
    
    [self loadDatabtns];
    
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];

    [self addBarBtnItemWithTitle:nil withImageName:@"SettingBack@2x" withPosition:1];
    [self addBarBtnItemWithTitle:@"确定" withImageName:@"" withPosition:2];
    

    
      self.interactiveTransition = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypeDismiss GestureDirection:XWInteractiveTransitionGestureDirectionDown];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    
    AppDelegate *delegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    
    [delegate.window addSubview:self.view];
    
}



-(void)configUILable{
 CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);

    LazyFadeInView *fade = [[LazyFadeInView alloc] initWithFrame:CGRectMake(85*RATE, 100, screenWidth - 170*RATE, 80)];
    fade.delegate = self;
    fade.textColor = [UIColor whiteColor];
   
    if (self.view.frame.size.width>320&&self.view.frame.size.width<400) {
        
       
        fade.textFont = [UIFont systemFontOfSize:18];
    }if (self.view.frame.size.width>400) {
       fade.textFont = [UIFont systemFontOfSize:20];
     
        
    }else{
        
         fade.textFont = [UIFont systemFontOfSize:15];
       

    }
   
    fade.text = @"选择你感兴趣的曲风我们将为你推荐最合拍的音乐";
    [self.view addSubview:fade];

   

 

    

    


}
-(void)loadDatabtns{
    


    
    
    NSArray *ar =@[@"国语",@"粤语",@"欧美",@"日本",@"韩国",@"摇滚",@"民谣",@"电子",@"爵士",@"睡前",@"看书",@"流行",@"中元节",@"治愈系",@"初音",@"思念",@"梦境",@"原创",@"欧尚",@"古风",@"青春",@"思念",@"安静",@"日系",@"吉他",@"伤感"];
    //
    NSArray *idar =@[@"589d88ccdaf0a31ae81ef0ec",@"573f3296daf0a30bec720ce5",@"57b0832adaf0a3105ce228e4",@"58be1527daf0a31854330bf8",@"570f4b50482b86371825430f",@"57056066482b8612d877fe86",@"58c25094daf0a3197c7980b3",@"57750513daf0a31efc4f68b7",@"56cd1f98482b862688852e08",@"57f11c66daf0a32360dd73a9",@"5922af6dc639546a7baebc23",@"592f9418c639546cdaee7d2f",@"55d9e067482b861d6c76b35d",@"59acc33dc63954cbbe1b1b07",@"599ad0e2b0f5ba76fc2e9e26",@"59968b07c639549abae0b679",@"56fd5ded482b8646c43b2f31",@"59884b96c63954f4be5e32ff",@"5968f466c639546f02363160",@"5982e312da767ff3567a11d4",@"596ca193c6395491338ab600",@"576394b7daf0a30d08f0afb9",@"5976b38f8788adec7a1f8f30",@"59612da6c63954b712e83d09",@"584d48c2daf0a30cc899bae4",@"58c7ca62daf0a30a9008e69e"];


    for (NSInteger i=0; i<ar.count; i++) {
        LeftModel *model = [[LeftModel alloc]init];
        model.geneName= ar[i];
        model.geneId=idar[i];
        
        
        [_btnsarray addObject:model];
        
    }

    [self cofigUIBtns];

}
-(void)cofigUIBtns{


    
    
    
    
    

    _svc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2-70, self.view.frame.size.width, 250)];
    _svc.tag=500;

    for (NSInteger i=0; i<_btnsarray.count; i++) {
        if (i%2==0) {
            _btn = [[LeftBtn alloc]initWithFrame:CGRectMake(20+(60*i),30, 50,50)];
            
            
        }else{

            
            _btn = [[LeftBtn alloc]initWithFrame:CGRectMake(37+(60*i), 100, 50, 50)];
        

        }
        NSString *btntitle;
        LeftModel *model = _btnsarray[i];
        if (model.geneName.length>3) {
            
        
           btntitle=[model.geneName substringToIndex:2];
            _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        }else{
            btntitle=model.geneName;
         _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
       
        
        [_btn setTitle:btntitle forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
        _btn.tag = 100+i;
        _btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btn addTarget:self action:@selector(leftbtns:) forControlEvents:UIControlEventTouchUpInside];
        [_svc addSubview:_btn];
        

        
            
        }
    
         _svc  .showsHorizontalScrollIndicator =NO;
    _svc.showsVerticalScrollIndicator = NO;
    _svc.pagingEnabled = YES;
//    _svc.delegate =self;
    _svc.bounces =NO;
    _svc.clipsToBounds=YES;


   _svc.contentSize =CGSizeMake(_btnsarray.count*63, 180);
    [self.view addSubview:_svc];
    
    
    
    
    
    
    

    
    
//   _time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeOn) userInfo:nil repeats:NO];
//

    
    
}
-(void)timeOn
{
  
    
    _xianview =[[huayuanview alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height-200, 150, 150)];

    [self.view addSubview:_xianview];
    
    
   

    
}
-(void)xiantap:(UITapGestureRecognizer *)tap{

   
    QXViewController *qx =[[QXViewController alloc]init];
    [self presentViewController:qx animated:YES completion:nil];


}

-(void)leftbtns:(LeftBtn *)btn{

    
    for (UIButton *btn in _svc.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            
            btn.backgroundColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
        
               [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.selected = NO;
            LeftModel *model = _btnsarray[btn.tag-100];
            
               [_setlebtnsgeneid removeObject:model.geneId];
            //
            
            

        }
    }
   
    btn.selected = YES;
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    LeftModel *model = _btnsarray[btn.tag-100];
    dianjibtnindex = btn.tag;
    [_setlebtnsgeneid addObject:model.geneId];
    
    
    
    
    //抖动效果
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [btn.layer addAnimation:animation forKey:nil];
 
    
    
}









- (void)fadeInAnimationDidEnd:(LazyFadeInView *)fadeInView
{

    
}


-(void)leftClick{

[self dismissViewControllerAnimated:YES completion:^{
    
    [self.view removeFromSuperview];
    
}];


}
-(void)rightClick{


    if (_setlebtnsgeneid.count==0) {
        
     
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        _hud.mode = MBProgressHUDModeText;
        _hud.label.text = @"你还没选择歌曲类型选择一个试听一下";
        _hud.label.font = [UIFont systemFontOfSize:13];
        
        _hud.label.textColor = [UIColor lightGrayColor];
        
        _hud.bezelView.color = [UIColor whiteColor];
        
        [_hud hideAnimated:YES afterDelay:2.0];
        
        
        
    }else{
    
        if (dianjibtnindex>100) {
            //判断
            NSString *key = [NSString stringWithFormat:@"appidsting"];
            NSString *appidsting=[[NSUserDefaults standardUserDefaults] valueForKey:key];
            if ([appidsting isEqualToString:@"jianyinyue6"]) {
                [self cfingMBhud];
                
            }else{
            
            
            UIAlertController *alervc = [UIAlertController alertControllerWithTitle:@"解锁框" message:@"支持原创内容\n支付6元解锁所有付费节目解锁后会自动为你提升音质\n\n 如你已经购买过，你可以点击恢复购买来解锁" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            UIAlertAction *woyaogoumai = [UIAlertAction actionWithTitle:@"我要购买" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _hud.mode = MBProgressHUDModeIndeterminate;
                _hud.removeFromSuperViewOnHide=NO;
                _hud.label.text = @"支付中";
                _hud.bezelView.color = [UIColor blackColor];
                //监听购买回调：比如失败，完成，是否购买过
                
                if([SKPaymentQueue canMakePayments]){
                    NSArray *product = [[NSArray alloc] initWithObjects:@"jianyinyue6",nil];
                    NSSet *nsset = [NSSet setWithArray:product];
                    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
                       [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
                    request.delegate = self;
                    [request start];
                }else{
                
                    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    _hud.mode =  MBProgressHUDModeText;
                    _hud.removeFromSuperViewOnHide=NO;
                    _hud.label.text = @"哦哦，没有购买权限";
                    _hud.bezelView.color = [UIColor blackColor];

//                    NSLog(@"不允许购买");
                
                }
                
            }];
            UIAlertAction *huifu = [UIAlertAction actionWithTitle:@"恢复购买" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                //恢复购买逻辑
                _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _hud.mode = MBProgressHUDModeIndeterminate;
                _hud.removeFromSuperViewOnHide=NO;
                     _hud.label.text = @"正在恢复购买……";
                _hud.bezelView.color = [UIColor blackColor];
                
                [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
              [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
                
            }];
            [alervc addAction:quxiao];
            [alervc addAction:woyaogoumai];
            [alervc addAction:huifu];
            [self presentViewController:alervc animated:YES completion:nil];
    
            }
            
        }else{
            [self cfingMBhud];
        }
    }
}
-(void)hudWasHidden:(MBProgressHUD *)hud{
    
    

       NSString *str = _setlebtnsgeneid[0];

    [self rightLoadData:str];
    


}

-(void)rightLoadData:(NSString *)dic{
    
    
    
    HttpManager *manger =[HttpManager shareManager];
    NSString *url =[NSString stringWithFormat:URL,dic,SONGFIELD,USERFIELD];
    [manger requestWithUrl:url withDictionary:nil withSuccessBlock:^(id responseObject) {
//       NSLog(@"%@",responseObject);
        
        NSArray *Dataar =responseObject[@"data"];
        for (NSDictionary *leftdic in Dataar) {
                        LeftTwoModel *model =[[LeftTwoModel alloc]initWithDictionary:leftdic error:nil];
          
            [_dataArray addObject:model];

            
        }
        if (_dataArray.count>0) {
            

                             [self dismissViewControllerAnimated:YES completion:^{
            
                                [self.delegate leftDataarray:[_dataArray copy]];
            
                             }];
            
                            }else{
            
                                _hud.mode = MBProgressHUDModeCustomView;
            
                                _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NetworkUnusual@2x"]];
            
                                _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
                                _hud.contentColor= [UIColor clearColor];
                                _hud.bezelView.backgroundColor = [UIColor clearColor];
            
                                [_hud hideAnimated:YES afterDelay:1.5];
            
                            }

        
    } withFailureBlock:^(NSError *error) {
        
        
        
    }];
    
    
    
    
    
    
    





}


//自定义专场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [XWCircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [XWCircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypeDismiss];
}



- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}



#pragma mark--内购代理
//收到产品返回信息这个时获取苹果服务器的产品列表根据id来的
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
//    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        //        [SVProgressHUD dismiss];
//        NSLog(@"--------------没有商品------------------");
        return;
    }
    
//    NSLog(@"productID:%@", response.invalidProductIdentifiers);
//    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        
        
        if([pro.productIdentifier isEqualToString:@"jianyinyue6"]){
            p = pro;
        }
    }
    
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
//    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
//    _hud.hidden = YES;
    
}



//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    //    [SVProgressHUD showErrorWithStatus:@"支付失败"];
     _hud.hidden = YES;
//    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    //    [SVProgressHUD dismiss];
//    NSLog(@"------------反馈信息结束-----------------");
}
//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"
//
-(void)verifyPurchaseWithPaymentTransaction{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    
    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
    
    NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //创建请求到苹果官方进行购买验证
    NSURL *url=[NSURL URLWithString:AppStore];
    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
    requestM.HTTPBody=bodyData;
    requestM.HTTPMethod=@"POST";
    //创建连接并发送同步请求
    NSError *error=nil;
    NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
    if (error) {
       NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
        
        
        return;
    }
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",dic);
    if([dic[@"status"] intValue]==0){
//        NSLog(@"购买成功！");
//验证过

        NSDictionary *dicReceipt= dic[@"receipt"];
        NSDictionary *dicInApp=[dicReceipt[@"in_app"] firstObject];
        NSString *productIdentifier= dicInApp[@"product_id"];//读取产品标识
        //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if ([productIdentifier isEqualToString:@"jianyinyue6"]) {

            
//            以后确认购买成功了
            [self cfingMBhud];
            [[NSUserDefaults standardUserDefaults] setValue:productIdentifier forKey:@"appidsting"];
             [[NSUserDefaults standardUserDefaults]synchronize];
        }else{
            [defaults setBool:YES forKey:productIdentifier];
        }
        //在此处对购买记录进行存储，可以存储到开发商的服务器端
    }else{
        
        
        //从沙盒中获取交易凭证并且拼接成请求体数据
        NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
        NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
        
        NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
        
        NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
        NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        
        
        //创建请求到苹果官方进行购买验证
        NSURL *url=[NSURL URLWithString:SANDBOX];
        NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
        requestM.HTTPBody=bodyData;
        requestM.HTTPMethod=@"POST";
        //创建连接并发送同步请求
        NSError *error=nil;
        NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
        if (error) {
            NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
            
            
            return;
        }
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        if([dic[@"status"] intValue]==0){
            //        NSLog(@"购买成功！");
            //验证过
            _hud.hidden = YES;
            NSDictionary *dicReceipt= dic[@"receipt"];
            NSDictionary *dicInApp=[dicReceipt[@"in_app"] firstObject];
            NSString *productIdentifier= dicInApp[@"product_id"];//读取产品标识
            //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            if ([productIdentifier isEqualToString:@"jianyinyue6"]) {
                
                //            以后确认购买成功了
                [self cfingMBhud];
                [[NSUserDefaults standardUserDefaults] setValue:productIdentifier forKey:@"appidsting"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }else{
                [defaults setBool:YES forKey:productIdentifier];
            }
        }else{
                _hud.hidden = YES;
        
        }
        
           }

}
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:{
//                NSLog(@"交易完成");
                _hud.hidden = YES;
                // 发送到苹果服务器验证凭证
                [self verifyPurchaseWithPaymentTransaction];
               [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
//                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:{
//                NSLog(@"已经购买过商品");
                _hud.hidden= YES;
             [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:{
//                NSLog(@"交易失败%@",tran);
//                  [self verifyPurchaseWithPaymentTransaction];
                _hud.hidden = YES;
    [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            default:
                break;
        }
    }
}
//可以知道恢复购买购买了哪些东西这里可以喝服务器做交互
-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    
    
    NSMutableArray *ar = [[NSMutableArray alloc] init];
    NSLog(@"received restored transactions: %lu", (unsigned long)queue.transactions.count);
    //没有购买过
    if (queue.transactions.count==0) {
        _hud.hidden = YES;
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode =  MBProgressHUDModeText;
        _hud.removeFromSuperViewOnHide=NO;
        _hud.label.text = @"哦哦，你还没购买过此项目，赶快去购买吧！";
        _hud.bezelView.color = [UIColor blackColor];
        [_hud hideAnimated:YES afterDelay:2.0];
    }
    //购买过
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        NSString *productID = transaction.payment.productIdentifier;
        [ar addObject:productID];

        
        [[NSUserDefaults standardUserDefaults] setValue:ar[0] forKey:@"appidsting"];
         [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self cfingMBhud];
    }
    
    
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
//    NSLog(@"交易结束");
    _hud.hidden = YES;
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
-(void)cfingMBhud{

    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeText;
    _hud.label.text = @"正在创建播放列表，稍等……";
    _hud.label.font = [UIFont systemFontOfSize:13];
    _hud.label.textColor = [UIColor lightGrayColor];
    _hud.bezelView.color = [UIColor whiteColor];
    _hud.delegate = self;
    [_hud hideAnimated:YES afterDelay:3.0];


}



@end
