//
//  BookItem.h
//  Bibliomania
//
//  Created by Gu Jun on 1/29/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag;

NS_ASSUME_NONNULL_BEGIN

@interface BookItem : NSManagedObject

@property (nullable, nonatomic, retain) NSString *bookName;
// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "BookItem+CoreDataProperties.h"
