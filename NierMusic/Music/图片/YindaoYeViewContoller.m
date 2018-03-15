//
//  YindaoYeViewContoller.m
//  MoverApp
//
//  Created by ljl on 17/3/27.
//  Copyright © 2017年 李金龙. All rights reserved.
//



//屏幕的宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//宽的比例
#define RATE SCREEN_WIDTH/320.0
#define RATE1 SCREEN_HEIGHT/568.0





#import "YindaoYeViewContoller.h"
#import "SouYeViewController.h"
#import "AppDelegate.h"
@interface YindaoYeViewContoller ()<UITextViewDelegate>
{
    UIPageControl *_pageC;
    UIButton *btn;
    UIView *view;

}
@end

@implementation YindaoYeViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)configUI{

    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:sc];
    sc.backgroundColor = [UIColor whiteColor];
    NSArray *imagar = @[@"guide_img1",@"guide_img2",@"guide_img3"];

    for (NSInteger i=0; i<imagar.count; i++) {
        
        UIImageView *iamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(0+i*SCREEN_WIDTH, 100, SCREEN_WIDTH, 200)];
        iamgeview.backgroundColor = [UIColor whiteColor];
        iamgeview.image = [UIImage imageNamed:imagar[i]];
        iamgeview.tag=100+i;
        [sc addSubview:iamgeview];
        if (i==2) {
           
            btn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH*2+SCREEN_WIDTH/3), SCREEN_HEIGHT-140,SCREEN_WIDTH/3, 40)];
            [btn setTitle:@"进入体验" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
            btn.layer.borderWidth = 2;
            btn.layer.cornerRadius = 6;
            btn.layer.masksToBounds=YES;
            btn.layer.borderColor =[UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0] .CGColor;
            iamgeview.userInteractionEnabled = YES;
            [sc addSubview:btn];
            
        }
        
        
    }

    sc.showsHorizontalScrollIndicator =NO;
    sc.showsVerticalScrollIndicator = NO;
    sc.pagingEnabled = YES;
    sc.delegate =self;
    sc.bounces =NO;
    sc.clipsToBounds=YES;
    
    sc.contentOffset =CGPointMake(0, 0);
    sc.contentSize =CGSizeMake(3*SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100,SCREEN_WIDTH, 30)];
