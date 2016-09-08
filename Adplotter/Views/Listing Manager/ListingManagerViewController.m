//
//  ListingManagerViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 24/4/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "ListingManagerViewController.h"
#import "TheSidebarController.h"
#import "Public.h"

@interface ListingManagerViewController (){
    AppDelegate *appDelegate;
    UIStoryboard *storyboard;
    
    int pageIndex;
    int isEmpty;
    int isLoading;
    NSMutableArray *arrAds;
    NSMutableArray *arrImages;
    
    NSIndexPath * currentIndex;
    
    NSMutableArray *arrCategory, *arrCategory01, *arrCategory02, *arrCategory03, *arrCategory04, *arrCategory05, *arrCategory06, *arrCategory07;
    
    NSString *strTitle, *strDescription, *strPrice;
    UIImage *imgShare;
}

@end

@implementation ListingManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [AppDelegate sharedAppDeleate];
    storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];

    pageIndex = 1;
    isEmpty = 0;
    isLoading = 0;
    
    arrAds = [[NSMutableArray alloc] init];
    arrImages = [[NSMutableArray alloc] init];
    
    currentIndex = nil;
    
    [self initDatas:1];
    [self getCategory];
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

#pragma mark initDatas
- (void) initDatas: (int) nIndex{
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
    
    [request setPostValue:@"GetAds" forKey:@"Action"];
    [request setPostValue:appDelegate.user.UserGUID forKey:@"UserGUID"];
//    [request setPostValue:@"Sdfasdf" forKey:@"UserGUID"];
    [request setPostValue:[NSString stringWithFormat:@"%d", nIndex] forKey:@"PageIndex"];
    [request setPostValue:@"7" forKey:@"NumPerPage"];
    
    request.tag = 100;
    [request startAsynchronous];
}

