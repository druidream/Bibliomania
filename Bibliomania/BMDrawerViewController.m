//
//  BMDrawerViewController.m
//  Bibliomania
//
//  Created by Gu Jun on 9/9/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "BMDrawerViewController.h"

@interface BMDrawerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *drawerItems;

@end

@implementation BMDrawerViewController

static NSString * const CELL_IDENTIFIER = @"drawerItemCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drawerItems = [[NSMutableArray alloc] init];
    [self.drawerItems addObject:@"Dashboard"];
    [self.drawerItems addObject:@"Books"];
    [self.drawerItems addObject:@"Tags"];
    [self.drawerItems addObject:@"Wishlist"];
    [self.drawerItems addObject:@"Settings"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_IDENTIFIER];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSString *labelName = [self.drawerItems objectAtIndex:indexPath.row];
    cell.textLabel.text = labelName;
    NSString *imageName = [NSString stringWithFormat:@"drawer-%@", labelName.lowercaseString];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.drawerItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end
