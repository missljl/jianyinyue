//
//  RootViewController.m
//  Music
//
//  Created by ljl on 17/4/5.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(BOOL)prefersStatusBarHidden{
    
    
    return YES;
    
    
    
    
}
-(void)addBarBtnItemWithTitle:(NSString *)title withImageName:(NSString *)imageName withPosition:(NSInteger)position
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    if (title.length>0) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    if (imageName.length>0) {
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
    }
    UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if (position==LEFT_BARITEM) {
        [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =BarItme;
    }else{
        [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = BarItme;
    }
    
}
-(void)leftClick
{
}
-(void)rightClick
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    // Dispose of any resources that can be recreated.
}


@end
