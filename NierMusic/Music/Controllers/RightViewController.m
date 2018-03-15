//
//  RightViewController.m
//  Music
//
//  Created by ljl on 17/4/5.
//  Copyright © 2017年 李金龙. All rights reserved.
//
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#import "RightViewController.h"
#import "FenLeiView.h"
#import "DTandSCViewController.h"
#import "SouCangManager.h"
#import "WenzhangManager.h"


#import "UIImageView+WebCache.h"

#import "YijianORXieYiViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"


#import "AppPayManager.h"

#import <StoreKit/StoreKit.h>

@interface RightViewController ()<DtandDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property(nonatomic,strong)UIButton *leftbtn;
@property(nonatomic,assign)BOOL isshar;

@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,assign)NSInteger is_iponex_statusheight;
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    [self configUINavBarItem];
    
    [self cifingUIbtns];
}
-(void)viewDidAppear:(BOOL)animated{


        AppDelegate *delegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    
    
    [delegate.window addSubview:self.view];
    
}
-(void)configUINavBarItem{
    UIView *view = [[UIView alloc]init];
    if (kDevice_Is_iPhoneX == YES) {
        
        _is_iponex_statusheight = 34;
    }else{
        _is_iponex_statusheight = 0;
    }
   view.frame = CGRectMake(0, _is_iponex_statusheight, self.view.frame.size.width, 49);
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
    [self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width/2-20, 0, 40, 49)];
    lable.text =@"设置";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:19];
    [view addSubview:lable];
    
    _leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 49)];
    [_leftbtn setImage:[UIImage imageNamed:@"SettingBack@2x"] forState:UIControlStateNormal];
    [_leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_leftbtn];
    

}

