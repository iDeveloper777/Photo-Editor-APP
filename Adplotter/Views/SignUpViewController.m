//
//  SignUpViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 4/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "SignUpViewController.h"
#import "CustomAlert.h"
#import "SVProgressHUD.h"
#import "TheSidebarController.h"

#import "Public.h"
#import "AppDelegate.h"
#import "CreateAnAdNavi.h"
#import "MainViewController.h"

@interface SignUpViewController (){
    AppDelegate *appDelegate;
    UITextField *tmpTextField;
    
    NSString *strLink;
    int isNotification;
    int isForgotPassword;
    int originalHeight;
    
    CGRect screenSize;
    int scrollHeight;
    int scrollContentHeight;
    
    int facebookSignup;
}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [AppDelegate sharedAppDeleate];
    facebookSignup = 0;
    isNotification = 0;
    self.viewNotification.hidden = YES;
    self.viewAlert.hidden = YES;
    
    isForgotPassword = 0;
    self.viewForgotPassword.hidden = YES;
    self.viewForgotPasswordAlert.hidden = YES;
    originalHeight = self.viewForgotPasswordAlert.frame.origin.y;
    
    screenSize = [[UIScreen mainScreen] bounds];
    scrollHeight = self.scrollView.bounds.size.height;
    scrollContentHeight = scrollHeight;
    
    
    [self setLayout];
}

//UIStatusBar
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark setLayout
- (void) setLayout{
    
    _btnMenu.hidden = YES;
    _btnPlus.hidden = YES;
    
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
    
    UIView *paddingView03 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nPaddingWidth, 20)];
    self.tfFirstName.leftView = paddingView03;
    self.tfFirstName.leftViewMode = UITextFieldViewModeAlways;

    UIView *paddingView04 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nPaddingWidth, 20)];
    self.tfLastName.leftView = paddingView04;
    self.tfLastName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView05 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, nPaddingWidth, 20)];
    self.tfConfirmEmail.leftView = paddingView05;
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
    self.tfFirstName.inputAccessoryView = doneToolbar;
    self.tfLastName.inputAccessoryView = doneToolbar;
    self.tfConfirmEmail.inputAccessoryView = doneToolbar;
    
    [self.tfFirstName addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfLastName addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfEmail addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfPassword addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfConfirmEmail addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    
    //TapGesture
    UITapGestureRecognizer *singleTap02 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturePassword:)];
    singleTap02.numberOfTapsRequired = 1;
    [self.viewForgotPassword setUserInteractionEnabled:YES];
    [self.viewForgotPassword addGestureRecognizer:singleTap02];
}

#pragma mark Buttons Event
- (IBAction)pressMenuBtn:(id)sender {
}

- (IBAction)pressPlusBtn:(id)sender {
}

- (IBAction)pressRegisterBtn:(id)sender {
    [tmpTextField resignFirstResponder];
    
    if ([self isValidData]) {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
        request.delegate=self;
        
        //        NSLog(API_URL);
        
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        [request setRequestMethod:@"POST"];
        
        [request setPostValue:@"SaveUser" forKey:@"Action"];
        [request setPostValue:self.tfEmail.text forKey:@"Username"];
        [request setPostValue:self.tfEmail.text forKey:@"Email"];
        [request setPostValue:self.tfFirstName.text forKey:@"FirstName"];
        [request setPostValue:self.tfLastName.text forKey:@"LastName"];
        [request setPostValue:self.tfPassword.text forKey:@"Password"];
        [request setPostValue:@"1" forKey:@"AffiliateSponsorID"];
        
        request.tag = 100;
        [request startAsynchronous];
    }
}

- (IBAction)pressLoginBtn:(id)sender {
    YSTransitionType pushSubtype;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    LogInViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    
    pushSubtype = YSTransitionTypeFromTop;
    
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
}

- (IBAction)pressRegisterOKBtn:(id)sender {
    isNotification = 0;
    [self hideNotification];
    
    if (facebookSignup == 0){
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
        
        request.tag = 300;
        [request startAsynchronous];
    }else{
        if ([FBSDKAccessToken currentAccessToken]){
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
            
        }else{
            //        [FBSDKAccessToken setCurrentAccessToken:nil];
            //        appDelegate.isFacebookLogin = 1;
            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
            [login logInWithReadPermissions:@[@"email", @"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                if (error) {
                    // Process error
                } else if (result.isCancelled) {
                    // Handle cancellations
                } else {
                    // If you ask for multiple permissions at once, you
                    // should check if specific permissions missing
                    if ([result.grantedPermissions containsObject:@"email"]) {
                        
                    }
                }
            }];
        }
    }
}

