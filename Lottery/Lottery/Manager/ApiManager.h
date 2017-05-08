//
//  ApiManager.h
//  RescueNow
//
//  Created by wangzh on 6/28/16.
//  Copyright © 2016 Fenrir.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/// Api送信クラス
@interface ApiManager : NSObject

typedef void (^RequestSucceccCallBack)(id infoDic);
typedef void (^RequestFailedCallBack)(NSURLSessionDataTask * task);

// login1
- (void)getLotterysWithCount:(NSInteger)count
                conditionDic:(NSDictionary *)conditionDic
                      sucess:(RequestSucceccCallBack)successCallBack
                      failed:(RequestFailedCallBack)failedCallBack;
// login2
- (void)sendPushTokenToServer:(NSString *)pushToken userKey:(NSString *)userKey;

@end
