//
//  PRCompatiblePopoverController.h
//  PRCompatiblePopoverController
//
//  Created by Pabitr on 16/03/15.
//  Copyright (c) 2015 BlackCode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef BOOL (^ShouldDismissPopover)(void);
typedef void (^DidDismissPopover)(void);
typedef void (^WillRepositionPopover)(CGRect *,UIView **);

@class PRCompatiblePopoverController;
@protocol PRCompatiblePopoverControllerDelegate <NSObject>

@optional

- (void)prepareForCompatiblePopoverPresentation:(PRCompatiblePopoverController *)compatiblePopoverController;

- (BOOL)compatiblePopoverPresentationControllerShouldDismissPopover:(PRCompatiblePopoverController *)compatiblePopoverController;

- (void)compatiblePopoverPresentationControllerDidDismissPopover:(PRCompatiblePopoverController *)compatiblePopoverController;

- (void)compatiblePopoverPresentationController:(PRCompatiblePopoverController *)compatiblePopoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view;

@end

@interface PRCompatiblePopoverController : NSObject

@property (nonatomic) UIViewController *contentViewController;
@property (nonatomic) UIPopoverPresentationController *popoverPresentationController;
@property (nonatomic) UIPopoverController *popoverController;

@property (nonatomic,weak) id <PRCompatiblePopoverControllerDelegate> delegate;
@property (nonatomic,assign) UIPopoverArrowDirection permittedArrowDirections;
@property (nonatomic) UIView *sourceView;
@property (nonatomic,assign) CGRect sourceRect;
@property (nonatomic,assign) CGSize preferredContentSize;


@property (copy) ShouldDismissPopover shouldDismissHandler;
@property (copy) DidDismissPopover didDismissHandler;
@property (copy) WillRepositionPopover willRepositionPopoverHandler;


//Initialisation with contentView Controller and with prefered size
-(instancetype)initWithContentViewController:(UIViewController*)contentViewController
                              ofPreferedSize:(CGSize)preferredSize;

//Presenting the popover controller

-(void)presentPopoverViewOnController:(UIViewController*)presentingViewController
                             animated:(BOOL)animated completion:(void (^)(void))completion;

-(void)presentPopoverViewOnController:(UIViewController*)presentingViewController
                             animated:(BOOL)animated completion:(void (^)(void))completion
                 shouldDismissPopover:(ShouldDismissPopover)shouldDismiss
                    didDismissPopover:(DidDismissPopover)didDismiss;

-(void)presentPopoverViewOnController:(UIViewController*)presentingViewController
                             animated:(BOOL)animated completion:(void (^)(void))completion
                 shouldDismissPopover:(ShouldDismissPopover)shouldDismiss
                    didDismissPopover:(DidDismissPopover)didDismiss
                WillRepositionPopover:(WillRepositionPopover)willRepositionPopover;

//dismiss the popover controller
-(void)dismissPopoverViewOnContoller:(UIViewController*)presentingViewController
                            animated:(BOOL)animated;

-(void)dismissPopoverViewOnContoller:(UIViewController*)presentingViewController
                            animated:(BOOL)animated onCompletion:(void (^)(void))completion;



@end

