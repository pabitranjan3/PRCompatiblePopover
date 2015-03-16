//
//  SampleTableViewController.m
//  PRCompatiblePopover
//
//  Created by Pabitr on 16/03/15.
//  Copyright (c) 2015 BlackCode. All rights reserved.
//

#import "SampleTableViewController.h"

@interface SampleTableViewController ()

@end

@implementation SampleTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.allItems=[[NSArray alloc]initWithObjects:@"red",@"yellow",@"black", @"Blue", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SampleTableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[self.allItems objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *color=[self.allItems objectAtIndex:indexPath.row];
    if([_delegate respondsToSelector:@selector(changeBackgroundColor:)])
    {
        [_delegate changeBackgroundColor:color];
    }
}

@end
