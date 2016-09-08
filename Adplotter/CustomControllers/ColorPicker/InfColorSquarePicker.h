
//  InfColorSquarePicker.h
//  Color SMS
//
//  Created by Alex on 2/9/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface InfColorSquareView : UIImageView

@property (nonatomic) float hue;

@end

@interface InfColorSquarePicker : UIControl

@property (nonatomic) float hue;
@property (nonatomic) CGPoint value;

@end

 