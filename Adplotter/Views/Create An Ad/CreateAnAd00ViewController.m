//
//  CreateAnAd00ViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 4/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "CreateAnAd00ViewController.h"
#import "TheSidebarController.h"
#import "Public.h"

@interface CreateAnAd00ViewController (){
    NSMutableArray *arrCategory;
    NSMutableArray *arrCategory01;
    NSMutableArray *arrCategory02;
    NSMutableArray *arrCategory03;
    NSMutableArray *arrCategory04;
    NSMutableArray *arrCategory05;
    NSMutableArray *arrCategory06;
    NSMutableArray *arrCategory07;
    
    UITextField *tmpTextField;
    
    int scrollHeight;
    int scrollContentHeight;
    
    CGRect screenSize;
    
    AppDelegate *appDelegate;
    
    int nCategoryIndex;
    int nParenetID;
}

@end

@implementation CreateAnAd00ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [AppDelegate sharedAppDeleate];
    nCategoryIndex = -1;
    nParenetID = -1;
    appDelegate.nCategoryIndex = -1;
    
    screenSize = [[UIScreen mainScreen] bounds];
    scrollHeight = self.view.bounds.size.height - self.navigationUIView.bounds.size.height;
    scrollContentHeight = scrollHeight;
    
    [self getCategoryFromServer];
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

#pragma mark setLayout
- (void) setLayout{

    _lblSelectCategory.hidden = YES;
    _lblRequired.hidden = YES;
    _lblCategory.hidden = YES;
    _ivSelectCategory.hidden = YES;
    
    _viewPicker.hidden = YES;
    [_viewPicker setFrame:CGRectMake(0, self.view.bounds.size.height, _viewPicker.bounds.size.width, _viewPicker.bounds.size.height)];
    
    //--Notification View TapGesture Event--
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    singleTap.numberOfTapsRequired = 1;
    [self.lblCategory setUserInteractionEnabled:YES];
    [self.lblCategory addGestureRecognizer:singleTap];
}

#pragma mark getCategoryFromServer
- (void) getCategoryFromServer{
    appDelegate.nCategoryIndex = -1;
    appDelegate.strTitle = @"";
    appDelegate.strDescription = @"";
    appDelegate.strPrice = @"";
    appDelegate.strParent = @"";
    
    arrCategory = [NSMutableArray new];
    arrCategory01 = [NSMutableArray new];
    arrCategory02 = [NSMutableArray new];
    arrCategory03 = [NSMutableArray new];
    arrCategory04 = [NSMutableArray new];
    arrCategory05 = [NSMutableArray new];
    arrCategory06 = [NSMutableArray new];
    arrCategory07 = [NSMutableArray new];
    
    if (appDelegate.nCategoryFlag == 0){
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        for (int i=0; i<7; i++)
            [self getCategoryWithParentID:i];
        
        //        [self getCategoryWithParentID:0];
        
    }else{
        //Category01
        NSMutableArray *arrTemp01 = appDelegate.arrCategory01;
        for (int i=0; i<arrTemp01.count; i++){
            CategoryModel *category = [arrTemp01 objectAtIndex:i];
            [arrCategory01 addObject:category];
        }
        
        //Category02
        NSMutableArray *arrTemp02 = appDelegate.arrCategory02;
        for (int i=0; i<arrTemp02.count; i++){
            CategoryModel *category = [arrTemp02 objectAtIndex:i];
            [arrCategory02 addObject:category];
        }
        
        //Category03
        NSMutableArray *arrTemp03 = appDelegate.arrCategory03;
        for (int i=0; i<arrTemp03.count; i++){
            CategoryModel *category = [arrTemp03 objectAtIndex:i];
            [arrCategory03 addObject:category];
        }
        
        //Category04
        NSMutableArray *arrTemp04 = appDelegate.arrCategory04;
        for (int i=0; i<arrTemp04.count; i++){
            CategoryModel *category = [arrTemp04 objectAtIndex:i];
            [arrCategory04 addObject:category];
        }
        
        //Category05
        NSMutableArray *arrTemp05 = appDelegate.arrCategory05;
        for (int i=0; i<arrTemp05.count; i++){
            CategoryModel *category = [arrTemp05 objectAtIndex:i];
            [arrCategory05 addObject:category];
        }
        
        //Category06
        NSMutableArray *arrTemp06 = appDelegate.arrCategory06;
        for (int i=0; i<arrTemp06.count; i++){
            CategoryModel *category = [arrTemp06 objectAtIndex:i];
            [arrCategory06 addObject:category];
        }
        
        //Category04
        NSMutableArray *arrTemp07 = appDelegate.arrCategory07;
        for (int i=0; i<arrTemp07.count; i++){
            CategoryModel *category = [arrTemp07 objectAtIndex:i];
            [arrCategory07 addObject:category];
        }
    }
}

