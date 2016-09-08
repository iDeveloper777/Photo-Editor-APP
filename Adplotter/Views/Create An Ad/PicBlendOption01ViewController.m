//
//  PicBlendOption01ViewController.m
//  Adplotter
//
//  Created by Csaba Toth on 5/5/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "PicBlendOption01ViewController.h"
#import "TheSidebarController.h"
#import "Public.h"
#import "AppDelegate.h"

#import "PicBlendSaveViewController.h"

#define defaultBorderColor [UIColor colorWithRed:252.0/255.0 green:145.0/2550. blue:125.0/255.0 alpha:1.0]

@interface PicBlendOption01ViewController (){
    UIImageView *tmpImageView;
    
    UIColor *borderColor;
    int isBackgroundOnOff;
    int isText;
    
    int isBottomUIView;
    
    CGPoint realLocation;
    CGRect rectTextView, rectTextViewEditing;
    
    CGRect rect;
    int nBorder, nPadding;
}

@end

@implementation PicBlendOption01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isBackgroundOnOff = 0;
    isText = 0;
    
    [self setLayout];
    [self setEvents];
    borderColor = _imgBorderColor.backgroundColor;
//    borderColor = [UIColor clearColor];
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
    self.txtRichTextEditor.hidden = YES;
    self.txtRichTextEditor.font = [UIFont boldSystemFontOfSize:18.0];
    self.txtRichTextEditor.textColor = [UIColor whiteColor];
    self.txtRichTextEditor.backgroundColor = [UIColor clearColor];
    
