//
//  SampleTableViewController.h
//  PRCompatiblePopover
//
//  Created by Pabitr on 16/03/15.
//  Copyright (c) 2015 BlackCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SampleTableViewControllerDelegate <NSObject>
-(void)changeBackgroundColor:(NSString*)color;
@end

@interface SampleTableViewController : UITableViewController
@property (weak,nonatomic) id <SampleTableViewControllerDelegate> delegate;

@property (nonatomic) NSArray *allItems;

@end
