//
//  DTandSCViewController.m
//  Music
//
//  Created by ljl on 17/4/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#import "DTandSCViewController.h"
#import "RightViewController.h"
#import "SouCangManager.h"
#import "SoucangModel.h"
#import "GenSoucangCell.h"
#import "WenzhangManager.h"
#import "WenzhangModel.h"
#import "XiangqingViewController.h"
#import "AppDelegate.h"
#import "ZaoanXIangqingViewController.h"
@interface DTandSCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton *leftbtn;
@property(nonatomic,strong)UITableView *tablview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign)NSInteger is_iphoneX_statusHeight;

@end

@implementation DTandSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    [self NavItems];
    if (_DianORWen==0) {
     [self loadData];
    }else{
        [self loadData1];
    
    }
  
    [self configUI];
}
-(void)NavItems{
    UIView *view = [[UIView alloc]init];
    if (kDevice_Is_iPhoneX == YES) {
        
        _is_iphoneX_statusHeight = 34;
    }else{
        _is_iphoneX_statusHeight = 0;
    }
    view.frame = CGRectMake(0, _is_iphoneX_statusHeight, self.view.frame.size.width, 49);
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor colorWithRed:0.17 green:0.49 blue:1.0 alpha:1.0];
    [self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(60, 0,self.view.frame.size.width-120, 49)];
    lable.text =_titlestr;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:19];
    [view addSubview:lable];
    
    
    
    _leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0+_is_iphoneX_statusHeight, 50, 49)];
    [_leftbtn setImage:[UIImage imageNamed:@"SettingBack@2x"] forState:UIControlStateNormal];
    [_leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftbtn];
    
    
    
    self.title = _titlestr;

}
-(void)leftClick{
  
    [self dismissViewControllerAnimated:YES completion:^{
       
     
  
    }];


}
-(void)loadData{


    _dataArray = [[SouCangManager manager]allModels];
    
    [_tablview reloadData];

}
-(void)loadData1{

    _dataArray = [[WenzhangManager manager]allModels];

    
    [_tablview reloadData];
}
-(void)configUI{
    
      _tablview = [[UITableView alloc]initWithFrame:CGRectMake(0,49+_is_iphoneX_statusHeight, self.view.frame.size.width, self.view.frame.size.height-49-64) style:UITableViewStylePlain];
   
  
    _tablview.delegate = self;
    _tablview.dataSource = self;
    [_tablview registerNib:[UINib nibWithNibName:@"GenSoucangCell" bundle:nil] forCellReuseIdentifier:@"soucell"];

    [self.view addSubview:_tablview];
    
    
    
    
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   
        
    
static NSString *cellid = @"soucell";

    GenSoucangCell *cell = [_tablview dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    if (_DianORWen==0) {
        
    
    
    SoucangModel *model = _dataArray[indexPath.row];

    cell.geming.text = model.genming;
    cell.geming.textColor = [UIColor blackColor];
    cell.geshou.font = [UIFont systemFontOfSize:13];
    cell.geshou.text = model.genshou;
        
        
    }else{
        WenzhangModel *model = _dataArray[indexPath.row];
        cell.geming.text = model.wenzhangtitle;
        cell.geshou.text=model.wenzhangzuozhe;
    
    
    }
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-1, self.view.frame.size.width, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:view];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, cell.frame.size.height/2-25, 50, 50)];
    btn.tag = 100+indexPath.row;
    if (_DianORWen==0) {
        
    
    [btn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_CMTransceiverBottomPanel_unlikeBtn_nornal@2x"] forState:UIControlStateNormal];
    }else{
    
        [btn setImage:[UIImage imageNamed:@"CMGeneTransceiverVC_CMTransceiverBottomPanel_TrashBtn@2x"] forState:UIControlStateNormal];

    
    
    }
    
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:btn];
    
    return cell;
}
-(void)btn:(UIButton *)btn{

    
    if (_DianORWen==0) {
        
    
    SoucangModel *model= _dataArray[btn.tag-100];
    
    [[SouCangManager manager]deleteModel:model];
    
    }else{
        WenzhangModel *model = _dataArray[btn.tag-100];
        [[WenzhangManager manager]deleteModel:model];
    
    
    }
    [_tablview deleteRowsAtIndexPaths:@[[self removeDataAtIndex:btn.tag-100]]
                     withRowAnimation:UITableViewRowAnimationLeft];
 
       [_tablview reloadData];
   
 
  
    
   

}
- (NSIndexPath *)removeDataAtIndex:(NSInteger)row{
    
    NSMutableArray *copyArray = [NSMutableArray  arrayWithArray:_dataArray];
    [copyArray removeObjectAtIndex:row];
    _dataArray = [NSMutableArray arrayWithArray:copyArray];
    NSIndexPath * path = [NSIndexPath indexPathForRow:row inSection:0];
    
    
    return path;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_DianORWen==0) {
      
        
        SoucangModel *model = _dataArray[indexPath.row];
        
        [self.delegate DtandSCwithmodel:model];
      
        
        
    }else{
//        
          WenzhangModel *model = _dataArray[indexPath.row];
        NSLog(@"%@",model);
//
//        NSInteger isdujiaorzaoan=[model.tag1 integerValue];
//        NSLog(@">>>>>%ld",isdujiaorzaoan);
//        if (isdujiaorzaoan==5) {
//            ZaoanXIangqingViewController *zao =[[ZaoanXIangqingViewController alloc]init];
//            zao.zaovcid=model.wemzhangid;
//            NSLog(@"isdu%ld",isdujiaorzaoan);
//         [self presentViewController:zao animated:YES completion:^{
//             
//         }];
        
//        }else{
        
        
        
       XiangqingViewController *x =[[XiangqingViewController alloc]init];
        x.issoucang=5;
//         NSLog(@"isdu%ld",isdujiaorzaoan);
       
        x.isdujia = [model.tag1 integerValue];
        
        if (x.isdujia==0) {
            x.strid=model.wemzhangid;
            
            
            
        }if (x.isdujia==1) {
            x.strid=model.wemzhangid;
            x.twotitle=model.wenzhangtitle;
            x.twotubtitle=model.wenzhangzuozhe;
            x.twoheadimage=model.tuimage;
            
        }if (x.isdujia==3) {
            x.strid=model.wemzhangid;
            x.toustrd=model.link;
        
            
        }if (x.isdujia==4) {
            x.strid=model.wemzhangid;
            x.twoheadimage=model.tuimage;
            x.twotitle=model.wenzhangtitle;
            
        }
    
        [self presentViewController:x animated:YES completion:^{
            
        }];
        }
//        NSLog(@"文章收藏");
    
//    }
[tableView deselectRowAtIndexPath:indexPath animated:YES];

    


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;

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
