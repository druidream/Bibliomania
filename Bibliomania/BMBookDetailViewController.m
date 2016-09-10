//
//  BMBookDetailViewController.m
//  Bibliomania
//
//  Created by Gu Jun on 9/9/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "BMBookDetailViewController.h"

@interface BMBookDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray<Chapter *> *chatpers;

@end

@implementation BMBookDetailViewController

static NSString * const CELL_IDENTIFIER = @"bookChapterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.chatpers = [self.bookItem.chapters allObjects];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookItem.chapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_IDENTIFIER];
    }
    Chapter *chapter = [self.chatpers objectAtIndex:indexPath.row];
    cell.textLabel.text = chapter.name;
    
    return cell;
}

@end