- (void) getCategoryWithParentID: (int) nSelectedParentID{
    
    ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
    request.delegate=self;
    
    //        NSLog(API_URL);
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"GetCategories" forKey:@"Action"];
    
    if (nSelectedParentID == 0)
        [request setPostValue:@"830" forKey:@"ParentID"];
    else if (nSelectedParentID == 1)
        [request setPostValue:@"822" forKey:@"ParentID"];
    else if (nSelectedParentID == 2)
        [request setPostValue:@"1120" forKey:@"ParentID"];
    else if (nSelectedParentID == 3)
        [request setPostValue:@"1106" forKey:@"ParentID"];
    else if (nSelectedParentID == 4)
        [request setPostValue:@"1141" forKey:@"ParentID"];
    else if (nSelectedParentID == 5)
        [request setPostValue:@"821" forKey:@"ParentID"];
    else if (nSelectedParentID == 6)
        [request setPostValue:@"1140" forKey:@"ParentID"];
    
    request.tag = (nSelectedParentID + 1) + 300;
    [request startAsynchronous];
    
}

#pragma mark HTTP Post Request
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                         options:kNilOptions
                                                           error:&error];
    NSMutableArray *jsonData = [NSMutableArray new];
    jsonData = (NSMutableArray *)json;
    
    if (jsonData.count == 0)
        return;
    
    NSDictionary *tempDic = [jsonData objectAtIndex:0];
    if([tempDic objectForKey:@"Error"] == nil)
    {
        arrCategory = [NSMutableArray new];
        for (int i=0; i<jsonData.count; i++){
            NSDictionary *dic = [jsonData objectAtIndex:i];
            CategoryModel *category = [[CategoryModel alloc] initWithData:(int)[[dic objectForKey:@"CategoryID"] integerValue] Name:[dic objectForKey:@"Name"]];
            
            [arrCategory addObject:category];
        }
        
        if (request.tag == 301){
            appDelegate.arrCategory01 = arrCategory;
            arrCategory01 = arrCategory;
        }else if (request.tag == 302){
            appDelegate.arrCategory02 = arrCategory;
            arrCategory02 = arrCategory;
        }else if (request.tag == 303){
            appDelegate.arrCategory03 = arrCategory;
            arrCategory03 = arrCategory;
        }else if (request.tag == 304){
            appDelegate.arrCategory04 = arrCategory;
            arrCategory04 = arrCategory;
        }else if (request.tag == 305){
            appDelegate.arrCategory05 = arrCategory;
            arrCategory05 = arrCategory;
        }else if (request.tag == 306){
            appDelegate.arrCategory06 = arrCategory;
            arrCategory06 = arrCategory;
        }else if (request.tag == 307){
            [SVProgressHUD dismiss];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            appDelegate.arrCategory07 = arrCategory;
            appDelegate.nCategoryFlag = 1;
            arrCategory07 = arrCategory;
            
            [SVProgressHUD dismiss];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
        }
        
        arrCategory = [NSMutableArray new];
    }
    else
    {
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Server Error!" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    [self initPickerView];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark initPickerView
- (void) initPickerView{
    [_pickerCategory reloadAllComponents];
}

//UIPickerView Delegate
#pragma mark UIPickerView Delegate
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return arrCategory.count;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    CategoryModel *category = [arrCategory objectAtIndex:row];
//    NSLog(@"%d", category.CategoryID);
    return category.Name;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (arrCategory.count == 0)
        return;
    
    nCategoryIndex = (int)row;
    appDelegate.nCategoryIndex = (int)row;
    
    CategoryModel *category = [arrCategory objectAtIndex:row];
    _lblCategory.text =  category.Name;
    _lblCategory.textColor = [UIColor blackColor];
}

