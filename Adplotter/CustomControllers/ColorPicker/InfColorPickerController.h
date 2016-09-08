
//  InfColorPickerController.h
//  Color SMS
//
//  Created by Alex on 2/9/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol InfColorPickerControllerDelegate;
 
@interface InfColorPickerController : UIViewController

// Public API:

+ (InfColorPickerController*) colorPickerViewController;
+ (CGSize) idealSizeForViewInPopover;

- (void) presentModallyOverViewController: (UIViewController*) controller;

@property (nonatomic) UIColor* sourceColor;
@property (nonatomic) UIColor* resultColor;

@property (weak, nonatomic) id <InfColorPickerControllerDelegate> delegate;

@end

//------------------------------------------------------------------------------

@protocol InfColorPickerControllerDelegate

@optional

- (void) colorPickerControllerDidFinish: (InfColorPickerController*) controller;
	// This is only called when the color picker is presented modally.

- (void) colorPickerControllerDidChangeColor: (InfColorPickerController*) controller;

@end

//------------------------------------------------------------------------------
