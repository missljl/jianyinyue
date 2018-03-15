//
//  LastFastcell.m
//  Music
//
//  Created by 1111 on 2017/6/23.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "LastFastcell.h"

@implementation LastFastcell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
//    CGRect frame =[self frame];
//    self.lasttitlelabel.text
    
    
    
    
    
    // Initialization code
}
-(void)setIntroductionText:(NSString *)text{

    CGRect frame =[self frame];
    self.lasttitlelabel.text=text;

    self.lasttitlelabel.numberOfLines = 0;
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle  setLineSpacing:6];
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:text];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [self.lasttitlelabel setAttributedText:setString];
//    CGSize size = CGSizeMake(300, 1000);
    self.lasttitlelabel.font =[UIFont systemFontOfSize:14];
    self.lasttitlelabel.textColor =[UIColor lightGrayColor];
    self.lasttitlelabel.textAlignment =NSTextAlignmentCenter;
//    CGSize labelSize = [self.lasttitlelabel.text sizeWithFont:self.textLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
//    self.lasttitlelabel.frame = CGRectMake(self.lasttitlelabel.frame.origin.x, self.lasttitlelabel.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
//    frame.size.height = labelSize.height+100;
    
    self.frame = frame;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