#pragma mark getCategory
- (void) getCategory{
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

#pragma mark - HTTP Post Request
-(void)requestFinished:(ASIHTTPRequest *)request
{
    isLoading = 0;
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                         options:kNilOptions
                                                           error:&error];
    if (request.tag == 100){ //GetAds
        if (appDelegate.arrCategory01.count != 0){
            [SVProgressHUD dismiss];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
        NSMutableArray *jsonData = [NSMutableArray new];
        jsonData = (NSMutableArray *)json;
        
        if (jsonData.count == 0){
            isEmpty = 1;
            
            if (arrAds.count == 0){
                _ivStatus.image = [UIImage imageNamed:@"img_listing_empty.png"];
                _ivStatus.hidden = NO;
                _tblListing.hidden = YES;
                _btnClick.hidden = YES;
            }
            
            return;
        }else{
            _ivStatus.image = [UIImage imageNamed:@"img_listing_noempty.png"];
            _ivStatus.hidden = NO;
            _tblListing.hidden = NO;
            _btnClick.hidden = NO;
        }
        
        NSDictionary *tempDic = [jsonData objectAtIndex:0];
        
        if([tempDic objectForKey:@"Error"] == nil)
            //    if (jsonData.count != 0)
        {
            for (int i=0; i<jsonData.count; i++){
                NSDictionary *dic = [jsonData objectAtIndex:i];
                
                AdModel *ad = [[AdModel alloc] initWithData:(int)[[dic objectForKey:@"AdID"] integerValue]
                                                     UserID:(int)[[dic objectForKey:@"UserID"] integerValue]
                                                 CategoryID:(int)[[dic objectForKey:@"CategoryID"] integerValue]
                                                      Title:[dic objectForKey:@"Title"]
                                                Description:[dic objectForKey:@"Description"]
                                                      Price:[NSString stringWithFormat:@"%f", [[dic objectForKey:@"Price"] floatValue]]
                                                 PictureURL:[NSString stringWithFormat:@"https://www.adplotter.com%@",[dic objectForKey:@"BigPictureURL"]]];
                [arrAds addObject:ad];
                
                NSString *strImageURL = [dic objectForKey:@"BigPictureURL"];
                if ([strImageURL isKindOfClass:[NSString class]] && ![strImageURL isEqualToString:@""]){
                    NSURL *imgURL = [NSURL URLWithString:ad.PictureURL];
                    NSData *imgData = [[NSData alloc] initWithContentsOfURL:imgURL];
                    UIImage *image = [UIImage imageWithData:imgData];
                    
                    if ([image isKindOfClass:[UIImage class]] && image != nil)
                        [arrImages addObject:image];
                    else
                        [arrImages addObject:[UIImage imageNamed:@"img_blank.png"]];
                }else{
                    [arrImages addObject:[UIImage imageNamed:@"img_blank.png"]];
                }
                
            }
            
            [_tblListing reloadData];
            
            if (arrAds.count == 1) {
                _notificationUIView.hidden = NO;
            }
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }else if (request.tag == 200){ //DeleteAd
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
        if([[json objectForKey:@"Status"] intValue] == 1){
            [self performSelector:@selector(deleteAd) withObject:nil afterDelay:0.3f];
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot remove this Ad." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }else if (request.tag > 300){ //Get Category
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
    }
 
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void) deleteAd{
    [arrAds removeObjectAtIndex:currentIndex.row];
    [arrImages removeObjectAtIndex:currentIndex.row];
    
    [self.tblListing deleteRowsAtIndexPaths:@[currentIndex] withRowAnimation:UITableViewRowAnimationRight];

    if (arrAds.count == 1)
        _notificationUIView.hidden = NO;
}

#pragma mark - setLayout
- (void) setLayout{
    _ivStatus.hidden = YES;
    _tblListing.hidden = YES;
    _btnClick.hidden = YES;
    
    _notificationUIView.hidden = YES;
}


#pragma mark scrollViewDidScroll
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffest = scrollView.contentSize.height - scrollView.frame.size.height;

    if (currentOffset - maximumOffest >= 60.0){
        if (isLoading == 0) {
            pageIndex++;
            [self initDatas:pageIndex];
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
    return arrAds.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row ==0) {
//        CreateAnAdNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAnAdNavi"];
//        
//        [self.sidebarController setContentViewController:viewController];
//        [self.sidebarController dismissSidebarViewController];
//    }else if (indexPath.row ==1) {
//        ListingManagerNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListingManagerNavi"];
//        
//        [self.sidebarController setContentViewController:viewController];
//        [self.sidebarController dismissSidebarViewController];
//    }
    //    else if (indexPath.row == 2){
    //        VendorTransactionNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VendorTransactionNavi"];
    //
    //        [self.sidebarController setContentViewController:viewController];
    //        [self.sidebarController dismissSidebarViewController];
    //    }else if (indexPath.row == 3){
    //        VendorAffiliatesNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VendorAffiliatesNavi"];
    //
    //        [self.sidebarController setContentViewController:viewController];
    //        [self.sidebarController dismissSidebarViewController];
    //
    //    }else if (indexPath.row == 4){
    //        VendorCompaignNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VendorCompaignNavi"];
    //
    //        [self.sidebarController setContentViewController:viewController];
    //        [self.sidebarController dismissSidebarViewController];
    //
    //    }else if (indexPath.row == 5){
    //        VendorRequestsNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VendorRequestsNavi"];
    //
    //        [self.sidebarController setContentViewController:viewController];
    //        [self.sidebarController dismissSidebarViewController];
    //
    //    }else if (indexPath.row == 6){
    //
    //    }else if (indexPath.row == 7){
    //
    //    }else if (indexPath.row == 8){
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //    }
    
    ///------------------------------------///
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
//    UITableViewCell *cell = [self.tblListing dequeueReusableCellWithIdentifier:CellIdentifier];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SWTableViewCell *cell = (SWTableViewCell *)[self.tblListing dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil || cell != nil){
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"img_SWTable_edit.png"]];
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"img_SWTable_trash.png"]];
//        [leftUtilityButtons addUtilityButtonWithColor:
//         [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
//                                                 icon:[UIImage imageNamed:@"img_SWTable_history.png"]];
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"img_SWTable_share.png"]];
        
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                 title:@" + "];
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@" - "];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier
                                  containingTableView:self.tblListing // Used for row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
    }
    
    AdModel *ad = [arrAds objectAtIndex:indexPath.row];

    // change background color of cell
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:66.0/255.0 green:74.0/255.0 blue:83.0/255.0 alpha:1.0]];
    [cell setBackgroundView:bgColorView];
    
    [cell.contentView setBackgroundColor:[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1.0]];

    UILabel *lblTitle;
    if (appDelegate.nDeviceType == 1 || appDelegate.nDeviceType == 2){
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(76, 5, WIDTH(_tblListing)-126 , 15)];
        lblTitle.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    }else{
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(111, 5, 412 , 25)];
        lblTitle.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    }
    lblTitle.textAlignment = NSTextAlignmentLeft;
    lblTitle.textColor = [UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0];
    lblTitle.text = ad.Title;

    UITextView *txtDescription;
    if (appDelegate.nDeviceType == 1){
        txtDescription = [[UITextView alloc] initWithFrame:CGRectMake(71, 20, WIDTH(_tblListing)-72, 45)];
        txtDescription.font = [UIFont fontWithName:@"Helvetica" size:9.0];
    }else if (appDelegate.nDeviceType == 2){
        txtDescription = [[UITextView alloc] initWithFrame:CGRectMake(71, 20, WIDTH(_tblListing)-72, 40)];
        txtDescription.font = [UIFont fontWithName:@"Helvetica" size:9.0];
    }else if (appDelegate.nDeviceType == 3){
        txtDescription = [[UITextView alloc] initWithFrame:CGRectMake(106, 27, WIDTH(_tblListing)-110, 66)];
        txtDescription.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    }
    txtDescription.textColor = [UIColor grayColor];
    txtDescription.scrollEnabled = NO;
    txtDescription.editable = NO;
    txtDescription.selectable = NO;
    txtDescription.backgroundColor = [UIColor clearColor];
    txtDescription.text = ad.Description;
    
    UILabel *lblDate;
    if (appDelegate.nDeviceType == 1 || appDelegate.nDeviceType == 2){
        lblDate = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(_tblListing)-125, 5, 120, 20)];
        lblDate.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    }else if (appDelegate.nDeviceType == 3){
        lblDate = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH(_tblListing)-187, 5, 177, 23)];
        lblDate.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    }
    lblDate.textColor = [UIColor grayColor];
    lblDate.textAlignment = NSTextAlignmentRight;
    lblDate.text = @"2/26/2015 - 4:16:42 PM";
    lblDate.hidden = YES;
    
    UIImageView *imgProduct;
    if (appDelegate.nDeviceType == 1)
        imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 60, 60)];
    else if (appDelegate.nDeviceType == 2)
        imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(8, 4, 56, 56)];
    else if (appDelegate.nDeviceType == 3)
        imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 90, 90)];
    
    imgProduct.layer.cornerRadius = imgProduct.frame.size.height / 5;
    imgProduct.layer.masksToBounds = YES;
    [imgProduct setBackgroundColor:[UIColor whiteColor]];
