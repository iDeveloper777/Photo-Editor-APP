//
//  CreateAnAdViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 20/04/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "CreateAnAdViewController.h"
#import "TheSidebarController.h"
#import "Public.h"

#import "AppDelegate.h"
#import "PicBlendTemplateViewController.h"

@interface CreateAnAdViewController (){
    UITextField *tmpTextField;
    
    int scrollHeight;
    int scrollContentHeight;
    
    CGRect screenSize;
    
    AppDelegate *appDelegate;
    UIStoryboard *storyboard;
    
    NSString *CategoryName;
    int CategoryID;
}

@end

@implementation CreateAnAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [AppDelegate sharedAppDeleate];
    appDelegate.imageWidth = WIDTH(self.view);
    appDelegate.imageHeight = WIDTH(self.view);
    
    storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    
    screenSize = [[UIScreen mainScreen] bounds];
    scrollHeight = self.view.bounds.size.height - self.navigationUIView.bounds.size.height;
    scrollContentHeight = HEIGHT(self.categoryUIView) + HEIGHT(self.photoUIView) + HEIGHT(self.textfieldUIView);
    
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.contentSize.width, scrollContentHeight)];
    
    [self initDatas];
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

#pragma mark initDatas
- (void) initDatas{
    
//    _strParent = @"";
    if (_currentAd != nil){
        int nIndex = 0;
        for (int i=0; i<7;i++){
            NSMutableArray *tempArray;
            if (i == 0)
                tempArray = appDelegate.arrCategory01;
            else if (i == 1)
                tempArray = appDelegate.arrCategory02;
            else if (i == 2)
                tempArray = appDelegate.arrCategory03;
            else if (i == 3)
                tempArray = appDelegate.arrCategory04;
            else if (i == 4)
                tempArray = appDelegate.arrCategory05;
            else if (i == 5)
                tempArray = appDelegate.arrCategory06;
            else if (i == 6)
                tempArray = appDelegate.arrCategory07;
            
            for (int j=0; j<tempArray.count; j++){
                CategoryModel *tempCategory = [tempArray objectAtIndex:j];
                
                if (appDelegate.nCategoryIndex == tempCategory.CategoryID) {
                    if (i == 0)
                        _strParent = @"Product";
                    else if (i == 1)
                        _strParent = @"Service";
                    else if (i == 2)
                        _strParent = @"Job";
                    else if (i == 3)
                        _strParent = @"Biz Opp";
                    else if (i == 4)
                        _strParent = @"Vehicle";
                    else if (i == 5)
                        _strParent = @"Real Estate";
                    else if (i == 6)
                        _strParent = @"Lost/Found Pet";
                    
                    nIndex = j;
                }
            }
        }
        
        appDelegate.nCategoryIndex = nIndex;
    }
    _lblParentCategory.text = _strParent;
    
    CategoryModel *category;
    if (_currentAd != nil){
        if ([_strParent isEqualToString:@"Product"])
            appDelegate.arrCategory = appDelegate.arrCategory01;
        else if ([_strParent isEqualToString:@"Service"])
            appDelegate.arrCategory = appDelegate.arrCategory02;
        else if ([_strParent isEqualToString:@"Job"])
            appDelegate.arrCategory = appDelegate.arrCategory03;
        else if ([_strParent isEqualToString:@"Biz Opp"])
            appDelegate.arrCategory = appDelegate.arrCategory04;
        else if ([_strParent isEqualToString:@"Vehicle"])
            appDelegate.arrCategory = appDelegate.arrCategory05;
        else if ([_strParent isEqualToString:@"Real Estate"])
            appDelegate.arrCategory = appDelegate.arrCategory06;
        else if ([_strParent isEqualToString:@"Lost/Found Pet"])
            appDelegate.arrCategory = appDelegate.arrCategory07;
        else
            appDelegate.arrCategory = appDelegate.arrCategory01;
    }
    category = [appDelegate.arrCategory objectAtIndex:appDelegate.nCategoryIndex];
    
    CategoryID = category.CategoryID;
    CategoryName = category.Name;
    
    _lblCategory.text = CategoryName;
    _tfTitle.text = appDelegate.strTitle;
    _tfDescription.text = appDelegate.strDescription;
    _tfPrice.text = appDelegate.strPrice;
}

