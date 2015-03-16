//
//  PRCompatiblePopoverController.m
//  PRCompatiblePopoverController
//
//  Created by Pabitr on 16/03/15.
//  Copyright (c) 2015 BlackCode. All rights reserved.
//

#import "PRCompatiblePopoverController.h"

@interface PRCompatiblePopoverController()<UIPopoverControllerDelegate,UIPopoverPresentationControllerDelegate>

@end

@implementation PRCompatiblePopoverController

-(instancetype)initWithContentViewController:(UIViewController*)contentViewController
                              ofPreferedSize:(CGSize)preferredSize
{
    if (self == [super init]) {
        _contentViewController = contentViewController;
        _preferredContentSize = preferredSize;
    }
    return self;
}

-(void)presentPopoverViewOnController:(UIViewController*)presentingViewController
                             animated:(BOOL)animated completion:(void (^)(void))completion;
{
    if ([UIPopoverPresentationController class]) {
        //Presented popover in iOS8
        _contentViewController.modalPresentationStyle = UIModalPresentationPopover;
        _contentViewController.preferredContentSize = self.preferredContentSize;
        UIPopoverPresentationController *popoverPresentation = _contentViewController.popoverPresentationController;
        popoverPresentation.delegate = self;
        self.popoverPresentationController = popoverPresentation;
        [self.popoverPresentationController setSourceView:_sourceView];
        [self.popoverPresentationController setSourceRect:_sourceRect];
        [self.popoverPresentationController setPermittedArrowDirections:_permittedArrowDirections];
        [presentingViewController presentViewController:_contentViewController
                                               animated:animated
                                             completion:^{
                                                 if (completion)
                                                     completion();
                                             }];
    }
    else {
        //for iOS earlier version
        UIPopoverController *popoverController =
        [[UIPopoverController alloc] initWithContentViewController:_contentViewController];
        popoverController.delegate = self;
        self.popoverController = popoverController;
        self.popoverController.popoverContentSize = self.preferredContentSize;
        [self.popoverController presentPopoverFromRect:_sourceRect
                                                inView:_sourceView
                              permittedArrowDirections:_permittedArrowDirections
                                              animated:animated];
        if (completion)
            completion();
    }

}
-(void)presentPopoverViewOnController:(UIViewController*)presentingViewController
                             animated:(BOOL)animated
                           completion:(void (^)(void))completion
                 shouldDismissPopover:(ShouldDismissPopover)shouldDismiss
                    didDismissPopover:(DidDismissPopover)didDismiss;
{
    self.shouldDismissHandler = shouldDismiss;
    self.didDismissHandler = didDismiss;
    [self presentPopoverViewOnController:presentingViewController
                                animated:animated
                              completion:completion];
}

-(void)presentPopoverViewOnController:(UIViewController*)presentingViewController
                             animated:(BOOL)animated completion:(void (^)(void))completion
                 shouldDismissPopover:(ShouldDismissPopover)shouldDismiss
                    didDismissPopover:(DidDismissPopover)didDismiss
                WillRepositionPopover:(WillRepositionPopover)willRepositionPopover
{
    self.shouldDismissHandler = shouldDismiss;
    self.didDismissHandler = didDismiss;
    self.willRepositionPopoverHandler = willRepositionPopover;
    
    [self presentPopoverViewOnController:presentingViewController
                                animated:animated
                              completion:completion];
    
}

-(void)dismissPopoverViewOnContoller:(UIViewController*)presentingViewController
                            animated:(BOOL)animated{
    if([UIPopoverPresentationController class]){
        if ([presentingViewController presentedViewController]) {
            [presentingViewController dismissViewControllerAnimated:animated
                                                         completion:nil];
        }
    }
    else{
        if ([self.popoverController isPopoverVisible]){
            [self.popoverController dismissPopoverAnimated:animated];
        }
        
    }
}
-(void)dismissPopoverViewOnContoller:(UIViewController*)presentingViewController
                            animated:(BOOL)animated onCompletion:(void (^)(void))completion
{
    if([UIPopoverPresentationController class]){
        if ([presentingViewController presentedViewController]) {
            [presentingViewController dismissViewControllerAnimated:animated
                                                         completion:^{
                                                             if (completion) {
                                                                 completion();
                                                             }
                                                         }];
        }
    }
    else{
        if ([self.popoverController isPopoverVisible]){
            [self.popoverController dismissPopoverAnimated:animated];
        }
        if (completion) {
            completion();
        }
        
    }
}

#pragma mark ---
#pragma mark --- UIPopoverController delegate ---

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    if ([_delegate respondsToSelector:@selector(compatiblePopoverPresentationControllerShouldDismissPopover:)])
        return [_delegate compatiblePopoverPresentationControllerShouldDismissPopover:self];
    else if (self.shouldDismissHandler)
        return self.shouldDismissHandler();
    
    return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    
    if ([_delegate respondsToSelector:@selector(compatiblePopoverPresentationControllerDidDismissPopover:)])
        [_delegate compatiblePopoverPresentationControllerDidDismissPopover:self];
    
    else if (self.didDismissHandler)
        self.didDismissHandler();
    
}

- (void)popoverController:(UIPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view NS_AVAILABLE_IOS(7_0){
    
    CGRect anotherRect;
    __autoreleasing UIView *anotherInView;
    if([_delegate respondsToSelector:@selector(compatiblePopoverPresentationController:
                                               willRepositionPopoverToRect:
                                               inView:)])
        [_delegate compatiblePopoverPresentationController:self
                               willRepositionPopoverToRect:&anotherRect
                                                    inView:&anotherInView];
    else if (self.willRepositionPopoverHandler)
        self.willRepositionPopoverHandler(&anotherRect, &anotherInView);
    
    if (&anotherRect != NULL)rect = &anotherRect;
    
    if (&anotherInView != NULL) view = &anotherInView;
    
    
}

#pragma mark ---
#pragma mark --- UIPopoverPresentationController Delegate ---

- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController{
    
    if ([_delegate respondsToSelector:@selector(prepareForCompatiblePopoverPresentation:)])
        [_delegate prepareForCompatiblePopoverPresentation:self];
    
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    if ([_delegate respondsToSelector:@selector(compatiblePopoverPresentationControllerShouldDismissPopover:)])
        return [_delegate compatiblePopoverPresentationControllerShouldDismissPopover:self];
    else if (self.shouldDismissHandler)
        return self.shouldDismissHandler();
    return YES;
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    if ([_delegate respondsToSelector:@selector(compatiblePopoverPresentationControllerDidDismissPopover:)])
        [_delegate compatiblePopoverPresentationControllerDidDismissPopover:self];
    
    else if (self.didDismissHandler)
        self.didDismissHandler();
    
}

- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view{
    
    CGRect anotherRect;
    __autoreleasing UIView *anotherInView;
    if([_delegate respondsToSelector:@selector(compatiblePopoverPresentationController:willRepositionPopoverToRect:inView:)])
        [_delegate compatiblePopoverPresentationController:self
                               willRepositionPopoverToRect:&anotherRect
                                                    inView:&anotherInView];
    else if (self.willRepositionPopoverHandler)
        self.willRepositionPopoverHandler(&anotherRect, &anotherInView);
    
    if (&anotherRect != NULL)rect = &anotherRect;
}



@end


    