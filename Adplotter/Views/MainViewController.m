//
//  MainViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 28/04/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "MainViewController.h"

#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

//UIStatusBar
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 9;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [AppDelegate sharedAppDeleate];
    if (indexPath.row ==0) {
        CreateAnAdNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAnAdNavi"];
        
        [self.sidebarController setContentViewController:viewController];
        [self.sidebarController dismissSidebarViewController];
    }else if (indexPath.row ==1) {
        ListingManagerNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListingManagerNavi"];
        
        [self.sidebarController setContentViewController:viewController];
        [self.sidebarController dismissSidebarViewController];
    }else if (indexPath.row == 2){

    }else if (indexPath.row == 3){
        appDelegate.nSegmentIndex = 0;

        EditMyAccountNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditMyAccountNavi"];
        
        [self.sidebarController setContentViewController:viewController];
        [self.sidebarController dismissSidebarViewController];

    }else if (indexPath.row == 4){
        appDelegate.nSegmentIndex = 1;
        
        EditMyAccountNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditMyAccountNavi"];
        
        [self.sidebarController setContentViewController:viewController];
        [self.sidebarController dismissSidebarViewController];
    }else if (indexPath.row == 5){
        appDelegate.nSegmentIndex = 2;
        
        EditMyAccountNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditMyAccountNavi"];
        
        [self.sidebarController setContentViewController:viewController];
        [self.sidebarController dismissSidebarViewController];
    }else if (indexPath.row == 6){
        appDelegate.isHelpAbout = 0;
        
        HelpNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpNavi"];
        
        [self.sidebarController setContentViewController:viewController];
        [self.sidebarController dismissSidebarViewController];

    }else if (indexPath.row == 7){
        appDelegate.isHelpAbout = 1;
        
        HelpNavi *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpNavi"];
        
        [self.sidebarController setContentViewController:viewController];
        [self.sidebarController dismissSidebarViewController];
        
    }else if (indexPath.row == 8){
        [[AppDelegate sharedAppDeleate] initDatas];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    ///------------------------------------///
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CreateAnAdCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListingManagerCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }else if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MyAccountCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }else if (indexPath.row == 3){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"EditMyAccountCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }else if (indexPath.row == 4){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"BillingInformationCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }else if (indexPath.row == 5){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"PaymentHistoryCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }else if (indexPath.row == 6){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"HelpCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }else if (indexPath.row == 7){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"AboutCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }else if (indexPath.row == 8){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SignOutCell" forIndexPath: indexPath];
        // change background color of selected cell
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:196.0/255.0 blue:230.0/255.0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }

    return 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
