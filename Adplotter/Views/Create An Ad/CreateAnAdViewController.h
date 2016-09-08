//
//  CreateAnAdViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 20/04/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@class CategoryModel;
@class AdModel;

@interface CreateAnAdViewController : UIViewController<UIImagePickerControllerDelegate, CropImageDelegate, UITextFieldDelegate, UIAlertViewDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) AdModel *currentAd;
@property (strong, nonatomic) NSString *strParent;
@property (strong, nonatomic) UIImage *imgAd;

//Navigation View
@property (weak, nonatomic) IBOutlet UIView *navigationUIView;

//Scroll View
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *categoryUIView;
@property (weak, nonatomic) IBOutlet UILabel *lblParentCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;

@property (weak, nonatomic) IBOutlet UIView *photoUIView;
@property (weak, nonatomic) IBOutlet UIView *textfieldUIView;

@property (weak, nonatomic) IBOutlet UITextField *tfTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfDescription;
@property (weak, nonatomic) IBOutlet UITextField *tfPrice;

@property (weak, nonatomic) IBOutlet UIImageView *ivImage;
@property (weak, nonatomic) IBOutlet UIButton *btnChange;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@property (weak, nonatomic) IBOutlet UIButton *btnPicBlend;
@property (weak, nonatomic) IBOutlet UIButton *btnBrowsePhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;


- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;

- (IBAction)pressPicBlendBtn:(id)sender;
- (IBAction)pressBrowsePhotoBtn:(id)sender;
- (IBAction)pressTakePhotoBtn:(id)sender;

- (IBAction)pressChangeBtn:(id)sender;
- (IBAction)pressDeleteBtn:(id)sender;


- (IBAction)pressSaveBtn:(id)sender;

@end