#pragma mark PickerView
- (void) openPickerView{
    _viewPicker.hidden = NO;
    
    [UIView animateWithDuration:0.4 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [_viewPicker setFrame:CGRectMake(0, self.view.bounds.size.height - _viewPicker.bounds.size.height, _viewPicker.bounds.size.width, _viewPicker.bounds.size.height)];
    }completion:^(BOOL finished){
        
    }];
    
    // make sure the scrollview content size width and height are greater than 0
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.contentSize.width, scrollContentHeight)];
    
    CGRect rect = CGRectMake(0, self.scrollView.frame.origin.y, self.scrollView.bounds.size.width, scrollHeight - _viewPicker.bounds.size.height);
    [self.scrollView setFrame:rect];
}

- (void) hidePickerView{
    [UIView animateWithDuration:0.4 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [_viewPicker setFrame:CGRectMake(0, self.view.bounds.size.height, _viewPicker.bounds.size.width, _viewPicker.bounds.size.height)];
    }completion:^(BOOL finished){
        _viewPicker.hidden = YES;
    }];
    
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.contentSize.width, scrollContentHeight)];
    [self.scrollView setFrame:CGRectMake(screenSize.origin.x, self.scrollView.frame.origin.y, screenSize.size.width, scrollHeight)];
}

#pragma mark tapGesture
- (void) tapGesture: (UIGestureRecognizer *) gestureRecognizer{
    [self openPickerView];
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.bounds.size.height-100)];
    
}

#pragma mark Buttons Event

- (IBAction)actionCancel:(id)sender {
    [self hidePickerView];
}

- (IBAction)actionDone:(id)sender {
    if (nCategoryIndex == -1 && arrCategory.count != 0){
        CategoryModel *category = [arrCategory objectAtIndex:0];
        _lblCategory.text =  category.Name;
        _lblCategory.textColor = [UIColor blackColor];
        nCategoryIndex = 0;
        appDelegate.nCategoryIndex = 0;
    }
    
    [self hidePickerView];
}

- (IBAction)pressMenuBtn:(id)sender {
    if(self.sidebarController.sidebarIsPresenting)
        [self.sidebarController dismissSidebarViewController];
    else
        [self.sidebarController presentLeftSidebarViewControllerWithStyle:SLIDE_MENU_STYLE];
}

- (IBAction)pressPlusBtn:(id)sender {
}

