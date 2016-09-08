//
//  SignUpViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 4/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface SignUpViewController : UIViewController <UIAlertViewDelegate, ASIHTTPRequestDelegate>

//Navigation View
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;

//Notification View
@property (weak, nonatomic) IBOutlet UIView *viewNotification;
@property (weak, nonatomic) IBOutlet UIView *viewAlert;

//ForgotPassword View
@property (weak, nonatomic) IBOutlet UIView *viewForgotPassword;
@property (weak, nonatomic) IBOutlet UIView *viewForgotPasswordAlert;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmEmail;


@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;

//Main View
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@property (weak, nonatomic) IBOutlet UILabel *lblSignUp;


//Buttons Event
- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;

- (IBAction)pressRegisterBtn:(id)sender;
- (IBAction)PressFacebookBtn:(id)sender;

- (IBAction)pressLoginBtn:(id)sender;

- (IBAction)pressRegisterOKBtn:(id)sender;
- (IBAction)pressResendEmailBtn:(id)sender;

- (IBAction)pressSendMyPasswordBtn:(id)sender;

@end
