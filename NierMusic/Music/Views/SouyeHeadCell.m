//
//  SouyeHeadCell.m
//  Music
//
//  Created by ljl on 17/3/30.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "SouyeHeadCell.h"
#import "HeadView.h"
@implementation SouyeHeadCell

{

    HeadView *_view;

}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self configUI];
        self.userInteractionEnabled = YES;
    }
    return self;

}
-(void)configUI{

    _view = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) WithArray:[_ar copy]];
//    NSLog(@"ar%@",_ar);
 
//    [self addSubview:_view];
    

}

-(void)fiel:(NSArray *)array{

    
    
   _view = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) WithArray:array];
    
    [self addSubview:_view];


}






- (void)awakeFromNib {
    [super awakeFromNib];
    
    
//   _view = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) WithArray:[_ar copy]];
//    
//    [self addSubview:_view];
//   
}




//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
