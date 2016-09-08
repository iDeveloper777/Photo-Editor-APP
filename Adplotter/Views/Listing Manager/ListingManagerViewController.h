//
//  ListingManagerViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 24/4/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@class AdModel;

@interface ListingManagerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

//Navigation View
@property (weak, nonatomic) IBOutlet UIView *navigationUIView;

@property (weak, nonatomic) IBOutlet UIImageView *ivStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnClick;

@property (weak, nonatomic) IBOutlet UITableView *tblListing;

//Notification
@property (weak, nonatomic) IBOutlet UIView *notificationUIView;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;


//Buttons Event
- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;

- (IBAction)pressClickBtn:(id)sender;

- (IBAction)pressCloseBtn:(id)sender;

@end
