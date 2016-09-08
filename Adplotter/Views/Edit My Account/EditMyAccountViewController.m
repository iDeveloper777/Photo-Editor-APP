//
//  EditMyAccountViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 4/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "EditMyAccountViewController.h"
#import "TheSidebarController.h"
#import "Public.h"
#import "AppDelegate.h"

@interface EditMyAccountViewController (){
    AppDelegate * appDelegate;
    
    UITextField *tmpTextField;

    CGRect screenSize;
    int scrollHeight;
    int scrollContentHeight;
    
    int nSegmentIndex;
    int pageIndex;
    int isEmpty;
    int isLoading;
    NSMutableArray *arrPayments;
}

@end

@implementation EditMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate = [AppDelegate sharedAppDeleate];
    nSegmentIndex = appDelegate.nSegmentIndex;
    [self.segmentedController setSelectedSegmentIndex:nSegmentIndex];
    
    if (nSegmentIndex == 0) { //Edit My Account
        _EditMyAccountUIView.hidden = NO;
        _BillingInfoUIView.hidden = YES;
        _PaymentHistoryUIView.hidden = YES;
    }else if (nSegmentIndex == 1){ //Billing Information
        _EditMyAccountUIView.hidden = YES;
        _BillingInfoUIView.hidden = NO;
        _PaymentHistoryUIView.hidden = YES;
        [self getBillingInfo];
    }else if (nSegmentIndex == 2){
        _EditMyAccountUIView.hidden = YES;
        _BillingInfoUIView.hidden = YES;
        _PaymentHistoryUIView.hidden = NO;
        [self getPaymentHistory];
    }
    
    screenSize = [[UIScreen mainScreen] bounds];
    scrollHeight = self.view.bounds.size.height - self.navigationUIView.bounds.size.height;
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
    _txtMessage.hidden = YES;
    
    _tfFirstName.text = appDelegate.user.FirstName;
    _tfLastName.text = appDelegate.user.LastName;
    _tfEmail.text = appDelegate.user.Email;
    
    if (![appDelegate.facebookID isEqualToString:@""]){
        _lblPassword.hidden = YES;
        _tfPassword.hidden = YES;
        _lblConfirmPassword.hidden = YES;
        _tfConfirmPassword.hidden = YES;
        
        [_btnSave setFrame:RECT_CHANGE_point(_btnSave, _btnSave.frame.origin.x, _tfPassword.frame.origin.y)];
    }
    
    UIFont *font = [UIFont systemFontOfSize:10.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [self.segmentedController setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    
    UIFont *font01 = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes01 = [NSDictionary dictionaryWithObject:font01
                                                           forKey:UITextAttributeFont];
    [self.segmentedController setTitleTextAttributes:attributes01
                                            forState:UIControlStateSelected];
    //TextFields
    UIView *paddingView02 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.tfFirstName.leftView = paddingView02;
    self.tfFirstName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView03 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.tfLastName.leftView = paddingView03;
    self.tfLastName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView04 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.tfEmail.leftView = paddingView04;
    self.tfEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView05 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.tfPassword.leftView = paddingView05;
    self.tfPassword.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView06 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.tfConfirmPassword.leftView = paddingView06;
    self.tfConfirmPassword.leftViewMode = UITextFieldViewModeAlways;
    //------Textfields end----
    
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
    
    self.tfFirstName.inputAccessoryView = doneToolbar;
    self.tfLastName.inputAccessoryView = doneToolbar;
    self.tfEmail.inputAccessoryView = doneToolbar;
    self.tfPassword.inputAccessoryView = doneToolbar;
    self.tfConfirmPassword.inputAccessoryView = doneToolbar;
    
    [self.tfFirstName addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfLastName addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfEmail addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfPassword addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfConfirmPassword addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
}


#pragma mark Buttons Event
- (IBAction)segmentedControlIndexChanged:(id)sender {
    [tmpTextField resignFirstResponder];
    
    nSegmentIndex = (int)_segmentedController.selectedSegmentIndex;
    
    if (nSegmentIndex == 0) { //Edit My Account
        _EditMyAccountUIView.hidden = NO;
        _BillingInfoUIView.hidden = YES;
        _PaymentHistoryUIView.hidden = YES;
    }else if (nSegmentIndex == 1){ //Billing Information
        _EditMyAccountUIView.hidden = YES;
        _BillingInfoUIView.hidden = NO;
        _PaymentHistoryUIView.hidden = YES;
        [self getBillingInfo];
    }else if (nSegmentIndex == 2){
        _EditMyAccountUIView.hidden = YES;
        _BillingInfoUIView.hidden = YES;
        _PaymentHistoryUIView.hidden = NO;
        [self getPaymentHistory];
    }
}

- (IBAction)pressMenuBtn:(id)sender {
    [tmpTextField resignFirstResponder];
    
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
    
//    [self.navigationController pushViewController:tpViewController animated:YES];
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
}

- (IBAction)pressSaveBtn:(id)sender {
    [tmpTextField resignFirstResponder];
    
    if ([self isValidData]){
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
        request.delegate=self;
        
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        [request setRequestMethod:@"POST"];
        
        [request setPostValue:@"SaveUser" forKey:@"Action"];
        [request setPostValue:appDelegate.user.UserGUID forKey:@"UserGUID"];
        if (![appDelegate.facebookID isEqualToString:@""]) {
            [request setPostValue:appDelegate.facebookID forKey:@"FacebookID"];
        }
        [request setPostValue:@"1" forKey:@"AffiliateSponsorID"];
        [request setPostValue:self.tfEmail.text forKey:@"Username"];
        [request setPostValue:self.tfFirstName.text forKey:@"FirstName"];
        [request setPostValue:self.tfLastName.text forKey:@"LastName"];
        [request setPostValue:self.tfEmail.text forKey:@"Email"];
        if (![self.tfPassword.text isEqualToString:@""])
            [request setPostValue:self.tfPassword.text forKey:@"Password"];
        
        request.tag = 100;
        [request startAsynchronous];
    }

}

- (IBAction)pressGoToSiteBtn:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Website_URL]];
}