- (IBAction)pressContinueBtn:(id)sender {
    if (nCategoryIndex == -1){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"Category is required. Please choose Category!" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    
    NSString *strParent;
    if (nParenetID  == 0)
        strParent = @"Product";
    else if (nParenetID == 1)
        strParent = @"Service";
    else if (nParenetID == 2)
        strParent = @"Job";
    else if (nParenetID == 3)
        strParent = @"Biz Opp";
    else if (nParenetID == 4)
        strParent = @"A Vehicle";
    else if (nParenetID == 5)
        strParent = @"Real Estate";
    else if (nParenetID == 6)
        strParent = @"Lost/Found Pet";
    else
        strParent = @"";
    
    CreateAnAdViewController *viewController = (CreateAnAdViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CreateAnAdView"];
    viewController.currentAd = nil;
    viewController.strParent = strParent;
    viewController.imgAd = nil;
    appDelegate.strParent = strParent;
    [self.navigationController pushViewController:viewController animated:TRUE];
}

//Cateogry Buttons
- (IBAction)pressProductBtn:(id)sender {
    nParenetID = 0;
    
    _lblCategory.text = @"-- Select a Product --";
    _lblCategory.textColor = [UIColor grayColor];
    
    [self getCategory];
    [self setButtonsLayout];
}

- (IBAction)pressServiceBtn:(id)sender {
    nParenetID = 1;
    
    _lblCategory.text = @"-- Select a Service --";
    _lblCategory.textColor = [UIColor grayColor];
    
    [self getCategory];
    [self setButtonsLayout];
}

- (IBAction)pressJobBtn:(id)sender {
    nParenetID = 2;
    
    _lblCategory.text = @"-- Select a Job --";
    _lblCategory.textColor = [UIColor grayColor];
    
    [self getCategory];
    [self setButtonsLayout];
}

- (IBAction)pressBizOppBtn:(id)sender {
    nParenetID = 3;
    
    _lblCategory.text = @"-- Select a Biz Opp --";
    _lblCategory.textColor = [UIColor grayColor];
    
    [self getCategory];
    [self setButtonsLayout];
}

- (IBAction)pressVehicleBtn:(id)sender {
    nParenetID = 4;
    
    _lblCategory.text = @"-- Select a Vehicle --";
    _lblCategory.textColor = [UIColor grayColor];
    
    [self getCategory];
    [self setButtonsLayout];

}

- (IBAction)pressRealEstateBtn:(id)sender {
    nParenetID = 5;
    
    _lblCategory.text = @"-- Select --";
    _lblCategory.textColor = [UIColor grayColor];
    
    [self getCategory];
    [self setButtonsLayout];

}

- (IBAction)pressLostBtn:(id)sender {
    nParenetID = 6;
    
    _lblCategory.text = @"-- Select --";
    _lblCategory.textColor = [UIColor grayColor];
    
    [self getCategory];
    [self setButtonsLayout];

}

#pragma mark getCateory
- (void) getCategory{
    nCategoryIndex = -1;
    arrCategory = [NSMutableArray new];
    
    NSMutableArray *arrTemp = [NSMutableArray new];
    NSMutableArray *arrTemp01 = [NSMutableArray new];
    
    if (nParenetID == 0)
        arrTemp = arrCategory01;
    else if (nParenetID == 1)
        arrTemp = arrCategory02;
    else if (nParenetID == 2)
        arrTemp = arrCategory03;
    else if (nParenetID == 3)
        arrTemp = arrCategory04;
    else if (nParenetID == 4)
        arrTemp = arrCategory05;
    else if (nParenetID == 5)
        arrTemp = arrCategory06;
    else if (nParenetID == 6)
        arrTemp = arrCategory07;
    else
        arrTemp = arrCategory01;
    
    for (int i=0; i<arrTemp.count; i++){
        CategoryModel *category = [arrTemp objectAtIndex:i];
        [arrCategory addObject:category];
        [arrTemp01 addObject:category];
    }

    appDelegate.arrCategory = arrTemp01;
    [_pickerCategory reloadAllComponents];
}

#pragma mark setButtonsLayout
- (void) setButtonsLayout{

    _lblSelectCategory.hidden = NO;
    _lblRequired.hidden = NO;
    _lblCategory.hidden = NO;
    _ivSelectCategory.hidden = NO;
    
    if (nParenetID == 0)
        [_btnProduct setBackgroundImage:[UIImage imageNamed:@"img_Product_pressed_icon.png"] forState:UIControlStateNormal];
    else
        [_btnProduct setBackgroundImage:[UIImage imageNamed:@"img_Product_icon.png"] forState:UIControlStateNormal];
    
    if (nParenetID == 1)
        [_btnService setBackgroundImage:[UIImage imageNamed:@"img_Service_pressed_icon.png"] forState:UIControlStateNormal];
    else
        [_btnService setBackgroundImage:[UIImage imageNamed:@"img_Service_icon.png"] forState:UIControlStateNormal];
    
    if (nParenetID == 2)
        [_btnJob setBackgroundImage:[UIImage imageNamed:@"img_Job_pressed_icon.png"] forState:UIControlStateNormal];
    else
        [_btnJob setBackgroundImage:[UIImage imageNamed:@"img_Job_icon.png"] forState:UIControlStateNormal];
    
    if (nParenetID == 3)
        [_btnBizOpp setBackgroundImage:[UIImage imageNamed:@"img_BizOpp_pressed_icon.png"] forState:UIControlStateNormal];
    else
        [_btnBizOpp setBackgroundImage:[UIImage imageNamed:@"img_BizOpp_icon.png"] forState:UIControlStateNormal];
    
    if (nParenetID == 4)
        [_btnVehicle setBackgroundImage:[UIImage imageNamed:@"img_Vehicle_pressed_icon.png"] forState:UIControlStateNormal];
    else
        [_btnVehicle setBackgroundImage:[UIImage imageNamed:@"img_Vehicle_icon.png"] forState:UIControlStateNormal];
    
    if (nParenetID == 5)
        [_btnRealEstate setBackgroundImage:[UIImage imageNamed:@"img_RealEstate_pressed_icon.png"] forState:UIControlStateNormal];
    else
        [_btnRealEstate setBackgroundImage:[UIImage imageNamed:@"img_RealEstate_icon.png"] forState:UIControlStateNormal];
    
    if (nParenetID == 6)
        [_btnLost setBackgroundImage:[UIImage imageNamed:@"img_Lost_pressed_icon.png"] forState:UIControlStateNormal];
    else
        [_btnLost setBackgroundImage:[UIImage imageNamed:@"img_Lost_icon.png"] forState:UIControlStateNormal];
         
}
@end
