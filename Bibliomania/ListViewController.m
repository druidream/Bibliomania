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
#import "BMScanViewController.h"
#import "BMDoubanJSONResult.h"
#import "BMBookDetailViewController.h"
#import "REFrostedViewController.h"

#ifndef __OPTIMIZE__
#import "RRFPSBar.h"
#endif
@interface ListViewController () <BMScanViewControllerDelegate>

@property (nonatomic, copy) NSArray *bookItems;
@property (nonatomic, strong) BookService *bookService;

@end

@implementation ListViewController
@synthesize bookItems, bookService;

static NSString * const CELL_IDENTIFIER = @"bookItemCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Show only if app is is not optimized (aka debug build)
    
//#ifndef __OPTIMIZE__
//    [[RRFPSBar sharedInstance] setHidden:NO];
//#endif
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"scan"]) {
        BMScanViewController *vc = (BMScanViewController *)segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark - TableView delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_IDENTIFIER];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BMBookDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BookDetailViewController"];
    vc.bookItem = [self.bookItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - BMScanViewControllerDelegate

- (void)scanningDidEnd:(NSArray *)bookResultItems {
//    NSLog(@"... scanningDidEnd : %@", bookResultItems);
    for (BMDoubanJSONResult *bookResultItem in bookResultItems) {
        
        BookItem *book = [bookService createBook];
        [book setName:bookResultItem.title];
        
        NSArray *chapterResultItems = [self chaptersFromCatalog:bookResultItem.catalog];
        NSMutableSet *chapters = [[NSMutableSet alloc] init];
        for (NSString *chapterResultItem in chapterResultItems) {
            Chapter *chapter = [bookService createChapter];
            chapter.name = chapterResultItem;
            
            [chapters addObject:chapter];
        }
        [book setChapters:chapters];
    }
    [bookService saveChanges];
    
    self.bookItems = [bookService retrieveBooks];
    [self.tableView reloadData];
}

#pragma mark - events

- (IBAction)drawerButtonDidClick:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -

- (NSArray *)chaptersFromCatalog:(NSString *)catalog {
    
    return [catalog componentsSeparatedByString:@"\n"];
}


@end