- (IBAction)pressResendEmailBtn:(id)sender {
    isNotification = 0;
    [self hideNotification];
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
    
    request.tag = 600;
    [request startAsynchronous];
    
    [self.tfConfirmEmail resignFirstResponder];
    [self.viewForgotPasswordAlert setFrame:CGRectMake(self.viewForgotPasswordAlert.frame.origin.x, originalHeight, self.viewForgotPasswordAlert.bounds.size.width, self.viewForgotPasswordAlert.bounds.size.height)];
}

- (IBAction)PressFacebookBtn:(id)sender {
    if ([FBSDKAccessToken currentAccessToken]){
        [self getFBResult];
    }else{
        [FBSDKAccessToken setCurrentAccessToken:nil];
        //        appDelegate.isFacebookSignup = 1;
        
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
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             appDelegate.facebookEmail = [result objectForKey:@"email"];
             
             [SVProgressHUD showWithStatus:@"Loading..."];
             [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
             
             ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
             request.delegate=self;
             
             //        NSLog(API_URL);
             
             [request addRequestHeader:@"Content-Type" value:@"application/json"];
             [request addRequestHeader:@"Accept" value:@"application/json"];
             [request setRequestMethod:@"POST"];
             
             [request setPostValue:@"SaveUser" forKey:@"Action"];
             [request setPostValue:strUserID forKey:@"FacebookID"];
             [request setPostValue:appDelegate.facebookEmail forKey:@"Username"];
             [request setPostValue:appDelegate.facebookEmail forKey:@"Email"];
             [request setPostValue:[result objectForKey:@"first_name"] forKey:@"FirstName"];
             [request setPostValue:[result objectForKey:@"last_name"] forKey:@"LastName"];
             [request setPostValue:@"1" forKey:@"AffiliateSponsorID"];
             
             request.tag = 400;
             [request startAsynchronous];
             
         }
     }];

}

#pragma mark HTTP Post Request
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                         options:kNilOptions
                                                           error:&error];
    //Email signup
    if (request.tag == 100){
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        if([json objectForKey:@"Error"] == nil)
        {
            long status = (long)[[json objectForKey:@"UserID"] integerValue];
            if (status > 0){
                isNotification = 1;
                [self openNotification];
                facebookSignup = 0;
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"This email address is already registered with AdPlotter." delegate:self cancelButtonTitle:@"Go to Reset Password" otherButtonTitles:@"OK", nil];
                alertView.delegate = self;
                [alertView show];
            }
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
        }

    }
    
    //facebook signup
    if (request.tag == 200){
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        if([json objectForKey:@"Error"] == nil)
        {
            long status = (long)[[json objectForKey:@"UserID"] integerValue];
            if (status > 0){
                isNotification = 1;
                [self openNotification];
                facebookSignup = 1;
            }else{
                if (![appDelegate.facebookID isEqualToString:@""]){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"This Facebook ID is already registered with AdPlotter." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alertView.delegate = self;
                    [alertView show];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"This Facebook ID is already registered with AdPlotter." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alertView.delegate = self;
                    [alertView show];

                }
            }
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
    //Email login
    if (request.tag == 300){
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
    
    //facebook login
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
    
    //Get UserInfo
    if (request.tag == 500){
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

    //Forget Password
    if (request.tag == 600){
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        int status = (int)[[json objectForKey:@"Success"] integerValue];
        
        if(status == 1)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Your request sent successfully!" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
            
            isForgotPassword = 0;
            [self hideForgotPassword];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[json objectForKey:@"Error"] delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
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

#pragma mark - getUserInfo
- (void) getUserInfo{
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
    request.delegate=self;
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"GetUser" forKey:@"Action"];
    [request setPostValue:appDelegate.user.UserGUID forKey:@"UserGUID"];
    
    request.tag = 500;
    [request startAsynchronous];
    
}

#pragma mark gotoMainView
- (void) gotoMainView{
    appDelegate.Username = _tfEmail.text;
    appDelegate.Password = _tfPassword.text;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:_tfEmail.text forKey:@"Username"];
    [userDefaults setObject:_tfPassword.text forKey:@"Password"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    
    CreateAnAdNavi *viewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAnAdNavi"];
//    ListingManagerNavi *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ListingManagerNavi"];
    
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
    [self.viewForgotPasswordAlert setFrame:CGRectMake(self.viewForgotPasswordAlert.frame.origin.x, originalHeight, self.viewForgotPasswordAlert.bounds.size.width, self.viewForgotPasswordAlert.bounds.size.height)];
    [tmpTextField resignFirstResponder];
}

- (IBAction)cancelWithKeyboard:(id) sender{
    [self.viewForgotPasswordAlert setFrame:CGRectMake(self.viewForgotPasswordAlert.frame.origin.x, originalHeight, self.viewForgotPasswordAlert.bounds.size.width, self.viewForgotPasswordAlert.bounds.size.height)];
    [tmpTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (BOOL) beginEditingTextbox:(UITextField *)textField{
    tmpTextField = textField;
    if (isForgotPassword == 0)
        [self.scrollView setContentOffset:CGPointMake(0, [self getStateEdit:textField])];
    
    [self.viewForgotPasswordAlert setFrame:CGRectMake(self.viewForgotPasswordAlert.frame.origin.x, originalHeight - 100, self.viewForgotPasswordAlert.bounds.size.width, self.viewForgotPasswordAlert.bounds.size.height)];
    
    return TRUE;
}

- (float)getStateEdit:(UITextField *)textField {
    int nHeight, nSHeight;
    if (appDelegate.nDeviceType == 2){
        nHeight = 300;
        nSHeight = 100;
    }else if (appDelegate.nDeviceType == 1){
        nHeight = 250;
        nSHeight = 150;
    }else {
        nHeight = 500;
        nSHeight = 400;
    }
    
    if (textField.superview.frame.origin.y + textField.frame.origin.y + self.viewMain.frame.origin.y > self.scrollView.frame.size.height - nHeight ) {
        return textField.superview.frame.origin.y +  textField.frame.origin.y + self.viewMain.frame.origin.y - nSHeight;
    } else {
        return 0;
    }
}

#pragma mark -
#pragma mark -  UIKeyboard Notification

// Called when the UIKeyboardDidShowNotification is received
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    // keyboard frame is in window coordinates
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardInfoFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // get the height of the keyboard by taking into account the orientation of the device too
    CGRect windowFrame = [self.view.window convertRect:self.view.frame fromView:self.view];
    CGRect keyboardFrame = CGRectIntersection (windowFrame, keyboardInfoFrame);
    //    CGRect coveredFrame = [self.view.window convertRect:keyboardFrame toView:self.view];
    
    // make sure the scrollview content size width and height are greater than 0
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.contentSize.width, scrollContentHeight)];
    
    CGRect rect = CGRectMake(0, self.scrollView.frame.origin.y, self.scrollView.bounds.size.width, scrollHeight - keyboardFrame.size.height);
    [self.scrollView setFrame:rect];
    
}

// Called when the UIKeyboardWillHideNotification is received
- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.contentSize.width, scrollContentHeight)];
    
    [self.scrollView setFrame:CGRectMake(screenSize.origin.x, self.scrollView.frame.origin.y, screenSize.size.width, scrollHeight)];
}

