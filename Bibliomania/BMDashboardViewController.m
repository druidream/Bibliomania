//
//  BMDashboardViewController.m
//  Bibliomania
//
//  Created by Gu Jun on 9/12/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "BMDashboardViewController.h"
#import "UIColor+iOS7Colors.h"
#import "REFrostedViewController.h"

@interface BMDashboardViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<NSNumber *> *progressArray;

@end

@implementation BMDashboardViewController

static NSString * const CELL_IDENTIFIER = @"cellIdentifer";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:247/255. green:243./255. blue:240/255. alpha:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:247/255. green:243./255. blue:240/255. alpha:1];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.progressArray = [[NSArray alloc] initWithObjects:@0.8, @0.65, @0.5, @0.3, @0.2, nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSArray *cells = self.tableView.visibleCells;
    CGFloat delay = 0.1;
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [cells objectAtIndex:i];
        
        CGRect cellFrame = cell.contentView.frame;
        cellFrame.size.width = 0;
        UIView *backgroundView = [[UIView alloc] initWithFrame:cellFrame];
        backgroundView.backgroundColor = [self randomColor];
        [cell.contentView addSubview:backgroundView];
        [cell.contentView sendSubviewToBack:backgroundView];
        
        [UIView animateWithDuration:0.8 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGFloat toWidth = CGRectGetWidth(cell.contentView.frame) * [self.progressArray objectAtIndex:i].doubleValue;
            CGRect toFrame = cell.contentView.frame;
            toFrame.size.width = toWidth;
            
            backgroundView.frame = toFrame;
        } completion:nil];
        delay += 0.1;
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL_IDENTIFIER];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"12";
    cell.backgroundColor = [UIColor colorWithRed:247/255. green:243./255. blue:240/255. alpha:1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(self.tableView.frame) / 5;
}

#pragma mark - Events

- (IBAction)drawerButtonDidClick:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - private methods

- (UIColor *)randomColor {
    NSArray<UIColor *> *colors = [NSArray arrayWithObjects:[UIColor iOS7lightBlueColor],
                                  [UIColor iOS7redColor],
                                  [UIColor iOS7greenColor],
                                  [UIColor iOS7yellowColor],
                                  [UIColor iOS7purpleColor],
                                  nil];
    int index =  arc4random() % colors.count;
//    
    return [colors objectAtIndex:index];
}


@end