#pragma mark setLayout
- (void) setLayout{
    if (_currentAd == nil){
        if (_imgAd == nil)
        {
            _ivImage.hidden = YES;
            _btnChange.hidden = YES;
            _btnDelete.hidden = YES;
            
            _btnPicBlend.hidden = NO;
            _btnBrowsePhoto.hidden = NO;
            _btnTakePhoto.hidden = NO;
        }else{
            _ivImage.hidden = NO;
            _btnChange.hidden = NO;
            _btnDelete.hidden = NO;
            
            _btnPicBlend.hidden = YES;
            _btnBrowsePhoto.hidden = YES;
            _btnTakePhoto.hidden = YES;
            
            _ivImage.image = _imgAd;
        }
    }else{
        _ivImage.hidden = NO;
        _btnChange.hidden = NO;
        _btnDelete.hidden = NO;
            
        _btnPicBlend.hidden = YES;
        _btnBrowsePhoto.hidden = YES;
        _btnTakePhoto.hidden = YES;
            
        _ivImage.image = _imgAd;
        
        _tfTitle.text = _currentAd.Title;
        _tfDescription.text = _currentAd.Description;
        
        float fPrice = [_currentAd.Price floatValue];
        _tfPrice.text = [NSString stringWithFormat:@"%0.2f", fPrice];
    }
    
    //Padding View
    UIView *paddingView01 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.tfTitle.leftView = paddingView01;
    self.tfTitle.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView02 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.tfDescription.leftView = paddingView02;
    self.tfDescription.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView04 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.tfPrice.leftView = paddingView04;
    self.tfPrice.leftViewMode = UITextFieldViewModeAlways;
    
    //Padding View End
    
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
    
    self.tfTitle.inputAccessoryView = doneToolbar;
    self.tfDescription.inputAccessoryView = doneToolbar;
    self.tfPrice.inputAccessoryView = doneToolbar;
    
    [self.tfTitle addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfDescription addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];
    [self.tfPrice addTarget:self action:@selector(beginEditingTextbox:) forControlEvents:UIControlEventEditingDidBegin];

}

#pragma mark ActionSheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
        [self importFromCamera];
    else if(buttonIndex==1)
        [self importFromPhotoLibrary];
}

#pragma mark Camera
-(IBAction)importFromCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self importFromPhotoLibrary];
        return;
    }
    
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    picker.delegate=self;
    
    double delayInSeconds = .03;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Put your code here
        [self presentViewController:picker animated:NO completion:nil];
    });
}

-(IBAction)importFromPhotoLibrary
{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate=self;
    
    double delayInSeconds = .03;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Put your code here
        [self presentViewController:picker animated:YES completion:nil];
    });
}

#pragma mark UIImagePicker Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info valueForKey:UIImagePickerControllerOriginalImage];
    //    frontImage.image=image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    ImageCropViewController *imageCrop = [[ImageCropViewController alloc]init];
    imageCrop.delegate = self;
    imageCrop.image = image;
    [imageCrop presentViewControllerAnimated:YES];
    
}

-(void)imageCropFinished:(UIImage *)cropedImage
{
    CGFloat width = cropedImage.size.width;
    CGFloat height = cropedImage.size.height;
    
    int imageWidth = 640;
    int imageHeight = 640;
    
    UIGraphicsBeginImageContext(CGSizeMake(imageWidth*2, imageHeight*2));
    [cropedImage drawInRect:CGRectMake(0, 0, imageWidth*2, imageHeight*2)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    width = resizedImage.size.width;
    height = resizedImage.size.height;
    
    _ivImage.image = resizedImage;
    _imgAd = resizedImage;

    _ivImage.hidden = NO;
    _btnChange.hidden = NO;
    _btnDelete.hidden = NO;
    
    _btnPicBlend.hidden = YES;
    _btnBrowsePhoto.hidden = YES;
    _btnTakePhoto.hidden = YES;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 300)
        textField.text = CategoryName;
    
    [textField resignFirstResponder];
    return  YES;
}

- (BOOL) beginEditingTextbox:(UITextField *)textField{
    tmpTextField = textField;
    [self.scrollView setContentOffset:CGPointMake(0, [self getStateEdit:textField])];
    
    return TRUE;
}

- (float)getStateEdit:(UITextField *)textField {
    if ((textField.superview.frame.origin.y + textField.frame.origin.y + _scrollView.frame.origin.y) > self.scrollView.frame.size.height - 200 ) {
        if (appDelegate.nDeviceType == 1){
            return textField.superview.frame.origin.y +  textField.frame.origin.y + self.photoUIView.bounds.size.height - 300;
        }else if (appDelegate.nDeviceType == 2){
            return textField.superview.frame.origin.y +  textField.frame.origin.y + self.photoUIView.bounds.size.height - 200;
        }else if (appDelegate.nDeviceType == 3){
            return textField.superview.frame.origin.y +  textField.frame.origin.y + self.photoUIView.bounds.size.height - 300;
        }
    } else {
        return 0;
    }
    return 0;
}

#pragma mark -  Keyboard Events
- (IBAction) doneWithKeyboard:(id) sender{
    [tmpTextField resignFirstResponder];
    
    if (tmpTextField.tag == 300)
        tmpTextField.text = CategoryName;
}