//    [imgProduct setImageWithURL:[NSURL URLWithString:ad.PictureURL]];
    
    UIImage *image = [arrImages objectAtIndex:indexPath.row];
    imgProduct.image = image;
    
//    UILabel *lblTitle = (UILabel *)[cell viewWithTag:200];
//    lblTitle.textAlignment = NSTextAlignmentLeft;
//    lblTitle.textColor = [UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0];
//    lblTitle.text = ad.Title;
//    
//    UITextView *txtDescription = (UITextView *)[cell viewWithTag:300];
//    txtDescription.textColor = [UIColor grayColor];
//    txtDescription.scrollEnabled = NO;
//    txtDescription.editable = NO;
//    txtDescription.selectable = NO;
//    txtDescription.backgroundColor = [UIColor clearColor];
//    txtDescription.text = ad.Description;
//    
//    UILabel *lblDate = (UILabel *)[cell viewWithTag:400];
//    lblDate.textColor = [UIColor grayColor];
//    lblDate.textAlignment = NSTextAlignmentRight;
//    lblDate.text = @"2/26/2015 - 4:16:42 PM";
//    lblDate.hidden = YES;
//    
//    UIImageView *imgProduct = (UIImageView *)[cell viewWithTag:100];
//    imgProduct.layer.cornerRadius = imgProduct.frame.size.height / 5;
//    imgProduct.layer.masksToBounds = YES;
//    [imgProduct setBackgroundColor:[UIColor whiteColor]];
        
    
    [cell.contentView addSubview:imgProduct];
    [cell.contentView addSubview:lblTitle];
    [cell.contentView addSubview:txtDescription];
    [cell.contentView addSubview:lblDate];
    
    return cell;
}

