//
//  Fourviews.h
//  Music
//
//  Created by ljl on 17/4/14.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fourviews : UIView
@property(nonatomic,strong)UIImageView *iamgeview;



-(id)initWithFrame:(CGRect)frame creatrViewlabelTitle:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag;
@end
