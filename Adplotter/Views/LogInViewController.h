//
//  LogInViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 23/4/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LogInViewController : UIViewController <ASIHTTPRequestDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;

@property (weak, nonatomic) IBOutlet UIView *viewMain;

@property (weak, nonatomic) IBOutlet UIView *viewNotification;
@property (weak, nonatomic) IBOutlet UIView *viewAlert;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmEmail;

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UILabel *lblSignUp;


//Buttons Event
- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;
- (IBAction)pressForgotPasswordBtn:(id)sender;
- (IBAction)pressLogInBtn:(id)sender;
- (IBAction)pressRegisterBtn:(id)sender;
- (IBAction)pressFacebookBtn:(id)sender;

- (IBAction)pressSendMyPasswordBtn:(id)sender;

@end