#pragma mark - SWTableViewDelegate

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    if (index == 1) { //Press Delete Button
        NSIndexPath *cellIndexPath = [self.tblListing indexPathForCell:cell];
        currentIndex = cellIndexPath;
        AdModel *ad = [arrAds objectAtIndex:cellIndexPath.row];
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        ASIFormDataRequest *request =[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:API_URL]];
        request.delegate=self;
        
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        [request setRequestMethod:@"POST"];
        
        [request setPostValue:@"DeleteAd" forKey:@"Action"];
        [request setPostValue:appDelegate.user.UserGUID forKey:@"UserGUID"];
        [request setPostValue:[NSString stringWithFormat:@"%d",ad.AdID] forKey:@"AdID"];
        
        request.tag = 200;
        [request startAsynchronous];
    }else if (index == 0){ //Modify
        NSIndexPath *cellIndexPath = [self.tblListing indexPathForCell:cell];
        currentIndex = cellIndexPath;
        AdModel *ad = [arrAds objectAtIndex:cellIndexPath.row];
        UIImage *imgAd = [arrImages objectAtIndex:cellIndexPath.row];
        
        YSTransitionType pushSubtype;
        CreateAnAdViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAnAdView"];
        appDelegate.nCategoryIndex = ad.CategoryID;
        tpViewController.currentAd = ad;
        tpViewController.imgAd = imgAd;
        
        pushSubtype = YSTransitionTypeFromLeft;
        
        [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
    }else if (index == 2){ //Share
        NSIndexPath *cellIndexPath = [self.tblListing indexPathForCell:cell];
        imgShare = [arrImages objectAtIndex:cellIndexPath.row];
        AdModel *ad = [arrAds objectAtIndex:cellIndexPath.row];
        
        strTitle = ad.Title;
        strDescription = ad.Description;
        strPrice = ad.Price;
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Please select" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email",@"SMS", @"Facebook", @"Twitter", nil];
        sheet.tag = 200;
        [sheet showInView:self.view];
    }
}

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSLog(@"More button was pressed");
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - Buttons Event
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

- (IBAction)pressClickBtn:(id)sender {
    NSString *strURL = [NSString stringWithFormat:@"%@username=%@&password=%@&via=mobileapp", Ad_Posting_URL, appDelegate.user.Username, appDelegate.user.Password];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strURL]];
}

- (IBAction)pressCloseBtn:(id)sender {
    _notificationUIView.hidden = YES;
}

#pragma mark ActionSheet
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){ //Email
        [self showShareToEmail];
    }else if (buttonIndex == 1){ //SMS
        [self showShareToSMS];
    }else if (buttonIndex == 2){ //Facebook
        [self showShareToFacebook];
    }else if (buttonIndex == 3){ // Twitter
        [self showShareToTwitter];
    }
}

#pragma mark Sharing Methods
- (void)showShareToFacebook
{
    //Sharing photo!
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSString *strMessage = [NSString stringWithFormat:@"%@ \n%@ \nfor $%@",strTitle, strDescription, [NSString stringWithFormat:@"%0.2f", [strPrice floatValue]]];
        [fbSheetOBJ setInitialText:strMessage];
        [fbSheetOBJ setTitle:strTitle];
        
        if (imgShare != nil)
            [fbSheetOBJ addImage:imgShare];
        
        [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"You are not logged in to Facebook or if the facebook app is not installed." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void) showShareToTwitter
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSString *strMessage = [NSString stringWithFormat:@"%@ \n%@ \nfor $%@",strTitle, strDescription, [NSString stringWithFormat:@"%0.2f", [strPrice floatValue]]];
        NSString *messageBody = strMessage;
        
        [tweetSheetOBJ setTitle:strTitle];
        [tweetSheetOBJ setInitialText:messageBody];
        //        [tweetSheetOBJ addURL:[NSURL URLWithString:@"http://www.weblineindia.com"]];
        
        if (imgShare != nil)
            [tweetSheetOBJ addImage:imgShare];
        
        [self presentViewController:tweetSheetOBJ animated:YES completion:Nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!" message:@"You are not logged in to Twitter or if the Twitter app is not installed." delegate:nil cancelButtonTitle:@"O K" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void) showShareToSMS{
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = [NSArray new];
    NSString *strMessage = [NSString stringWithFormat:@"%@ \n%@ \nfor $%@",strTitle, strDescription, [NSString stringWithFormat:@"%0.2f", [strPrice floatValue]]];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:strMessage];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void) showShareToEmail{
    NSString *emailTitle = strTitle;
    
    NSString *strMessage = [NSString stringWithFormat:@"%@ \n%@ \nfor $%@",strTitle, strDescription, [NSString stringWithFormat:@"%0.2f", [strPrice floatValue]]];
    
    NSString *messageBody = strMessage;
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    //    [mc setToRecipients:toRecipents];
    
    if (imgShare != nil)
    {
        NSData *myImageData = UIImagePNGRepresentation(imgShare);
        [mc addAttachmentData:myImageData mimeType:@"image/png" fileName:@"share.png"];
    }
    
    
    [self presentViewController:mc animated:YES completion:NULL];
}

#pragma mark - MFMailComposeViewController
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            break;
        }
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - MFMessageComposeViewController
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
