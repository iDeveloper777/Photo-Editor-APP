//
//  PicBlendOption01ViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 5/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface PicBlendOption01ViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate, CropImageDelegate, InfColorPickerControllerDelegate, RichTextEditorDataSource, UITextViewDelegate, UIGestureRecognizerDelegate>

@property (assign, nonatomic) int nTemplateIndex;

@property (weak, nonatomic) IBOutlet UIImageView *imgBorderColor;

@property (weak, nonatomic) IBOutlet RichTextEditor *txtRichTextEditor;
@property (weak, nonatomic) IBOutlet UIView *clearView;

//Template View
@property (weak, nonatomic) IBOutlet UIView *templateUIView;

//Background View
@property (weak, nonatomic) IBOutlet UIView *backgroundUIView;
@property (weak, nonatomic) IBOutlet UIImageView *imgChip01;
@property (weak, nonatomic) IBOutlet UIImageView *imgChip02;
@property (weak, nonatomic) IBOutlet UIImageView *imgChip03;
@property (weak, nonatomic) IBOutlet UIImageView *imgChip04;

@property (weak, nonatomic) IBOutlet UIView *bottomUIView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segBorder;


//Buttons Event
- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;

- (IBAction)pressTextBtn:(id)sender;
- (IBAction)pressBorderColorBtn:(id)sender;
- (IBAction)pressContinueBtn:(id)sender;
- (IBAction)pressColorPickerBtn:(id)sender;

//On/Off Event
- (IBAction)valueChange:(id)sender;

@end
