//
//  BMImageTransformer.m
//  Bibliomania
//
//  Created by Gu Jun on 9/6/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "BMImageTransformer.h"
#import <UIKit/UIKit.h>

@implementation BMImageTransformer

//
+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
