//
//  BookService.m
//  Bibliomania
//
//  Created by Gu Jun on 1/29/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "BookService.h"
#import <CoreData/CoreData.h>
#import "Chapter.h"

@implementation BookService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure" reason:[error localizedDescription] userInfo:nil];
        }
//        _context = [[NSManagedObjectContext alloc] init];
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];

        _context.persistentStoreCoordinator = psc;
    }
    return self;
}

- (BookItem *)createBook
{
    BookItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"BookItem" inManagedObjectContext:self.context];
    item.name = @"first book";
    item.id = @1;
    return item;
}

- (Chapter *)createChapter
{
    Chapter *item = [NSEntityDescription insertNewObjectForEntityForName:@"Chapter" inManagedObjectContext:self.context];
    item.name = @"chapter 1";
    item.id = @1;
    return item;
}

- (void)updateBook: (BookItem *)book {
    // TODO
}

- (void)deleteBook: (BookItem *)book {
    // TODO
}

- (NSArray *)retrieveBook: (BookItem *)book
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"BookItem" inManagedObjectContext:self.context];
    request.entity = e;
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    return result;
}

- (NSArray *)retrieveBooks
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *e = [NSEntityDescription entityForName:@"BookItem" inManagedObjectContext:self.context];
    request.entity = e;
    NSError *error;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (!result) {
        [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    return result;
}

- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

- (NSString *)itemArchivePath
{
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

@end
