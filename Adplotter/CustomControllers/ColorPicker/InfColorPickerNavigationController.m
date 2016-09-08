
//  InfColorPickerNavigationController.m
//  Color SMS
//
//  Created by Alex on 2/9/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "InfColorPickerNavigationController.h"

//------------------------------------------------------------------------------

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC enabled (-fobjc-arc).
#endif

@implementation InfColorPickerNavigationController


- (BOOL) shouldAutorotate
{
	return [self.topViewController shouldAutorotate];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
	return [self.topViewController shouldAutorotateToInterfaceOrientation: interfaceOrientation];
}

- (NSUInteger) supportedInterfaceOrientations
{
	return self.topViewController.supportedInterfaceOrientations;
}

 
@end
