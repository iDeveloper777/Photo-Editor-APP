//
//  HelpViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 6/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "HelpViewController.h"
#import "TheSidebarController.h"
#import "Public.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface HelpViewController (){
    NSString *strLink;
}

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    AppDelegate *appDelegate = [AppDelegate sharedAppDeleate];
    if (appDelegate.isHelpAbout == 0){
        strLink = @"http://adplotter.com/apppages/help.html";
        _lblTitle.text = @"Help";
    }else{
        strLink = @"http://adplotter.com/apppages/about.html";
        _lblTitle.text = @"About us";
    }
    
    self.webView.scalesPageToFit = YES;

    NSURL *url = [NSURL URLWithString:strLink];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    
}

//UIStatusBar
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Buttons Event
- (IBAction)pressMenuBtn:(id)sender {
    if(self.sidebarController.sidebarIsPresenting)
        [self.sidebarController dismissSidebarViewController];
    else
        [self.sidebarController presentLeftSidebarViewControllerWithStyle:SLIDE_MENU_STYLE];
}

- (IBAction)pressPlusBtn:(id)sender {
    YSTransitionType pushSubtype;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    CreateAnAd00ViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAnAd00View"];
    
    pushSubtype = YSTransitionTypeFromBottom;
    
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
}
@end