#pragma mark getBillingInfo
- (void) getBillingInfo{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
    request.delegate=self;
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"GetHasCards" forKey:@"Action"];
    [request setPostValue:appDelegate.user.UserGUID forKey:@"UserGUID"];
    
    request.tag = 200;
    [request startAsynchronous];
}

#pragma mark getPaymentHistory
- (void) getPaymentHistory{
    pageIndex = 1;
    isEmpty = 0;
    isLoading = 0;
    
    arrPayments = [NSMutableArray new];
    
    [self initPaymentHistory:pageIndex];
}

#pragma mark initPaymentHistory
- (void) initPaymentHistory: (int) nIndex{
    if (isEmpty == 1) {
        nIndex--;
        return;
    }
    
    isLoading = 1;
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
    request.delegate=self;
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"GetTransactionHistory" forKey:@"Action"];
    [request setPostValue:appDelegate.user.UserGUID forKey:@"UserGUID"];
    //    [request setPostValue:@"Sdfasdf" forKey:@"UserGUID"];
    [request setPostValue:[NSString stringWithFormat:@"%d", nIndex] forKey:@"PageIndex"];
    [request setPostValue:@"10" forKey:@"NumPerPage"];
    
    request.tag = 300;
    [request startAsynchronous];
}

#pragma mark HTTP Post Request
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                         options:kNilOptions
                                                           error:&error];
    if (request.tag == 100){//Edit My Account
        if([json objectForKey:@"Error"] == nil)
        {
            long status = (long)[[json objectForKey:@"UserID"] integerValue];
            if (status > 0){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Account updated" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
                [alertView show];
                
                appDelegate.user.Username = _tfEmail.text;
                appDelegate.user.FirstName = _tfFirstName.text;
                appDelegate.user.LastName = _tfLastName.text;
                appDelegate.user.Email = _tfEmail.text;
                appDelegate.user.Password = _tfPassword.text;
                
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"I got an error when trying to save" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
    if (request.tag == 200){//Edit My Account
        NSString *str = [[NSString alloc] initWithData:request.responseData encoding:NSASCIIStringEncoding];
        
        if([str isEqualToString:@"true"]){
            _txtMessage.hidden = NO;
            _txtMessage.text = @"Our system shows you have stored payment information with AdPlotter. You may access edit this information by going to www.adplotter.com and logging in.";
        }else if ([str isEqualToString:@"false"]){
            _txtMessage.hidden = NO;
            _txtMessage.text = @"You do not have any saved payment information.";
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }

    if (request.tag == 300){ //Payment History
        isLoading = 0;
        
        NSMutableArray *jsonData = [NSMutableArray new];
        jsonData = (NSMutableArray *)json;
        
        if (jsonData.count == 0){
            isEmpty = 1;
            return;
        }
        NSDictionary *tempDic = [jsonData objectAtIndex:0];
        
        if([tempDic objectForKey:@"Error"] == nil)
            //    if (jsonData.count != 0)
        {
            for (int i=0; i<jsonData.count; i++){
                NSDictionary *dic = [jsonData objectAtIndex:i];
                
                PaymentsModel *payment = [[PaymentsModel alloc] initWithData:(NSString *)[dic objectForKey:@"UserID"]
                                                                     Invoice:(NSString *)[dic objectForKey:@"Invoice"]
                                                                 Transaction:(NSString *)[dic objectForKey:@"APITransactionID"]
                                                                        Date:(NSString *)[dic objectForKey:@"TransactionDate"]
                                                                      Amount:(NSString *)[dic objectForKey:@"Amount"]
                                                                     Details:(NSString *)[dic objectForKey:@"Details"]];
                [arrPayments addObject:payment];
            }
            
            [_tvPaymentHistory reloadData];
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (BOOL) beginEditingTextbox:(UITextField *)textField{
    tmpTextField = textField;
    [self.scrollView setContentOffset:CGPointMake(0, [self getStateEdit:textField])];
    
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

    if (textField.superview.frame.origin.y + textField.frame.origin.y + self.scrollView.frame.origin.y > self.scrollView.frame.size.height - nHeight ) {
        return textField.superview.frame.origin.y +  textField.frame.origin.y + self.scrollView.frame.origin.y - nSHeight;
    } else {
        return 0;
    }
}


#pragma mark -
#pragma mark Keyboard Events
- (IBAction) doneWithKeyboard:(id) sender{
    [tmpTextField resignFirstResponder];
}

- (IBAction)cancelWithKeyboard:(id) sender{
    [tmpTextField resignFirstResponder];
}

#pragma mark UIKeyboard Notification

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

#pragma mark Check Login Data

- (BOOL) isValidData{
    if (self.tfFirstName.text == nil || [self.tfFirstName.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"You need to enter your first name." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    if (self.tfLastName.text == nil || [self.tfLastName.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"You need to enter your last name." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    if (self.tfEmail.text == nil || [self.tfEmail.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"You need to enter your email address." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    if (![self.tfPassword.text isEqualToString:self.tfConfirmPassword.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Password does not match." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    // confirm email type
    if (![self isValidEmail:self.tfEmail.text Strict:YES]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Incorrect Email Address! You need to enter correct email address." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        //        self.tfEmail.text = @"";
        return  FALSE;
    }
    
    return TRUE;
}

-(BOOL) isValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = strictFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

#pragma mark scrollViewDidScroll
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffest = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if (currentOffset - maximumOffest >= 60.0){
        if (isLoading == 0) {
            pageIndex++;
            [self initPaymentHistory:pageIndex];
        }
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return arrPayments.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [_tvPaymentHistory dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaymentsModel *payment = [arrPayments objectAtIndex:(int)indexPath.row];
    UILabel *lblInvoice = (UILabel *)[cell viewWithTag:100];
    lblInvoice.text = payment.Invoice;
    
    UILabel *lblTransaction = (UILabel *)[cell viewWithTag:200];
    lblTransaction.text = payment.Transaction;
    
    UILabel *lblDate = (UILabel *)[cell viewWithTag:300];
    lblDate.text = payment.Date;
    
    UILabel *lblAmount = (UILabel *)[cell viewWithTag:400];
    lblAmount.text = payment.Amount;
    
    UILabel *lblDetails = (UILabel *)[cell viewWithTag:500];
    lblDetails.text = payment.Details;
        
    
    return cell;
}

@end
