//
//  YijianORXieYiViewController.m
//  Music
//
//  Created by ljl on 17/4/13.
//  Copyright © 2017年 李金龙. All rights reserved.
//
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#import "YijianORXieYiViewController.h"
#import "MBProgressHUD.h"
@interface YijianORXieYiViewController ()<UITextFieldDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong)UIButton *leftbtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UITextField *Fieldtext;

@property(nonatomic,strong)UITextView *textview;
@property(nonatomic,assign)NSInteger is_iphoneX_statuesheight;
@end

@implementation YijianORXieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self NavItems];
    
    
    if (_yijianORxieyi==0) {
        
    
    
    
        [self yijianUI];
    
    }else{
    
        [self yonghuxieyiUI];
    
    }
    
}
-(void)NavItems{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc]init];
    
    if (kDevice_Is_iPhoneX == YES) {
        _is_iphoneX_statuesheight = 34;
    }else{
        
        _is_iphoneX_statuesheight = 0;
    }
    
      view.frame = CGRectMake(0, _is_iphoneX_statuesheight, self.view.frame.size.width, 49);
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
    [self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(60, 0,self.view.frame.size.width-120, 49)];
    lable.text =_str;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:19];
    [view addSubview:lable];
    
    
    
    _leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0+_is_iphoneX_statuesheight, 50, 49)];
    [_leftbtn setImage:[UIImage imageNamed:@"SettingBack@2x"] forState:UIControlStateNormal];
    [_leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftbtn];
    
    
    if (_yijianORxieyi==0) {
        
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 0,50 , 49)];
    [_rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(rightCilck1) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_rightBtn];
    }else{
    
        _rightBtn.hidden = YES;
    
    }
}
-(void)yijianUI{

    _Fieldtext = [[UITextField alloc]initWithFrame:CGRectMake(0, _leftbtn.frame.size.height+5+_is_iphoneX_statuesheight, self.view.frame.size.width, self.view.frame.size.height/2)];
    
    _Fieldtext.borderStyle = UITextBorderStyleRoundedRect;
    
    
    _Fieldtext.placeholder = @"在这里输入你要说的话";
    _Fieldtext.textColor = [UIColor lightGrayColor];
    _Fieldtext.textAlignment = NSTextAlignmentLeft;
    
    _Fieldtext.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    _Fieldtext.font = [UIFont systemFontOfSize:15];
    
    _Fieldtext.delegate = self;
    _Fieldtext.clearsOnBeginEditing = YES;
    
    _Fieldtext.keyboardType = UIKeyboardAppearanceDefault;
    
    _Fieldtext.returnKeyType = UIReturnKeySend;
    [self.view addSubview:_Fieldtext];
  
    [_Fieldtext becomeFirstResponder];
    
}
//-(void)showtextFiledContents{
//   
//}
-(void)rightCilck1{

    if (_Fieldtext.text.length<=0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"内容不能为空！！";
        
        hud.label.textColor = [UIColor blueColor];
      
      
        hud.bezelView.color = [UIColor whiteColor];
        
       
        
        [hud hideAnimated:YES afterDelay:2];

        
        
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"已发送成功！！";
        
        hud.label.textColor = [UIColor blueColor];
       
        hud.bezelView.color = [UIColor whiteColor];
        hud.delegate = self;
        
              [hud hideAnimated:YES afterDelay:1];
    
    [_Fieldtext  resignFirstResponder];
    
    }
  

}
-(void)hudWasHidden:(MBProgressHUD *)hud{

    [hud removeFromSuperview];


    
        [self dismissViewControllerAnimated:YES completion:^{
    
        }];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

//   [_Fieldtext  resignFirstResponder];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    NSLog(@"提示用户啊");
    return YES;


}

-(void)yonghuxieyiUI{


    _textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 49+_is_iphoneX_statuesheight, self.view.frame.size.width, self.view.frame.size.height-49)];
    [self.view addSubview:_textview];
    NSString *ss = @"欢迎并感谢你使用此应用服务！\n本《用户协议》是你与简音app就使用此应用达成的协议，请你务必认真阅读并充分理解。简音app应用一贯高度重视知识产权并遵守中华人民共和国各项知识产权法律，法规，和具有约束力的规范文件，坚决反对任何违反中华人名共和国有关著作权的法律法规的行为。\r\n一使用“简音app”产品注意如下：\n 1用户可以从任何合法的渠道下载“简音”软件程序到合法终端设备中，但除非得到特别的授权，否则，用户不得以任何形式改编，复制或交易软件程序。\n 2.你无需注册即可使用本应用。\n 3.用户须明白，在事先通知用户的情况下修改，终端，终止“简音”产品的各项服务，而无需向用户或第三方负责或承担任何赔偿责任。\n二法律责任声明\n1对于任何自本应用而获得的他人的信息，内容或者广告等信息，不负责保证真实，准确和完整性的责任。如果任何单位或者个人通过上述“信息”而进行的任何行为，须自行辨别真伪，否则，无论何种原因。本应用开发者不对任何非与本应用直接发生的交易和行为承担任何直接，间接的损失和责任。   \n 2基于以下原因而造成的利润，商业信誉，资料损失或其他有形无形损失，本应用不承担任何直接间接的赔偿责任。   \n 3.由于我们无法对应用内容进行充分的监测，我们制定了旨在保护知识产权权利人合法利益的措施，和步骤，当作者人和依法可以行使信息网络传播的权利人发现本应用上的内容存在权利瑕疵或侵犯了第三方的合法权益（包含但不限于专利权，商标权，著作权及连接权，肖像权，隐私权，名誉权）时，权利人因事先向本应用发出权利通知，我们将根据相关法律规定采取措施删除相关内容。\n具体措施和步骤如下：\n如果你是某文章作品或项目的著作人和依法可以行使信息网络传播的权利人，且你认为本应用内容侵犯了你队该作品的信息网络传播权，请务必书面通知本公司，你应对书面通知陈述之真实性负责。 \n   为了方便本公司及时处理你的意见，你通知书面中应包含以下内容：   \n 1.你的姓名，联系方式和地址； \n   2.要求删除作品的名称和在本应用的位置   \n 3.构成侵权的初步证明材料。   \n 4.你的签名。   \n 请你将该通知及相关材料扫描件发送至以下邮箱地址。  \n  邮箱：x154266797@163.comq \n   一旦收到符合上述要求之通知，我们采取包括删除等相应措施。若不符合上述条件，我们会请你提供相应信息，且站不采取包括删除等相应措施。\n    最后祝你使用本应用愉快！";

 _textview.editable = NO;
    NSMutableParagraphStyle *paragestryle = [[NSMutableParagraphStyle alloc]init];
    paragestryle.lineHeightMultiple = 20.f;
    paragestryle.maximumLineHeight = 20.f;
    paragestryle.minimumLineHeight = 20.f;
    
    
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    
    
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@1.7f};
    
       NSMutableAttributedString *attri1 = [[NSMutableAttributedString alloc] initWithString:ss attributes:attributes];
    
    
    [attri1 addAttribute:NSFontAttributeName
     
                   value:[UIFont systemFontOfSize:15.0]
     
                   range:NSMakeRange(0, attri1.length)];
    
    [attri1 addAttribute:NSForegroundColorAttributeName
     
                   value:[UIColor lightGrayColor]
                   range:NSMakeRange(0, attri1.length)];

    
    _textview.attributedText = attri1;
    
    _textview.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
}




-(void)leftClick{
    
    
    [_Fieldtext  resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
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