//    self.txtRichTextEditor.layer.borderColor = [[UIColor blackColor] CGColor];
    self.clearView.hidden = YES;
    self.bottomUIView.hidden = YES;
    isBottomUIView = 0;
    [self.segBorder setSelectedSegmentIndex:1];
    
    self.imgBorderColor.layer.cornerRadius = self.imgBorderColor.frame.size.height / 2;
    self.imgBorderColor.layer.masksToBounds = YES;

    rectTextView = CGRectMake(X(_backgroundUIView)+8,Y(_backgroundUIView)+8, WIDTH(_backgroundUIView)-16, HEIGHT(_backgroundUIView)-16);
    rectTextViewEditing = CGRectMake(X(_backgroundUIView)+8, Y(_backgroundUIView)+8, WIDTH(_backgroundUIView)-16, HEIGHT(_backgroundUIView)/2-8);
    [_txtRichTextEditor setFrame:rectTextView];
    [_clearView setFrame:rectTextView];
    
    //Optimize any size
    CGSize newSize = [_txtRichTextEditor sizeThatFits:CGSizeMake(WIDTH(_txtRichTextEditor), MAXFLOAT)];
    CGRect newFrame = _txtRichTextEditor.frame;
    newFrame.size = CGSizeMake(WIDTH(_txtRichTextEditor), newSize.height);
    _txtRichTextEditor.frame = newFrame;
    _clearView.frame = newFrame;
    rectTextView = newFrame;
    
    realLocation = _clearView.center;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        nBorder = 10; nPadding = 4;
    }else{
        nBorder = 10; nPadding = 4;
    }
    
    rect = self.backgroundUIView.frame;
    
    if (_nTemplateIndex == 0){
        [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width-12, rect.size.height-12)];
        self.imgChip02.hidden = YES;
        self.imgChip03.hidden = YES;
        self.imgChip04.hidden = YES;
    }
    
    if (_nTemplateIndex == 1){
        self.imgChip04.hidden = NO;
        [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip02 setFrame:CGRectMake(rect.size.width/2+nPadding, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip03 setFrame:CGRectMake(6, rect.size.height/2+nPadding, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip04 setFrame:CGRectMake(rect.size.width/2+nPadding, rect.size.height/2+nPadding, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        
    }else if (_nTemplateIndex == 2){
        self.imgChip04.hidden = YES;
        [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width/2-10, rect.size.height-12)];
        self.imgChip01.image = [UIImage imageNamed:@"img_PicBlend_back02.png"];
        [self.imgChip02 setFrame:CGRectMake(rect.size.width/2+nPadding, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip03 setFrame:CGRectMake(rect.size.width/2+nPadding, rect.size.height/2+nPadding, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
    }else if (_nTemplateIndex == 3){
        self.imgChip04.hidden = YES;
        [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip02 setFrame:CGRectMake(rect.size.width/2+nPadding, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip03 setFrame:CGRectMake(6, rect.size.height/2+nPadding, rect.size.width-12, rect.size.height/2-nBorder)];
        self.imgChip03.image = [UIImage imageNamed:@"img_PicBlend_back03.png"];
    }else if (_nTemplateIndex == 4){
        self.imgChip04.hidden = YES;
        [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width-12, rect.size.height/2-nBorder)];
        self.imgChip01.image = [UIImage imageNamed:@"img_PicBlend_back03.png"];
        [self.imgChip02 setFrame:CGRectMake(6, rect.size.height/2+4, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip03 setFrame:CGRectMake(rect.size.width/2+4, rect.size.height/2+4, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
    }else if (_nTemplateIndex == 5){
        self.imgChip04.hidden = YES;
        [self.imgChip01 setFrame:CGRectMake(6, 6, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip02 setFrame:CGRectMake(6, rect.size.height/2+4, rect.size.width/2-nBorder, rect.size.height/2-nBorder)];
        [self.imgChip03 setFrame:CGRectMake(rect.size.width/2+4, 6, rect.size.width/2-nBorder, rect.size.height-12)];
        self.imgChip03.image = [UIImage imageNamed:@"img_PicBlend_back02.png"];
    }else if (_nTemplateIndex == 6){
        self.imgChip04.hidden = YES;
        [self.imgChip01 setFrame:CGRectMake(6, 6, (rect.size.width-24)/3, rect.size.height-12)];
        [self.imgChip02 setFrame:CGRectMake((rect.size.width-24)/3+12, 6, (rect.size.width-24)/3, rect.size.height-12)];
        [self.imgChip03 setFrame:CGRectMake((rect.size.width-24)/3*2+18, 6, (rect.size.width-24)/3, rect.size.height-12)];
        self.imgChip01.image = [UIImage imageNamed:@"img_PicBlend_back04.png"];
        self.imgChip02.image = [UIImage imageNamed:@"img_PicBlend_back04.png"];
        self.imgChip03.image = [UIImage imageNamed:@"img_PicBlend_back04.png"];
    }
}

#pragma mark setEvents
- (void) setEvents{
    UITapGestureRecognizer *singleTap01 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    singleTap01.numberOfTapsRequired = 1;
    [self.imgChip01 setUserInteractionEnabled:YES];
    [self.imgChip01 addGestureRecognizer:singleTap01];
    
    UITapGestureRecognizer *singleTap02 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    singleTap02.numberOfTapsRequired = 1;
    [self.imgChip02 setUserInteractionEnabled:YES];
    [self.imgChip02 addGestureRecognizer:singleTap02];
    
    UITapGestureRecognizer *singleTap03 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    singleTap03.numberOfTapsRequired = 1;
    [self.imgChip03 setUserInteractionEnabled:YES];
    [self.imgChip03 addGestureRecognizer:singleTap03];
    
    UITapGestureRecognizer *singleTap04 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    singleTap04.numberOfTapsRequired = 1;
    [self.imgChip04 setUserInteractionEnabled:YES];
    [self.imgChip04 addGestureRecognizer:singleTap04];
    
}

- (void) tapGesture: (UIGestureRecognizer *) gestureRecognizer{
    //play sound
    [self playButtonSound];
    
    tmpImageView = (UIImageView *)gestureRecognizer.view;
    
    AppDelegate *appDelegate = [AppDelegate sharedAppDeleate];
    appDelegate.imageWidth = (int)tmpImageView.bounds.size.width;
    appDelegate.imageHeight = (int)tmpImageView.bounds.size.height;
    
    NSLog(@"Import!!!");
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Import !" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Library", nil];
    [sheet showInView:self.view];
}

#pragma mark Touch Event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.view.tag == 101 && touch.tapCount == 2){
        [self.txtRichTextEditor becomeFirstResponder];
        
        [_txtRichTextEditor setBackgroundColor:[UIColor clearColor]];
        [_txtRichTextEditor setFrame:rectTextViewEditing];
        [_clearView setFrame:rectTextViewEditing];
        
        _clearView.hidden = YES;
    }else{
        [self.txtRichTextEditor resignFirstResponder];
        if (isText == 1){
            _clearView.hidden = NO;
            
            [_txtRichTextEditor setBackgroundColor:[UIColor clearColor]];
            [_txtRichTextEditor setFrame:rectTextView];
            [_clearView setFrame:rectTextView];
            _txtRichTextEditor.center = realLocation;
            _clearView.center = realLocation;
            _txtRichTextEditor.layer.borderWidth = 1.0;
            
            //Optimize any size
            CGSize newSize = [_txtRichTextEditor sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            CGRect newFrame = _txtRichTextEditor.frame;
            if ([_txtRichTextEditor.text isEqual:@""])
                newFrame.size = CGSizeMake(WIDTH(_backgroundUIView)-16, newSize.height);
            else
                newFrame.size = CGSizeMake(newSize.width, newSize.height);
            _txtRichTextEditor.frame = newFrame;
            _clearView.frame = newFrame;
        }
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if (touch.view.tag == 101){
        realLocation = CGPointMake(location.x, location.y - Y(_templateUIView));
        _txtRichTextEditor.center = realLocation;
        rectTextView = _txtRichTextEditor.frame;
        touch.view.center = realLocation;
    }
}

#pragma mark UITextView Event
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView{
    
    return YES;
}

#pragma mark color picker
-(IBAction)getColor
{
    InfColorPickerController* picker = [InfColorPickerController colorPickerViewController];
    picker.delegate = self;
    picker.sourceColor = [UIColor redColor];
    
    [picker presentModallyOverViewController: self];
}

- (void) colorPickerControllerDidFinish: (InfColorPickerController*) picker
{
    borderColor=picker.resultColor;
    [self.imgBorderColor setBackgroundColor:borderColor];
    
    if (isBackgroundOnOff == 1)
        [self.backgroundUIView setBackgroundColor:borderColor];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
    if (tmpImageView != nil)
        tmpImageView.image=cropedImage;
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Action
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
        [self importFromCamera];
    else if(buttonIndex==1)
        [self importFromPhotoLibrary];
}

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
        [self presentViewController:picker animated:NO completion:nil];
    });
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

- (IBAction)pressTextBtn:(id)sender {
    if (isText == 0){
        isText = 1;
        _txtRichTextEditor.hidden = NO;
        _txtRichTextEditor.layer.borderWidth = 1.0;
        _clearView.hidden = NO;
    }else{
        isText = 0;
        _txtRichTextEditor.hidden = YES;
        _txtRichTextEditor.layer.borderWidth = 1.0;
        _clearView.hidden = YES;
    }
}

- (IBAction)pressBorderColorBtn:(id)sender {
    if (isBottomUIView == 0){
        isBottomUIView = 1;
        self.bottomUIView.hidden = NO;
    }else if (isBottomUIView == 1){
        isBottomUIView = 0;
        self.bottomUIView.hidden = YES;
    }
}

- (IBAction)pressContinueBtn:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    
    PicBlendSaveViewController *tpViewController = [storyboard instantiateViewControllerWithIdentifier:@"PicBlendSaveView"];
    tpViewController.nTemplateIndex = _nTemplateIndex;
    tpViewController.isBackgroundOnOff = isBackgroundOnOff;
    tpViewController.borderColor = borderColor;
    tpViewController.imgOriginal01 = self.imgChip01.image;
    tpViewController.imgOriginal02 = self.imgChip02.image;
    tpViewController.imgOriginal03 = self.imgChip03.image;
    tpViewController.imgOriginal04 = self.imgChip04.image;
    
    tpViewController.isText = isText;
    tpViewController.txtRichTextEditor = _txtRichTextEditor;
    tpViewController.rectText = _txtRichTextEditor.frame;
    [self.navigationController pushViewController:tpViewController animated:TRUE];
}

- (IBAction)pressColorPickerBtn:(id)sender {
    [self getColor];
}

- (IBAction)valueChange:(id)sender {
    if (_segBorder.selectedSegmentIndex == 0){
        isBackgroundOnOff = 1;
        [self.backgroundUIView setBackgroundColor:borderColor];
    }else{
        isBackgroundOnOff = 0;
        [self.backgroundUIView setBackgroundColor:[UIColor clearColor]];
    }
}

@end
