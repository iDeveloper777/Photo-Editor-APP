//
//  PicBlendSaveViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 5/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface PicBlendSaveViewController : UIViewController <UIDocumentInteractionControllerDelegate, RichTextEditorDataSource, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *navigationUIView;

//variable
@property (assign, nonatomic) int nTemplateIndex;
@property (assign, nonatomic) int isBackgroundOnOff;
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) int isText;
@property (assign, nonatomic) CGRect rectText;

@property (strong, nonatomic) RichTextEditor *txtRichTextEditor;

//Template View
@property (weak, nonatomic) IBOutlet UIView *templateUIView;

//UIView
@property (weak, nonatomic) IBOutlet UIView *imageUIView;

//UIImage
@property (strong, nonatomic) UIImage *imgOriginal01;
@property (strong, nonatomic) UIImage *imgOriginal02;
@property (strong, nonatomic) UIImage *imgOriginal03;
@property (strong, nonatomic) UIImage *imgOriginal04;

//UIImageView
@property (weak, nonatomic) IBOutlet UIImageView *imgChip01;
@property (weak, nonatomic) IBOutlet UIImageView *imgChip02;
@property (weak, nonatomic) IBOutlet UIImageView *imgChip03;
@property (weak, nonatomic) IBOutlet UIImageView *imgChip04;

//Buttons Event
- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;

- (IBAction)pressCreatePicBtn:(id)sender;
- (IBAction)pressSaveBtn:(id)sender;

@end
