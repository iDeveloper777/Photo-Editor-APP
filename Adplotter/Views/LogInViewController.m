//
//  LogInViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 23/4/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "LogInViewController.h"
#import "CustomAlert.h"
#import "SVProgressHUD.h"
#import "TheSidebarController.h"

#import "Public.h"
#import "AppDelegate.h"
#import "CreateAnAdNavi.h"
#import "MainViewController.h"

@interface LogInViewController (){
    AppDelegate *appDelegate;
    
    UITextField *tmpTextField;
    
    NSString *strLink;
    int isNotification;
    int originalHeight;
    
    int nAlertHeight;
    
    int nSegmentIndex;
}

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [AppDelegate sharedAppDeleate];
    appDelegate.facebookID = @"";
    
    isNotification = 0;
    self.viewNotification.hidden = YES;
    self.viewAlert.hidden = YES;
    originalHeight = self.viewAlert.frame.origin.y;
    
    nAlertHeight = _viewAlert.frame.origin.y;
    
    [self setLayout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//UIStatusBar
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark setLayout
- (void) setLayout{
    
    _btnMenu.hidden = YES;
    _btnPlus.hidden = YES;
    
    _tfEmail.text = appDelegate.Username;
    _tfPassword.text = appDelegate.Password;
    
    int nPaddingWidth;
    if (appDelegate.nDeviceType == 3)
        nPaddingWidth = 120;
    else
        nPaddingWidth = 60;
    
    UIView *paddingView01 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nPaddingWidth, 20)];
    self.tfEmail.leftView = paddingView01;
    self.tfEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView02 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nPaddingWidth, 20)];
    self.tfPassword.leftView = paddingView02;
    self.tfPassword.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView03 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nPaddingWidth-20, 20)];
    self.tfConfirmEmail.leftView = paddingView03;
    self.tfConfirmEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIToolbar *doneToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    doneToolbar.barStyle = UIBarStyleDefault;
    doneToolbar.tintColor = [UIColor blackColor];
    
    // I can't pass the textField as a parameter into an @selector
    doneToolbar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelWithKeyboard:)],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithKeyboard:)],
                         nil];
    [doneToolbar sizeToFit];
    
    self.tfEmail.inputAccessoryView = doneToolbar;
    self.tfPassword.inputAccessoryView = doneToolbar;
    self.tfConfirmEmail.inputAccessoryView = doneToolbar;
    
    [self.tfEmail addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfPassword addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfConfirmEmail addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    
    //TapGesture
    UITapGestureRecognizer *singleTap02 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturePassword:)];
    singleTap02.numberOfTapsRequired = 1;
    [self.viewNotification setUserInteractionEnabled:YES];
    [self.viewNotification addGestureRecognizer:singleTap02];
}

#pragma mark Buttons Event

- (IBAction)pressMenuBtn:(id)sender {
}

- (IBAction)pressPlusBtn:(id)sender {
}

- (IBAction)pressForgotPasswordBtn:(id)sender {
    isNotification = 1;
    [self openNotification];
}

- (IBAction)pressLogInBtn:(id)sender {
    [tmpTextField resignFirstResponder];
    
    if ([self isValidData]){
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
        request.delegate=self;
        
//        NSLog(API_URL);
        
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        [request setRequestMethod:@"POST"];
        
        [request setPostValue:@"LoginByCredentials" forKey:@"Action"];
        [request setPostValue:self.tfEmail.text forKey:@"Username"];
        [request setPostValue:self.tfPassword.text forKey:@"Password"];
        
        request.tag = 100;
        [request startAsynchronous];
    }
    
    
}

- (IBAction)pressRegisterBtn:(id)sender {
    YSTransitionType pushSubtype;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    SignUpViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"SignUpView"];
    
    pushSubtype = YSTransitionTypeFromBottom;
    
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];

}

- (IBAction)pressSendMyPasswordBtn:(id)sender {
    if (self.tfConfirmEmail.text == nil || [self.tfConfirmEmail.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"You need to enter email address." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if (![self isValidEmail:self.tfConfirmEmail.text Strict:YES]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Incorrect Email Address! You need to enter correct email address." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        //        self.tfEmail.text = @"";
        return;
    }
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
    request.delegate=self;
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"RequestResetPassword" forKey:@"Action"];
    [request setPostValue:self.tfConfirmEmail.text forKey:@"Email"];
    
    request.tag = 200;
    [request startAsynchronous];
    
    [self.tfConfirmEmail resignFirstResponder];
    [self.viewAlert setFrame:CGRectMake(self.viewAlert.frame.origin.x, nAlertHeight, self.viewAlert.bounds.size.width, self.viewAlert.bounds.size.height)];
}

- (IBAction)pressFacebookBtn:(id)sender {
    
    if ([FBSDKAccessToken currentAccessToken]){
        [self getFBResult];
    }
    else{
        [FBSDKAccessToken setCurrentAccessToken:nil];
        //        appDelegate.isFacebookLogin = 1;
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
        
        [login logInWithReadPermissions:@[@"email", @"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                // Process error
            } else if (result.isCancelled) {
                // Handle cancellations
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"email"]) {
                    if ([FBSDKAccessToken currentAccessToken]){
                        
                        [self getFBResult];
                    }
                }
            }
        }];
    }
}

