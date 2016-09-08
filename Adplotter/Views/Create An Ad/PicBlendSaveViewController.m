//
//  PicBlendSaveViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 5/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "PicBlendSaveViewController.h"
#import "TheSidebarController.h"
#import "Public.h"
#import "AppDelegate.h"

@interface PicBlendSaveViewController (){
    CGRect rect;
    UIImage *capturedImage;
    
    CGPoint pointCenter01, pointCenter02, pointCenter03, pointCenter04;
    int nBorder, nPadding;
}

@end

@implementation PicBlendSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    _txtRichTextEditor.dataSource = self;
    _txtRichTextEditor.delegate = self;
    [_txtRichTextEditor setBackgroundColor:[UIColor clearColor]];
    [_txtRichTextEditor setFrame:_rectText];
    _txtRichTextEditor.layer.borderWidth = 0;
    _txtRichTextEditor.selectable = NO;
    _txtRichTextEditor.editable = NO;
    [_templateUIView addSubview:_txtRichTextEditor];
    
    if (_isText == 0)
        _txtRichTextEditor.hidden = YES;
    else
        _txtRichTextEditor.hidden = NO;
    
    rect = self.imageUIView.frame;
    if (_isBackgroundOnOff == 1)   [self.imageUIView setBackgroundColor:_borderColor];
    pointCenter01 = _imgChip01.center;
    pointCenter02 = _imgChip02.center;
    pointCenter03 = _imgChip03.center;
    pointCenter04 = _imgChip04.center;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        nBorder = 10; nPadding = 4;
    }else{
        nBorder = 10; nPadding = 4;
    }
    
    if (_nTemplateIndex == 0){
        if (_isBackgroundOnOff == 0)
            [self.imgChip01 setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        else
            [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width-12, rect.size.height-12)];
        
        self.imgChip02.hidden = YES;
        self.imgChip03.hidden = YES;
        self.imgChip04.hidden = YES;
    }
    
    
    if (_nTemplateIndex == 1){
        self.imgChip04.hidden = NO;
        if (_isBackgroundOnOff == 0){
            [self.imgChip01 setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height/2)];
            [self.imgChip02 setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height/2)];
            [self.imgChip03 setFrame:CGRectMake(0, rect.size.height/2, rect.size.width/2, rect.size.height/2)];
            [self.imgChip04 setFrame:CGRectMake(rect.size.width/2, rect.size.height/2, rect.size.width/2, rect.size.height/2)];
        }else{
            [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip02 setFrame:CGRectMake(rect.size.width/2+nPadding, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip03 setFrame:CGRectMake(6, rect.size.height/2+nPadding, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip04 setFrame:CGRectMake(rect.size.width/2+nPadding, rect.size.height/2+nPadding, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        }
    }else if (_nTemplateIndex == 2){
        self.imgChip04.hidden = YES;
        if (_isBackgroundOnOff == 0){
            [self.imgChip01 setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height)];
            [self.imgChip02 setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height/2)];
            [self.imgChip03 setFrame:CGRectMake(rect.size.width/2, rect.size.height/2, rect.size.width/2, rect.size.height/2)];
        }else{
            [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width/2-10, rect.size.height-12)];
            [self.imgChip02 setFrame:CGRectMake(rect.size.width/2+nPadding, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip03 setFrame:CGRectMake(rect.size.width/2+nPadding, rect.size.height/2+nPadding, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        }
    }else if (_nTemplateIndex == 3){
        self.imgChip04.hidden = YES;
        if (_isBackgroundOnOff == 0){
            [self.imgChip01 setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height/2)];
            [self.imgChip02 setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height/2)];
            [self.imgChip03 setFrame:CGRectMake(0, rect.size.height/2, rect.size.width, rect.size.height/2)];
        }else{
            [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip02 setFrame:CGRectMake(rect.size.width/2+nPadding, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip03 setFrame:CGRectMake(6, rect.size.height/2+nPadding, rect.size.width-12, rect.size.height/2-nBorder)];
        }
    }else if (_nTemplateIndex == 4){
        self.imgChip04.hidden = YES;
        if (_isBackgroundOnOff == 0){
            [self.imgChip01 setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height/2)];
            [self.imgChip02 setFrame:CGRectMake(0, rect.size.height/2, rect.size.width/2, rect.size.height/2)];
            [self.imgChip03 setFrame:CGRectMake(rect.size.width/2, rect.size.height/2, rect.size.width/2, rect.size.height/2)];
        }else{
            [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width-12, rect.size.height/2-nBorder)];
            [self.imgChip02 setFrame:CGRectMake(6, rect.size.height/2+4, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip03 setFrame:CGRectMake(rect.size.width/2+4, rect.size.height/2+4, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        }
    }else if (_nTemplateIndex == 5){
        self.imgChip04.hidden = YES;
        if (_isBackgroundOnOff == 0) {
            [self.imgChip01 setFrame:CGRectMake(0, 0, rect.size.width/2, rect.size.height/2)];
            [self.imgChip02 setFrame:CGRectMake(0, rect.size.height/2, rect.size.width/2, rect.size.height/2)];
            [self.imgChip03 setFrame:CGRectMake(rect.size.width/2, 0, rect.size.width/2, rect.size.height)];
        }else{
            [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip02 setFrame:CGRectMake(6, rect.size.height/2+4, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
            [self.imgChip03 setFrame:CGRectMake(rect.size.width/2+4, 6, rect.size.width/2-nBorder, rect.size.height-12)];
        }
    }else if (_nTemplateIndex == 6){
        self.imgChip04.hidden = YES;
        if (_isBackgroundOnOff == 0) {
            [self.imgChip01 setFrame:CGRectMake(0, 0, rect.size.width/3, rect.size.height)];
            [self.imgChip02 setFrame:CGRectMake(rect.size.width/3, 0, rect.size.width/3, rect.size.height)];
            [self.imgChip03 setFrame:CGRectMake(rect.size.width/3*2, 0, rect.size.width/3, rect.size.height)];
        }else{
            [self.imgChip01 setFrame:CGRectMake(6, 6, (rect.size.width-24)/3, rect.size.height-12)];
            [self.imgChip02 setFrame:CGRectMake((rect.size.width-24)/3+12, 6, (rect.size.width-24)/3, rect.size.height-12)];
            [self.imgChip03 setFrame:CGRectMake((rect.size.width-24)/3*2+18, 6, (rect.size.width-24)/3, rect.size.height-12)];
        }
    }
    
    self.imgChip01.image = self.imgOriginal01;
    self.imgChip02.image = self.imgOriginal02;
    self.imgChip03.image = self.imgOriginal03;
    self.imgChip04.image = self.imgOriginal04;
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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    CreateAnAd00ViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAnAd00View"];
    
    pushSubtype = YSTransitionTypeFromBottom;
    
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
}

- (IBAction)pressCreatePicBtn:(id)sender {
    YSTransitionType pushSubtype;
    
    [self captureScreen];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    CreateAnAdViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAnAdView"];
    tpViewController.imgAd = capturedImage;
    
    pushSubtype = YSTransitionTypeFromLeft;
    
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
}

- (IBAction)pressSaveBtn:(id)sender {
    [self captureScreen];
    [self showSaveImage];
    
    YSTransitionType pushSubtype;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    CreateAnAdViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAnAdView"];
    tpViewController.imgAd = capturedImage;
    
    pushSubtype = YSTransitionTypeFromLeft;
    
    [(YSNavigationController *)self.navigationController pushViewController:tpViewController withTransitionType:pushSubtype];
}

#pragma mark - ImageProcessing
- (void) captureScreen
{
    //get Screenshot
    UIImage *tempImage = [[ImageProcessing alloc] captureScreenInRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) currentView:self.view];
    rect.origin.y = rect.origin.y + HEIGHT(_navigationUIView);
    
    //get custom Image from Screenshot
    UIImage *resultImage = [[ImageProcessing alloc] getImageFromCustomeSize:tempImage customeRect:rect];
    capturedImage = resultImage;
  
}

- (void) showSaveImage
{
    [[ImageProcessing alloc] saveImageToAlbum:capturedImage];
}

@end
