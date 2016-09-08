//
//  PicBlendTemplateViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 4/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "PicBlendTemplateViewController.h"
#import "TheSidebarController.h"
#import "Public.h"
#import "AppDelegate.h"

#import "PicBlendOption01ViewController.h"

@interface PicBlendTemplateViewController (){
    int nTemplateIndex;
}

@end

@implementation PicBlendTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgSelected.hidden = YES;
}

//UIStatusBar
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - Buttons Event
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

- (IBAction)pressTemplate00:(id)sender {
    [self playButtonSound];
    nTemplateIndex = 0;
    self.imgSelected.hidden = NO;
    self.imgSelected.center = self.btnTemplate00.center;
}

- (IBAction)pressTemplate01:(id)sender {
    [self playButtonSound];
    nTemplateIndex = 1;
    self.imgSelected.hidden = NO;
    self.imgSelected.center = self.btnTemplate01.center;
}

- (IBAction)pressTemplate02:(id)sender {
    [self playButtonSound];
    nTemplateIndex = 2;
    self.imgSelected.hidden = NO;
    self.imgSelected.center = self.btnTemplate02.center;
}

- (IBAction)pressTemplate03:(id)sender {
    [self playButtonSound];
    nTemplateIndex = 3;
    self.imgSelected.hidden = NO;
    self.imgSelected.center = self.btnTemplate03.center;
}

- (IBAction)pressTemplate04:(id)sender {
    [self playButtonSound];
    nTemplateIndex = 4;
    self.imgSelected.hidden = NO;
    self.imgSelected.center = self.btnTemplate04.center;
}

- (IBAction)pressTemplate05:(id)sender {
    [self playButtonSound];
    nTemplateIndex = 5;
    self.imgSelected.hidden = NO;
    self.imgSelected.center = self.btnTemplate05.center;
}

- (IBAction)pressTemplate06:(id)sender {
    [self playButtonSound];
    nTemplateIndex = 6;
    self.imgSelected.hidden = NO;
    self.imgSelected.center = self.btnTemplate06.center;
}

- (IBAction)pressContinueBtn:(id)sender {
//    AppDelegate *appDelegate = [AppDelegate sharedAppDeleate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    
    PicBlendOption01ViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"PicBlendOption01View"];
    tpViewController.nTemplateIndex = nTemplateIndex;
    [self.navigationController pushViewController:tpViewController animated:TRUE];
}

#pragma mark - playButtonSound
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
@end