- (IBAction)cancelWithKeyboard:(id) sender{
    [tmpTextField resignFirstResponder];
    
    if (tmpTextField.tag == 300)
        tmpTextField.text = CategoryName;
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

#pragma mark - Check Login Data
- (BOOL) isValidData{
    if (self.tfTitle.text == nil || [self.tfTitle.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Title is required." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    if (self.tfDescription.text == nil || [self.tfDescription.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Description is requirecd." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    if (self.tfPrice.text == nil || [self.tfPrice.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Price is requirecd." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        return FALSE;
    }
    
    return TRUE;
}

#pragma mark UIAlertView Delegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self saveAd];
    }else if (buttonIndex == 1){
        
    }
}

#pragma mark saveAd
- (void) saveAd{
    [tmpTextField resignFirstResponder];
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
    request.delegate=self;
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setPostFormat:ASIMultipartFormDataPostFormat];
    
    [request setPostValue:@"SaveAd" forKey:@"Action"];
    if (_currentAd != nil)
        [request setPostValue:[NSString stringWithFormat:@"%d", _currentAd.AdID] forKey:@"AdID"];
    [request setPostValue:appDelegate.user.UserGUID forKey:@"UserGUID"];
    [request setPostValue:self.tfTitle.text forKey:@"Title"];
    [request setPostValue:self.tfDescription.text forKey:@"Description"];
    [request setPostValue:self.tfPrice.text forKey:@"Price"];
    [request setPostValue:[NSString stringWithFormat:@"%d", CategoryID] forKey:@"CategoryID"];
    
    NSLog(@"width: %f", _imgAd.size.width);
    if (_imgAd != nil){
        NSData *imgData = UIImageJPEGRepresentation(_imgAd, 0.6);
        [request setPostValue:imgData forKey:@"Image1"];
        NSLog(@"%@", imgData);
    }else{
        UIImage *blankImage = [UIImage imageNamed:@"img_blank.png"];
        NSData *imgData = UIImageJPEGRepresentation(blankImage, 0.6);
        [request setPostValue:imgData forKey:@"Image1"];
        NSLog(@"%@", imgData);
    }
    
    [request startAsynchronous];
}

#pragma mark HTTP - Post Request
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                         options:kNilOptions
                                                           error:&error];
   
    if([json objectForKey:@"Error"] == nil)
    {
        int nAdID = (int)[[json objectForKey:@"AdID"] integerValue];
        if (nAdID != 0){
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Your Ad was registered successfully!" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
//            [alertView show];
            
            [self performSelector:@selector(goToListingManager) withObject:nil afterDelay:0.2];
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void) goToListingManager{
    YSTransitionType pushSubtype;
    ListingManagerViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"ListingManagerView"];
    
    pushSubtype = YSTransitionTypeFromLeft;
    
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
}

#pragma mark playButtonSound
- (void) playButtonSound
{
    SystemSoundID audioEffect;
    NSString *path = [[NSBundle mainBundle] pathForResource :@"TabButton" ofType :@"m4a"];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSURL *pathURL = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else {
        NSLog(@"error, file not found: %@", path);
    }
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

    CreateAnAd00ViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAnAd00View"];
    
    pushSubtype = YSTransitionTypeFromBottom;
    
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
}

- (IBAction)pressPicBlendBtn:(id)sender {
    //play sound
    [self playButtonSound];
    
    appDelegate.strTitle = _tfTitle.text;
    appDelegate.strDescription = _tfDescription.text;
    appDelegate.strPrice = _tfPrice.text;

    PicBlendTemplateViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"PicBlendTemplateView"];
    [self.navigationController pushViewController:tpViewController animated:TRUE];
}

- (IBAction)pressBrowsePhotoBtn:(id)sender {
    //play sound
    [self playButtonSound];
    
//    NSLog(@"Import!!!");
//    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Import !" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Library", nil];
//    [sheet showInView:self.view];
    
    [self importFromPhotoLibrary];
}

- (IBAction)pressTakePhotoBtn:(id)sender {
    //play sound
    [self playButtonSound];
    
    [self importFromCamera];
}

- (IBAction)pressChangeBtn:(id)sender {
    _ivImage.image = nil;
    
    _ivImage.hidden = YES;
    _btnChange.hidden = YES;
    _btnDelete.hidden = YES;
    
    _btnPicBlend.hidden = NO;
    _btnBrowsePhoto.hidden = NO;
    _btnTakePhoto.hidden = NO;
}

- (IBAction)pressDeleteBtn:(id)sender {
    _ivImage.hidden = YES;
    _btnChange.hidden = YES;
    _btnDelete.hidden = YES;
    
    _btnPicBlend.hidden = NO;
    _btnBrowsePhoto.hidden = NO;
    _btnTakePhoto.hidden = NO;

    _imgAd = nil;
}

- (IBAction)pressSaveBtn:(id)sender {
    [tmpTextField resignFirstResponder];
    if ([self isValidData]){
        if (_imgAd == nil){
            [[[UIAlertView alloc] initWithTitle:@"Notification" message:@"There is no image of your Ad now. Do you want to save Ad info without image?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil] show];
        }else{
            [self saveAd];
            
            appDelegate.strTitle = _tfTitle.text;
            appDelegate.strDescription = _tfDescription.text;
            appDelegate.strPrice = _tfPrice.text;
        }
    }
}
@end
