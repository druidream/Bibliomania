//
//  BookService.h
//  Bibliomania
//
//  Created by Gu Jun on 1/29/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookItem.h"
#import "BookItem+CoreDataProperties.h"

@interface BookService : NSObject

@property (strong, nonatomic)NSManagedObjectModel *model;
@property (strong, nonatomic)NSManagedObjectContext *context;

- (BookItem *)createBook;
- (NSArray *)retrieveBook: (BookItem *)book;
- (void)updateBook: (BookItem *)book;
- (void)deleteBook: (BookItem *)book;
- (BOOL)saveChanges;
- (NSArray *)retrieveBooks;

- (NSString *)itemArchivePath;

- (Chapter *)createChapter;

@end