//    _pageC.backgroundColor = [UIColor blackColor];
    _pageC.numberOfPages = imagar.count;
    _pageC.currentPage = 0;
    [self.view addSubview:_pageC];
    _pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageC.currentPageIndicatorTintColor = [UIColor colorWithRed:0.14 green:0.39 blue:1.0 alpha:1.0];
 


}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    _pageC.currentPage = index;
    
}
//-(void)btn
//{
//    btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT-140,SCREEN_WIDTH/3, 40)];
//    [btn setTitle:@"立即体验" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
//    btn.layer.borderWidth = 2;
//    btn.layer.cornerRadius = 4;
//    btn.layer.masksToBounds=YES;
//    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    [self.view addSubview:btn];
//    
//    
//}
-(void)btn:(UIButton *)btn
{
//    NSLog(@"11111");
    SouYeViewController *souye =[[SouYeViewController alloc]init];
    
    
    
    [self.navigationController pushViewController:souye animated:YES];
    
//  [self presentViewController:souye animated:YES completion:^{
//     
////      [self addtextview:souyevc];
//      
//       }];
    
//    [self.navigationController pushViewController:souyevc animated:YES];


}
//-(void)addtextview:(TabBarViewController *)souye{
//
//    view = [[UIView alloc]init];
//    CGRect f = souye.view.frame;
//    view.frame = f;
//    view.backgroundColor = [UIColor whiteColor];
//    [souye.view addSubview:view];
//    
////    UILabel *textview1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, view.frame.size.width, 150)];
////    
////    textview1.text = @"hahahahahhahahahha";
////
////    [view addSubview:textview1];
//    
//        UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 22,SCREEN_WIDTH, view.frame.size.height-60)];
//    [view addSubview:textview];
////    textview.backgroundColor=[UIColor redColor]; //背景色
//    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
////    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
//    textview.delegate = self;
//    //设置代理方法的实现类
//    
//    
//    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//    lable.text = @"免责申明";
//    lable.textColor = [UIColor lightGrayColor];
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.font = [UIFont systemFontOfSize:25];
//    [textview addSubview:lable];
//    
//    
//    
//    
//    
//    
//    if (self.view.frame.size.width>320&&self.view.frame.size.width<400) {
//    textview.font=[UIFont  systemFontOfSize:18.0];
////        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
////        paragraphStyle.lineSpacing = 80; //行距
////        
////        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:90], NSParagraphStyleAttributeName:paragraphStyle};
////        textview.attributedText = [[NSAttributedString alloc]initWithString: textview.text attributes:attributes];
//
//    }if (SCREEN_WIDTH>400) {
//       textview.font=[UIFont fontWithName:@"Arial" size:20.0];
//        
////        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
////        paragraphStyle.lineSpacing = 8; //行距
////        
////        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:38], NSParagraphStyleAttributeName:paragraphStyle};
////        textview.attributedText = [[NSAttributedString alloc]initWithString: textview.text attributes:attributes];
//
//        
//        
//    }if (SCREEN_WIDTH==320) {
//        
//        
////        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
////        paragraphStyle.lineSpacing = 8; //行距
////        
////        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:25], NSParagraphStyleAttributeName:paragraphStyle};
////        textview.attributedText = [[NSAttributedString alloc]initWithString: textview.text attributes:attributes];
//        
// 
//        textview.font=[UIFont fontWithName:@"Arial" size:15.0];
//        
//    }
//    
//    
// //设置字体名字和字体大小;
////    textview.returnKeyType = UIReturnKeyDefault;//return键的类型
////    textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
//    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
////    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
//    textview.showsVerticalScrollIndicator = NO;
//    textview.showsHorizontalScrollIndicator = NO;
//    textview.textColor = [UIColor lightGrayColor];
//    
//    textview.text = @"\n\n\n爱看影视提醒您：\n\n    一旦你点击接受本条款，均被视为已经仔细阅读本条款并完全同意。任何用户在使用本客户端服务之前，均应仔细阅读本声明，用户可选择不使用本客户端，选择拒绝将退出本应用。如一旦使用，即被视为本声明全部内容的认可和接受。\n\n关于内容:\n\n     本客户端显示的资源均系聚合引擎技术自动收录第三方网站所有者制作或提供的内容。内容版权归各电视台以及版权方所有。本客户端不存储，不修改节目内容。视频数据流也不经过本公司服务器中转或存储。如果您喜欢节目的内容，建议您下载官方APP进行观看.\n\n法律责任:\n\n     用户理解并同意，用户通过本客户端所获得的材料、信息、产品及服务完全出于用户自己的判断，并承担因使用该等内容而引起的所有风险，包括但不限于因对内容的正确性、完整性或实用性的依赖而产生的风险。用户在使用过程中，因受视频或相关内容误导或欺骗而导致或可能导致的任何心理、生理上的伤害以及经济上的损失，一概与我公司无关.\n\n权利及通知:\n\n     任何单位或个人如认为本客户端聚合引擎技术收录的第三方网站视频内容可能侵犯了其合法权益，请及时向我公司进行反馈，并提供身份证明、权属证明及详细侵权情况证明。邮件地址：x154266797@163.com。我公司在收到上述邮件后，可依其合理判断，断开聚合引擎技术收录的涉嫌侵权的第三方网站内容。";
//   [view addSubview:textview];
//    
//    NSArray *ar = @[@"同意",@"拒绝"];
//    for (NSInteger i=0; i<ar.count; i++) {
//        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0+i*(view.frame.size.width/2), view.frame.size.height-38, view.frame.size.width/2, 37)];
//        [btn1 setTitle:ar[i] forState:UIControlStateNormal];
//        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn1.tag = 100+i;
//        [btn1 addTarget:self action:@selector(adbtn:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        
//        btn1.layer.cornerRadius = 4;
//        btn1.layer.masksToBounds = YES;
//        btn1.layer.borderWidth = 2;
//        btn1.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        
//        
//        
//        
//        
//        
//        [view addSubview:btn1];
//    }
//    
//    
//    
//    
////    //设置显示的文本内容
////   textview.text = NSLineBreakByWordWrapping;
//
//}
//-(void)adbtn:(UIButton *)btn{
//
//    if (btn.tag==100) {
//        
//        view.hidden = YES;
//        
//        NSString *passWord = @"ju";
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        [user setObject:passWord forKey:@"JU"];
//        
//        
//    }else{
//    
//        AppDelegate *app = [UIApplication sharedApplication].delegate;
//        UIWindow *window = app.window;
//        
//        [UIView animateWithDuration:0.4f animations:^{
//            window.alpha = 0;
//            CGFloat y = window.bounds.size.height;
//            CGFloat x = window.bounds.size.width / 2;
//            window.frame = CGRectMake(x, y, 0, 0);
//        } completion:^(BOOL finished) {
//            exit(0);
//        }];
//    
//      
//  
//    
//    }
//
//
//
//
//
//}
//
//
//
//- (void)textViewDidChange:(UITextView *)textView{
////    //计算文本的高度
////    CGSize constraintSize;
////    constraintSize.width = textView.frame.size.width-16;
////    constraintSize.height = MAXFLOAT;
////    CGSize sizeFrame =[textView.text sizeWithFont:textView.font
////                                constrainedToSize:constraintSize
////                                    lineBreakMode:UILineBreakModeWordWrap];
////    
////    //重新调整textView的高度
////    textView.frame = CGRectMake(textView.frame.origin.x,textView.frame.origin.y,textView.frame.size.width,sizeFrame.height+5);
//}
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
////{
////    if (range.location>=100)
////    {
////        //控制输入文本的长度
////        return  NO;
////    }
////    if ([text isEqualToString:@"\n"]) {
////        //禁止输入换行
////        return NO;
////    }
////    else
////    {
////        return YES;
////    }
//}
//

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
