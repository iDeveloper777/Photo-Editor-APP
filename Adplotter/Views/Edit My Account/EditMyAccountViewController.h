//
//  EditMyAccountViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 4/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@class PaymentsModel;

@interface EditMyAccountViewController : UIViewController

//Navigation View
@property (weak, nonatomic) IBOutlet UIView *navigationUIView;

//Scroll View
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//Segement View
@property (weak, nonatomic) IBOutlet UIView *segmentedUIView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedController;

//Edit My Account View
@property (weak, nonatomic) IBOutlet UIView *EditMyAccountUIView;

@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPassword;

@property (weak, nonatomic) IBOutlet UILabel *lblPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblConfirmPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;

//Billing Information View
@property (weak, nonatomic) IBOutlet UIView *BillingInfoUIView;
@property (weak, nonatomic) IBOutlet UIButton *btnGoToSite;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;

//Payment History View
@property (weak, nonatomic) IBOutlet UIView *PaymentHistoryUIView;
@property (weak, nonatomic) IBOutlet UITableView *tvPaymentHistory;

- (IBAction)segmentedControlIndexChanged:(id)sender;

//Buttons Event
- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;

- (IBAction)pressSaveBtn:(id)sender;

- (IBAction)pressGoToSiteBtn:(id)sender;
@end
