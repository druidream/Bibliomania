//
//  BookItem+CoreDataProperties.h
//  Bibliomania
//
//  Created by Gu Jun on 9/7/16.
//  Copyright © 2016 com.dream. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BookItem.h"
#import "Chapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) id thumbnail;
@property (nullable, nonatomic, retain) NSSet<Tag *> *tags;
@property (nullable, nonatomic, retain) NSSet<Chapter *> *chapters;

@end

@interface BookItem (CoreDataGeneratedAccessors)

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet<Tag *> *)values;
- (void)removeTags:(NSSet<Tag *> *)values;

- (void)addChaptersObject:(Chapter *)value;
- (void)removeChaptersObject:(Chapter *)value;
- (void)addChapters:(NSSet<Chapter *> *)values;
- (void)removeChapters:(NSSet<Chapter *> *)values;

@end

NS_ASSUME_NONNULL_END
