//
//  BMScanViewController.h
//  Bibliomania
//
//  Created by Gu Jun on 3/5/16.
//  Copyright © 2016 com.dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BMScanViewControllerDelegate <NSObject>

- (void)scanningDidEnd:(NSArray *)bookItems;

@end

@interface BMScanViewController : UIViewController

@property (nonatomic, weak) id<BMScanViewControllerDelegate> delegate;

@end
