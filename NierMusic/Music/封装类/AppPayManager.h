//
//  AppPayManager.h
//  YTApp
//
//  Created by 1111 on 2017/9/5.
//  Copyright © 2017年 ljl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

//接受服务器数据时block
typedef void (^ProcessHandle)(NSString *sitngid,NSString *sizeString,NSString *speedString);
//下载完成block
typedef void (^CompletionHandle)(NSString *wancheng);
//失败
typedef void (^FailureHandle)(NSString *cuowu);

@interface AppPayManager : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>

//下载过程中回调的代码块，会多次调用。
@property(nonatomic,copy,readonly)ProcessHandle process;
//下载完成回调的代码块
@property(nonatomic,copy,readonly)CompletionHandle completion;
//下载失败的回调代码块
@property(nonatomic,copy,readonly)FailureHandle failure;

+(instancetype)sharePaymanager;

-(void)requesproductData:(NSString *)type   process:(ProcessHandle)process
              completion:(CompletionHandle)completion
                 failure:(FailureHandle)failure;

@end
