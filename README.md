# PRCompatiblePopover

This is written in objective c and  uses "Block" instead of delegates of UIPopoverController(<iOS8) and UIPopoverPresentationController(>iOS8).

    [compatiblePopoverController setShouldDismissHandler:^
    {
      return YES;
      }];

This line of code replaces the delegate code of UIPopoverController :

      - (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
and delegate code of UIPopoverPresentationController:

      - (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController

Similarly all the delegate methods replace with Block of code for better use in the app.


# How to Use
Code samples are provided in the demo project.

# Intialization of compatiblePopoverController

    compatiblePopoverController = [[PRCompatiblePopoverController alloc] initWithContentViewController:sampleTableViewConroller ofPreferedSize:CGSizeMake(150.0, 200.0)];

# setSourceView:

    [compatiblePopoverController setSourceView:sender];

# setSourceRect:

     [compatiblePopoverController setSourceRect:sender.bounds];

# setPermittedArrowDirections:

     [compatiblePopoverController setPermittedArrowDirections:UIPopoverArrowDirectionAny];

# Present compatible popover controller

     [compatiblePopoverController presentPopoverViewOnController:self
                                                       animated:YES completion:NULL];


# License:
"PRCompatiblePopover" is licensed under the MIT License. See LICENSE for details.