#pragma mark UIAlertView Delegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self openForgotPassword];
    }else if (buttonIndex == 1){
    }
}

#pragma mark Notification View
- (void) hideNotification{
    [UIView animateWithDuration:1.0 delay:0.5 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewAlert.hidden = YES;
    }
                     completion:^(BOOL finished){
                         self.viewNotification.hidden = YES;
                     }];
}

- (void) openNotification{
    self.viewNotification.hidden = NO;
    
    [UIView animateWithDuration:1.0 delay:0.5 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewAlert.hidden = NO;
    }
                     completion:^(BOOL finished){ }];
}

#pragma mark ForgotPassword View
- (void) hideForgotPassword{
    [self.tfConfirmEmail resignFirstResponder];
    
    isForgotPassword = 0;
    [self.viewForgotPasswordAlert setFrame:CGRectMake(self.viewForgotPasswordAlert.frame.origin.x, originalHeight, self.viewForgotPasswordAlert.bounds.size.width, self.viewForgotPasswordAlert.bounds.size.height)];
    
    [UIView animateWithDuration:1.0 delay:0.5 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewForgotPasswordAlert.hidden = YES;
    }
                     completion:^(BOOL finished){
                         self.viewForgotPassword.hidden = YES;
                     }];
}

- (void) openForgotPassword{
    isForgotPassword = 1;
    
    [self.viewForgotPasswordAlert setFrame:CGRectMake(self.viewForgotPasswordAlert.frame.origin.x, originalHeight, self.viewForgotPasswordAlert.bounds.size.width, self.viewForgotPasswordAlert.bounds.size.height)];
    
    self.viewForgotPassword.hidden = NO;
    
    [UIView animateWithDuration:1.0 delay:0.5 options: UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewForgotPasswordAlert.hidden = NO;
    }
                     completion:^(BOOL finished){ }];
}
#pragma mark tapGesturePassword
- (void) tapGesturePassword: (UIGestureRecognizer *) gestureRecognizer{
    [self hideForgotPassword];
}
@end
