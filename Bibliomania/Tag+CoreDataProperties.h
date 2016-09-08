//
//  Tag+CoreDataProperties.h
//  Bibliomania
//
//  Created by Gu Jun on 9/7/16.
//  Copyright © 2016 com.dream. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<BookItem *> *items;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addItemsObject:(BookItem *)value;
- (void)removeItemsObject:(BookItem *)value;
- (void)addItems:(NSSet<BookItem *> *)values;
- (void)removeItems:(NSSet<BookItem *> *)values;

@end

NS_ASSUME_NONNULL_END
