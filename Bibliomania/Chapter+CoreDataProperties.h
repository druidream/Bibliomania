//
//  Chapter+CoreDataProperties.h
//  Bibliomania
//
//  Created by Gu Jun on 9/7/16.
//  Copyright © 2016 com.dream. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Chapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Chapter (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *unread;
@property (nullable, nonatomic, retain) BookItem *bookItem;

@end

NS_ASSUME_NONNULL_END
