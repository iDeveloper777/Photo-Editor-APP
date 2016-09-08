//
//  HelpViewController.h
//  Adplotter
//
//  Created by Csaba Toth on 6/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

@interface HelpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

//Buttons Event
- (IBAction)pressMenuBtn:(id)sender;
- (IBAction)pressPlusBtn:(id)sender;
@end
