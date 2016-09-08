//
//  PicBlendTemplateViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 4/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface PicBlendTemplateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgSelected;

@property (weak, nonatomic) IBOutlet UIButton *btnTemplate00;
@property (weak, nonatomic) IBOutlet UIButton *btnTemplate01;
@property (weak, nonatomic) IBOutlet UIButton *btnTemplate02;
@property (weak, nonatomic) IBOutlet UIButton *btnTemplate03;
@property (weak, nonatomic) IBOutlet UIButton *btnTemplate04;
@property (weak, nonatomic) IBOutlet UIButton *btnTemplate05;
@property (weak, nonatomic) IBOutlet UIButton *btnTemplate06;

- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;

- (IBAction)pressTemplate00:(id)sender;
- (IBAction)pressTemplate01:(id)sender;
- (IBAction)pressTemplate02:(id)sender;
- (IBAction)pressTemplate03:(id)sender;
- (IBAction)pressTemplate04:(id)sender;
- (IBAction)pressTemplate05:(id)sender;
- (IBAction)pressTemplate06:(id)sender;

- (IBAction)pressContinueBtn:(id)sender;
@end
