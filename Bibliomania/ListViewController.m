//
//  ListViewController.m
//  Bibliomania
//
//  Created by Gu Jun on 2/20/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "ListViewController.h"
#import "BookService.h"
#import "Chapter.h"
#import "Chapter+CoreDataProperties.h"

#ifndef __OPTIMIZE__
#import "RRFPSBar.h"
#endif
@interface ListViewController ()

@property (nonatomic, readonly, copy) NSArray *bookItems;
@property (nonatomic, strong) BookService *bookService;

@end

@implementation ListViewController
@synthesize bookItems, bookService;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Show only if app is is not optimized (aka debug build)
    
#ifndef __OPTIMIZE__
    [[RRFPSBar sharedInstance] setHidden:NO];
#endif
    
    bookService = [[BookService alloc] init];
    bookItems = [bookService retrieveBooks];
    
    // 测试数据
    if (!bookItems.count) {
        BookItem *book = [bookService createBook];
        [book setValue:@"second value" forKey:@"name"];
        
        Chapter *chapter = [bookService createChapter];
        
        NSSet *set = [NSSet setWithObjects:chapter, nil];
        
        [book setChapters:set];
        [bookService saveChanges];
        
        bookItems = [bookService retrieveBooks];
    }
    
    BookItem *bookItem = [bookItems objectAtIndex:0];
    NSSet *set = bookItem.chapters;
    Chapter *chapter = [[set allObjects] objectAtIndex:0];
    NSLog(@"%@", chapter.name);
}

#pragma mark - TableView delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    BookItem *bookItem = [bookItems objectAtIndex:indexPath.row];
    [cell.textLabel setText:bookItem.name];
    
    NSSet *set = bookItem.chapters;
    if (set.allObjects.count > 0) {
        Chapter *chapter = [[set allObjects] objectAtIndex:0];
        [cell.detailTextLabel setText:chapter.name];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return bookItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BookDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
