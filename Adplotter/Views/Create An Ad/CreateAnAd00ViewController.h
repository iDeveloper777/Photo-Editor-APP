//
//  CreateAnAd00ViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 4/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@class CategoryModel;

@interface CreateAnAd00ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, ASIHTTPRequestDelegate>

@property (nonatomic, assign) NSInteger transitionType;

//Navigation View
@property (weak, nonatomic) IBOutlet UIView *navigationUIView;

@property (weak, nonatomic) IBOutlet UIView *mainView;

//Scroll View
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *photoUIView;
@property (weak, nonatomic) IBOutlet UIView *textfieldsUIView;

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *btnProduct;
@property (weak, nonatomic) IBOutlet UIButton *btnService;
@property (weak, nonatomic) IBOutlet UIButton *btnJob;
@property (weak, nonatomic) IBOutlet UIButton *btnBizOpp;
@property (weak, nonatomic) IBOutlet UIButton *btnVehicle;
@property (weak, nonatomic) IBOutlet UIButton *btnRealEstate;
@property (weak, nonatomic) IBOutlet UIButton *btnLost;


@property (weak, nonatomic) IBOutlet UILabel *lblSelectCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblRequired;
@property (weak, nonatomic) IBOutlet UIImageView *ivSelectCategory;

@property (weak, nonatomic) IBOutlet UILabel *lblCategory;


//PickerView
@property (weak, nonatomic) IBOutlet UIView *viewPicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCategory;

//Buttons Event
- (IBAction)actionCancel:(id)sender;
- (IBAction)actionDone:(id)sender;

- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;
- (IBAction)pressContinueBtn:(id)sender;

- (IBAction)pressProductBtn:(id)sender;
- (IBAction)pressServiceBtn:(id)sender;
- (IBAction)pressJobBtn:(id)sender;
- (IBAction)pressBizOppBtn:(id)sender;
- (IBAction)pressVehicleBtn:(id)sender;
- (IBAction)pressRealEstateBtn:(id)sender;
- (IBAction)pressLostBtn:(id)sender;

@end
