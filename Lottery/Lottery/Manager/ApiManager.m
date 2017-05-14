//
//  ApiManager.m
//  RescueNow
//
//  Created by wangzh on 6/28/16.
//  Copyright © 2016 Fenrir.com. All rights reserved.
//

#import "ApiManager.h"
#import "LotteryModel.h"

static NSString* const HostUrl = @"http://localhost/SpringRestHibernateExample";

// 手机创建热点的时候
//static NSString* const HostUrl = @"http://172.20.10.2/SpringRestHibernateExample";
static NSString* const GetLottery = @"getLotterys";

@interface ApiManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong, readonly) NSString *stringUrl;

@end

@implementation ApiManager

- (instancetype)init{
    self = [super init];
    [self commonInit];
    return self;
}

- (void)commonInit {
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString:HostUrl]];
    // response 初始化
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // request 初始化
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // response可以接受的content-type类型
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                          @"application/json",
                                                          @"text/json",
                                                          @"text/javascript",
                                                          @"text/html",
                                                          @"application/xml",
                                                          @"text/xml",
                                                          @"text/plain",
                                                          nil];
    [_manager.requestSerializer setValue:@"UTF-8"
                     forHTTPHeaderField:@"Accept-Charset"];
    [_manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
}


- (void)getLotterysWithCount:(NSInteger)count
                conditionDic:(NSDictionary *)conditionDic
                      sucess:(RequestSucceccCallBack)successCallBack
                      failed:(RequestFailedCallBack)failedCallBack {
    [_manager POST:GetLottery parameters:conditionDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];

        NSArray *models = [MTLJSONAdapter modelsOfClass:[LotteryModel class] fromJSONArray:jsonArray error:&error];
        NSLog(@"%@", models);
        if (successCallBack) {
            successCallBack(models);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedCallBack) {
            failedCallBack(task);
        }
    }];
}

- (void)sendPushTokenToServer:(NSString *)pushToken
                      userKey:(NSString *)userKey {
//    NSString *urlParameter = UPDATE_PUSH_TOKEN_URL;
//    if (!pushToken.length || !userKey.length) {
//        LOG(@"Error: No PushToken or UserKey!");
//        return;
//    }
//    NSDictionary *bodyParameters = @{
//                                     APIKEY_USER_KEY: userKey,
//                                     APIKEY_TOKEN : pushToken
//                                     };
//    [_manager POST:urlParameter
//        parameters:bodyParameters
//          progress:^(NSProgress * _Nonnull uploadProgress) {
//              LOG(@"Is Requesting");
//          } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//              // 解码response信息
//              NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                                       options:NSJSONReadingMutableLeaves error:nil];
//              NSNumber *resultNbr = jsonDict[APIKEY_RESULT];
//              if (resultNbr && [resultNbr integerValue]) {
//                  [LocalStoreManager updateShouldSendPushTokenFlag:NO];
//              } else {
//                  // 200を返却して、ユーザーが失効する
//                  [LocalStoreManager updateShouldSendPushTokenFlag:NO];
//                  [LocalStoreManager updateUserKey:@""];
//                  [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN2_FAILED_ALERT object:nil];
//              }
//              [LocalStoreManager updateShouldSendPushTokenFlag:NO];
//          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//              // タスクのレスポンスがある場合、
//              [LocalStoreManager updateShouldSendPushTokenFlag:YES];
//          }];
}

@end