#pragma mark - getFBResult
- (void) getFBResult{
    FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
    NSString *strUserID = token.userID;
    appDelegate.facebookID = strUserID;
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
    request.delegate=self;
    
    //        NSLog(API_URL);
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"LoginByFacebookID" forKey:@"Action"];
    [request setPostValue:strUserID forKey:@"FacebookID"];
    
    request.tag = 400;
    [request startAsynchronous];
}

#pragma mark HTTP Post Request
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                         options:kNilOptions
                                                           error:&error];
    //if pressed Login Button
    if (request.tag == 100){
        NSString *strGUID = (NSString *)[json objectForKey:@"GUID"];
        
        NSLog(@"%@", strGUID);
        
        if(![strGUID isEqualToString:@""])
        {
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            delegate.user.Username = self.tfEmail.text;
            delegate.user.Password = self.tfPassword.text;
            delegate.user.UserGUID = strGUID;
            
            NSString *strEmail = self.tfEmail.text;
            NSString *strPassword  = self.tfPassword.text;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:strEmail forKey:@"Username"];
            [userDefaults setObject:strPassword forKey:@"Password"];
            [userDefaults setObject:strGUID forKey:@"UserGUID"];
            [userDefaults synchronize];
            
            [self getUserInfo];
        }
        else
        {
            NSString *status = (NSString *)[json objectForKey:@"Status"];
            
            if ([status isEqualToString:@"1"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"This account is disabled. Please contact us at adplotter.com" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
                [alertView show];
            }else if ([status isEqualToString:@"2"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"This login is incorrect." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Invalid login" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            
            [SVProgressHUD dismiss];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }
    
    //Facebook Login
    if (request.tag == 400){
        NSString *status = (NSString *)[json objectForKey:@"GUID"];
        
        NSLog(@"%@", status);
        
        if(![status isEqualToString:@""])
        {
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            delegate.user.Username = self.tfEmail.text;
            delegate.user.Password = self.tfPassword.text;
            delegate.user.UserGUID = status;
            
            NSString *strEmail = self.tfEmail.text;
            NSString *strPassword  = self.tfPassword.text;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:strEmail forKey:@"Username"];
            [userDefaults setObject:strPassword forKey:@"Password"];
            [userDefaults setObject:status forKey:@"UserGUID"];
            [userDefaults synchronize];
            
            [self getUserInfo];
        }
        else
        {
            status = (NSString *)[json objectForKey:@"Status"];
            
            if ([status isEqualToString:@"1"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"This account is disabled. Please contact us at adplotter.com" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
                [alertView show];
            }else if ([status isEqualToString:@"2"]){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"This login is incorrect." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Invalid login" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
                [alertView show];
            }

            
            [SVProgressHUD dismiss];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    }
    
    //Forget Password
    if (request.tag == 200){
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        int status = (int)[[json objectForKey:@"Success"] integerValue];
        
        if(status == 1)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Your request sent successfully!" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
            
            isNotification = 0;
            [self hideNotification];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[json objectForKey:@"Error"] delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
    //Get UserInfo
    if (request.tag == 300){
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        if([json objectForKey:@"Error"] == nil)
        {
            appDelegate.user.UserID = [json objectForKey:@"UserID"];
            appDelegate.user.AffiliateSponsorID = [json objectForKey:@"AffiliateSponsorID"];
            appDelegate.user.Username = [json objectForKey:@"Username"];
            appDelegate.user.Email = [json objectForKey:@"Email"];
            appDelegate.user.FirstName = [json objectForKey:@"FirstName"];
            appDelegate.user.LastName = [json objectForKey:@"LastName"];
            appDelegate.user.Address = [json objectForKey:@"Address"];
            appDelegate.user.City = [json objectForKey:@"City"];
            appDelegate.user.State = [json objectForKey:@"State"];
            appDelegate.user.Zip = [json objectForKey:@"Zip"];
            appDelegate.user.Phone = [json objectForKey:@"Phone"];
            appDelegate.user.Country = [json objectForKey:@"Country"];
            appDelegate.user.Referer = [json objectForKey:@"Referer"];
            appDelegate.user.FacebookID = [json objectForKey:@"FacebookID"];
            
            [self performSelector:@selector(gotoMainView) withObject:nil afterDelay:0.18];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
        }

    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark getUserInfo
- (void) getUserInfo{
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
    request.delegate=self;
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"GetUser" forKey:@"Action"];
    [request setPostValue:appDelegate.user.UserGUID forKey:@"UserGUID"];
    
    request.tag = 300;
    [request startAsynchronous];

}

#pragma mark gotoMainView
- (void) gotoMainView{
    appDelegate.Username = _tfEmail.text;
    appDelegate.Password = _tfPassword.text;
    
    //if segmentedControl is On
    if (_segmentedControl.selectedSegmentIndex == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:_tfEmail.text forKey:@"Username"];
        [userDefaults setObject:_tfPassword.text forKey:@"Password"];
    }else{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:@"" forKey:@"Username"];
        [userDefaults setObject:@"" forKey:@"Password"];
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    
//    CreateAnAdNavi *viewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAnAdNavi"];
    ListingManagerNavi *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ListingManagerNavi"];
    
    MainViewController *menu = [storyboard instantiateViewControllerWithIdentifier:@"MainView"];
    TheSidebarController *siderbarController = [[TheSidebarController alloc] initWithContentViewController:viewController leftSidebarViewController:menu];
    
    [self.navigationController pushViewController:siderbarController animated:TRUE];
}

#pragma mark Check Login Data

- (BOOL) isValidData{
    if (self.tfEmail.text == nil || [self.tfEmail.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Email address is required." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    if (self.tfPassword.text == nil || [self.tfPassword.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Password is requirecd." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    // confirm email type
//    if (![self isValidEmail:self.tfEmail.text Strict:YES]) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Incorrect Email Address! Please input Email Address again." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
//        [alertView show];
//        //        self.tfEmail.text = @"";
//        return  FALSE;
//    }
    
    return TRUE;
}

-(BOOL) isValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = strictFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

#pragma mark Keyboard Events
- (IBAction) doneWithKeyboard:(id) sender{
    [self.viewAlert setFrame:CGRectMake(self.viewAlert.frame.origin.x, originalHeight, self.viewAlert.bounds.size.width, self.viewAlert.bounds.size.height)];
    
    [tmpTextField resignFirstResponder];
    [_viewMain setFrame:RECT_CHANGE_y(_viewMain, 64)];
}

- (IBAction)cancelWithKeyboard:(id) sender{
    [self.viewAlert setFrame:CGRectMake(self.viewAlert.frame.origin.x, originalHeight, self.viewAlert.bounds.size.width, self.viewAlert.bounds.size.height)];
    
    [tmpTextField resignFirstResponder];
    [_viewMain setFrame:RECT_CHANGE_y(_viewMain, 64)];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (BOOL) beginEditingTextbox:(UITextField *)textField{
    [self.viewAlert setFrame:CGRectMake(self.viewAlert.frame.origin.x, originalHeight - 100, self.viewAlert.bounds.size.width, self.viewAlert.bounds.size.height)];
    tmpTextField = textField;
    [_viewMain setFrame:RECT_CHANGE_y(_viewMain, 0)];
    return TRUE;
}

#pragma mark Notification View

- (void) hideNotification{
    [self.viewAlert setFrame:CGRectMake(self.viewAlert.frame.origin.x, originalHeight, self.viewAlert.bounds.size.width, self.viewAlert.bounds.size.height)];
    
    [_tfConfirmEmail resignFirstResponder];
    [UIView animateWithDuration:1.0 delay:0.5 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewAlert.hidden = YES;
    }
                     completion:^(BOOL finished){
                         self.viewNotification.hidden = YES;
                     }];
}

- (void) openNotification{
    [self.viewAlert setFrame:CGRectMake(self.viewAlert.frame.origin.x, originalHeight, self.viewAlert.bounds.size.width, self.viewAlert.bounds.size.height)];
    
    [tmpTextField resignFirstResponder];
    
    self.viewNotification.hidden = NO;
    
    [UIView animateWithDuration:1.0 delay:0.5 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewAlert.hidden = NO;
    }
                     completion:^(BOOL finished){ }];
}

#pragma mark tapGesturePassword
- (void) tapGesturePassword: (UIGestureRecognizer *) gestureRecognizer{
    [self hideNotification];
}

@end
