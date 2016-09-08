//
//  BMDoubanJSONResult.h
//  Bibliomania
//
//  Created by Gu Jun on 9/8/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BMDoubanJSONResult : JSONModel

@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *catalog;
@property (nonatomic, strong) NSString *title;

@end
