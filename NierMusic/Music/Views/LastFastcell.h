//
//  LastFastcell.h
//  Music
//
//  Created by 1111 on 2017/6/23.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastFastcell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lasttitlelabel;




-(void)setIntroductionText:(NSString*)text;

////初始化cell类
//-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;

@end
