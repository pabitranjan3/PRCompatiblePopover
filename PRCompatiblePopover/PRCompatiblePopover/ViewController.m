//
//  ViewController.m
//  PRCompatiblePopover
//
//  Created by Pabitr on 16/03/15.
//  Copyright (c) 2015 BlackCode. All rights reserved.
//

#import "ViewController.h"
#import "SampleTableViewController.h"
#import "PRCompatiblePopoverController.h"

@interface ViewController ()<SampleTableViewControllerDelegate>
{
    PRCompatiblePopoverController *compatiblePopoverController;

}
- (IBAction)showPoppover:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPoppover:(UIButton *)sender {
    
   SampleTableViewController *sampleTableViewConroller = [[self storyboard] instantiateViewControllerWithIdentifier:@"SampleTableViewController"];
    sampleTableViewConroller.delegate = self;
    
    compatiblePopoverController = [[PRCompatiblePopoverController alloc] initWithContentViewController:sampleTableViewConroller ofPreferedSize:CGSizeMake(150.0, 200.0)];
    [compatiblePopoverController setSourceView:sender];
    [compatiblePopoverController setSourceRect:sender.bounds];
    [compatiblePopoverController setPermittedArrowDirections:UIPopoverArrowDirectionAny];
    [compatiblePopoverController presentPopoverViewOnController:self
                                                       animated:YES completion:NULL];
    [compatiblePopoverController setShouldDismissHandler:^
     {
         return YES;
     }];
    [compatiblePopoverController setDidDismissHandler:^
     {
         NSLog(@"Did dismiss...");
     }];
    
}
-(void)changeBackgroundColor:(NSString*)color
{
    [compatiblePopoverController dismissPopoverViewOnContoller:self animated:YES onCompletion:^{
        NSLog(@"Didmissed...");
    }];
}


@end
