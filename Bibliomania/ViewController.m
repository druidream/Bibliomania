//
//  ViewController.m
//  Bibliomania
//
//  Created by Gu Jun on 1/27/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import "ViewController.h"
#import "BookService.h"
#import "BookItem.h"
#import "BookItem+CoreDataProperties.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BookService *service = [[BookService alloc] init];
//    BookItem *newBook = [[BookItem alloc] initWithEntity:<#(nonnull NSEntityDescription *)#> insertIntoManagedObjectContext:nil];
    BookItem *book = [service createBook];
    [book setValue:@"second value" forKey:@"name"];
    [service saveChanges];
    
    
    NSLog(@"%lu", (unsigned long)[[service retrieveBook:nil] count]);
    BookItem *item = [[service retrieveBook:nil] objectAtIndex:0];
    NSLog(@"%@", item);
    
//    [NSString stringWithUTF8String:@"\U9644\U5f55A"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