-(void)cifingUIbtns{


    NSArray *ar = @[@"红心电台",@"文章收藏"];
    NSArray *imagar = @[@"LikeSongBtnImg",@"ArticleCollectionBtn"];

    for (NSInteger i=0; i<imagar.count; i++) {
        
        UIView *view = [[FenLeiView alloc]withLabelTitle:ar[i] congifImageviewName:imagar[i] withframe:CGRectMake(0+i*(self.view.frame.size.width/2), 48+_is_iponex_statusheight, self.view.frame.size.width/2+1, self.view.frame.size.width/2)];
        view.tag=100+i;
        
        [self.view addSubview:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
    }


    
    
    NSArray *btnsar = @[@"清除缓存",@"意见反馈"];
    for (NSInteger i=0; i<btnsar.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0+i*(self.view.frame.size.width/2), self.view.frame.size.width/2+47+_is_iponex_statusheight, self.view.frame.size.width/2+1,self.view.frame.size.width/4)];
        
        [btn setTitle:btnsar[i] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        btn.tag=200+i;
        
        btn.layer.cornerRadius = 4;
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor =[UIColor lightGrayColor].CGColor;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
    }
    
    NSArray *btnsar1 = @[@"解锁音乐",@"恢复购买"];
    for (NSInteger i=0; i<btnsar1.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0+i*(self.view.frame.size.width/2),(self.view.frame.size.width/2+47+_is_iponex_statusheight)+(self.view.frame.size.width/4), self.view.frame.size.width/2+1,self.view.frame.size.width/4)];
        
        [btn setTitle:btnsar1[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        btn.tag=300+i;
        
        btn.layer.cornerRadius = 4;
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor =[UIColor lightGrayColor].CGColor;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
    }

    
    
    
    
    
    UIButton *yonghubtn = [[UIButton alloc]initWithFrame:CGRectMake(0,self.view.frame.size.width+(self.view.frame.size.width/4)-(47-_is_iponex_statusheight), self.view.frame.size.width,80)];
    yonghubtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [yonghubtn setTitle:@"用户协议" forState:UIControlStateNormal];
    [yonghubtn setTitleColor:[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [yonghubtn addTarget:self action:@selector(yongbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yonghubtn];

    yonghubtn.layer.masksToBounds = YES;
 yonghubtn.titleLabel.font = [UIFont systemFontOfSize:15];

    
    UIView *xianview = [[UIView alloc]initWithFrame:CGRectMake(0, yonghubtn.frame.origin.y+yonghubtn.frame.size.height, self.view.frame.size.width,1)];
    xianview.backgroundColor  = [UIColor lightGrayColor];
    
    [self.view addSubview:xianview];
    
    UIImageView *iamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4,yonghubtn.frame.origin.y+yonghubtn.frame.size.height+6, self.view.frame.size.width/2,self.view.frame.size.width/2)];
    
    iamgeview.image =[UIImage imageNamed:@"33"];
  
//        iamgeview.layer.cornerRadius = 90;
//        iamgeview.layer.borderWidth = 2.0;
//       iamgeview.layer.masksToBounds = YES;
//        iamgeview.layer.borderColor =[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0].CGColor;
//    //    yonghubtn.layer.cornerRadius = 1;
//    //    yonghubtn.layer.borderWidth = 0.7;
//    //    yonghubtn.layer.borderColor =[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0].CGColor;
//
////    iamgeview.layer.cornerRadius = 2;
////    iamgeview.layer.borderWidth = 0.7;
////    iamgeview.layer.borderColor =[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0].CGColor;
////    iamgeview.layer.masksToBounds = YES;
//    [self.view addSubview:iamgeview];
    
    

}
-(void)btn:(UIButton *)btn{

    if (btn.tag==200) {
      NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches"];
        [self clearCache:path];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      
      hud.mode = MBProgressHUDModeCustomView;
        
        hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CacheClearSuccess"]];
//        hud.bezelView.color = [UIColor whiteColor];
        
//       hud.delegate =self;
//        [hud show:YES];
//        [hud hide:YES afterDelay:3];
        
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.contentColor= [UIColor clearColor];
        hud.bezelView.backgroundColor = [UIColor clearColor];
        
        
        
        
//        hud.contentColor= [UIColor clearColor];
     
       [hud hideAnimated:YES afterDelay:1];
        
        
        
           }else{
    
        YijianORXieYiViewController *yivc = [[YijianORXieYiViewController alloc]init];
        yivc.str = @"意见反馈";
        yivc.yijianORxieyi = 0;
        [self presentViewController:yivc animated:YES completion:^{
            
        }];
       
    
    }







}
//购买和恢复购买
-(void)btn1:(UIButton *)btn{

    if (btn.tag==300) {
        
        
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

        [alervc addAction:quxiao];
        [alervc addAction:woyaogoumai];

        [self presentViewController:alervc animated:YES completion:nil];
       
    }else{
    
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    _hud.mode = MBProgressHUDModeIndeterminate;
                    _hud.removeFromSuperViewOnHide=NO;
                    _hud.label.text = @"正在恢复购买……";
                    _hud.bezelView.color = [UIColor blackColor];
                    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
                    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    }

    
}





//清理缓存文件
-(void)clearCache:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
//   [[SDImageCache sharedImageCache] cleanDisk];
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:nil];
}

