//
//  DoubanISBNResolver.m
//  Bibliomania
//
//  Created by Gu Jun on 1/27/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "DoubanISBNResolver.h"
#import <AFNetworking/AFNetworking.h>
#import "JSONModel.h"

@implementation DoubanISBNResolver

static NSString * const API_DOUBAN_ISBN = @"https://api.douban.com/v2/book/isbn/:";

- (void)resolve:(NSString *)isbn completion:(void (^)(id responseString))completion
{
    NSString *fullURL = [NSString stringWithFormat:@"%@%@", API_DOUBAN_ISBN, isbn];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:fullURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%lld", downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = responseObject;
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        NSLog(@"!!! failure : %s", __FUNCTION__);
    }];
}

@end
