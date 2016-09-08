//
//  DoubanISBNResolver.h
//  Bibliomania
//
//  Created by Gu Jun on 1/27/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubanISBNResolver : NSObject

- (void)resolve:(NSString *)isbn completion:(void (^)(id responseString))completion;

@end