-(void)yongbtn{

    YijianORXieYiViewController *yivc = [[YijianORXieYiViewController alloc]init];
    yivc.str = @"用户协议";
    yivc.yijianORxieyi = 1;
    [self presentViewController:yivc animated:YES completion:^{
        
    }];

    


}
-(void)tap:(UITapGestureRecognizer *)tap{
    if (tap.view.tag==100) {
        
        NSArray *ar = [[SouCangManager manager]allModels];
        if (ar.count<=0) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"里面还没有内容";
            hud.detailsLabel.text = @"赶快去挑选喜欢的曲歌吧";
            hud.label.textColor = [UIColor lightGrayColor];
            hud.detailsLabel.textColor = [UIColor lightGrayColor];
//            hud.animationType = MBProgressHUDAnimationZoomIn;
            hud.bezelView.color = [UIColor whiteColor];
            
            //       hud.delegate =self;
            //        [hud show:YES];
            //        [hud hide:YES afterDelay:3];
//            hud.contentColor= [UIColor clearColor];
            
            [hud hideAnimated:YES afterDelay:1.5];

            
            
           
            
        }else{
        DTandSCViewController *dianvc = [[DTandSCViewController alloc]init];
        dianvc.DianORWen = 0;
            dianvc.delegate = self;
        dianvc.titlestr = @"红心电台";
            
//            AppDelegate *delegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
            
            
            [self presentViewController:dianvc animated:YES completion:^{
                
            }];
            
   
            
//     
//       [self presentViewController:dianvc animated:YES completion:^{
//           
//           
//       }];
        }
    }else{
        
        NSArray *ar1 = [[WenzhangManager manager]allModels];
        if (ar1.count<=0) {
            
          
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"还没有收藏的文章";
            hud.detailsLabel.text = @"赶快去收藏吧";
            hud.label.textColor = [UIColor lightGrayColor];
            hud.detailsLabel.textColor = [UIColor lightGrayColor];
            //            hud.animationType = MBProgressHUDAnimationZoomIn;
            hud.bezelView.color = [UIColor whiteColor];
            
            //       hud.delegate =self;
            //        [hud show:YES];
            //        [hud hide:YES afterDelay:3];
            //            hud.contentColor= [UIColor clearColor];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            
            
        }else{
        
        DTandSCViewController *dianvc = [[DTandSCViewController alloc]init];
        dianvc.DianORWen = 1;
        dianvc.titlestr = @"文章收藏";
        
        [self presentViewController:dianvc animated:YES completion:^{
            
            
        }];}
        
    
    }




}
-(void)DtandSCwithmodel:(SoucangModel *)model
{


    [self.delegate rightvcWithmodel:model];

}

-(void)leftClick{



[self dismissViewControllerAnimated:YES completion:^{
    
    
    
    }];


}


#pragma 内购
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
        //        NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
        
        
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
            
            _hud.hidden = YES;
            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            _hud.mode =  MBProgressHUDModeText;
            _hud.removeFromSuperViewOnHide=NO;
            _hud.label.text = @"已成功购买，可以解锁全部音乐啦";
//            _hud.bezelView.color = [UIColor blackColor];
            [_hud hideAnimated:YES afterDelay:3.0];

            
            //            以后确认购买成功了
//            [self cfingMBhud];
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
//        NSLog(@"%@",dic);
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
                _hud.hidden = YES;
                _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _hud.mode =  MBProgressHUDModeText;
                _hud.removeFromSuperViewOnHide=NO;
                _hud.label.text = @"已成功购买，可以解锁全部音乐啦";
                //            _hud.bezelView.color = [UIColor blackColor];
                [_hud hideAnimated:YES afterDelay:3.0];

                //            以后确认购买成功了

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
//    NSLog(@"received restored transactions: %lu", (unsigned long)queue.transactions.count);
    
    if (queue.transactions.count==0) {
        _hud.hidden = YES;
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode =  MBProgressHUDModeText;
        _hud.removeFromSuperViewOnHide=NO;
        _hud.label.text = @"哦哦，你还没购买过此项目，赶快去购买吧！";
        _hud.bezelView.color = [UIColor blackColor];
        [_hud hideAnimated:YES afterDelay:2.0];
    }
    
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        NSString *productID = transaction.payment.productIdentifier;
        [ar addObject:productID];
        
        [[NSUserDefaults standardUserDefaults] setValue:ar[0] forKey:@"appidsting"];
        [[NSUserDefaults standardUserDefaults]synchronize];
       _hud.hidden = YES;
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.mode =  MBProgressHUDModeText;
        _hud.removeFromSuperViewOnHide=NO;
        _hud.label.text = @"已成功恢复购买啦，可以去听歌啦";

        [_hud hideAnimated:YES afterDelay:3.0];

        
    }
    
    
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
 
    _hud.hidden = YES;
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
