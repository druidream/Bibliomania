//
//  ViewController.m
//  Bibliomania
//
//  Created by Gu Jun on 1/27/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "ViewController.h"
#import "REFrostedViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)awakeFromNib
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)testButtonDidClick:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

@end
