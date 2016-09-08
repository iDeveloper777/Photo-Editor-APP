//
//  AppDelegate.h
//  Adplotter
//
//  Created by Csaba Toth on 23/4/15.
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@class UserModel;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//Device Type
@property (assign, nonatomic) int nDeviceType;

//UserModel
@property (strong, nonatomic) UserModel *user;

//Facebook Login
@property (assign, nonatomic) int isFacebookLogin;
@property (assign, nonatomic) int isFacebookSignup;
@property (assign, nonatomic) NSString *facebookEmail;

//Category
@property (assign, nonatomic) int nCategoryFlag;
@property (strong, nonatomic) NSString *strParent;
@property (strong, nonatomic) NSMutableArray *arrCategory;
@property (strong, nonatomic) NSMutableArray *arrCategory01;
@property (strong, nonatomic) NSMutableArray *arrCategory02;
@property (strong, nonatomic) NSMutableArray *arrCategory03;
@property (strong, nonatomic) NSMutableArray *arrCategory04;
@property (strong, nonatomic) NSMutableArray *arrCategory05;
@property (strong, nonatomic) NSMutableArray *arrCategory06;
@property (strong, nonatomic) NSMutableArray *arrCategory07;

//UserData
@property (strong, nonatomic) NSString *Username;
@property (strong, nonatomic) NSString *Password;

//FacebookID
@property (strong, nonatomic) NSString *facebookID;

//Ad Datas
@property (assign, nonatomic) int nCategoryIndex;
@property (strong, nonatomic) NSString *strTitle;
@property (strong, nonatomic) NSString *strDescription;
@property (strong, nonatomic) NSString *strPrice;

//SegmentIndex
@property (assign, nonatomic) int nSegmentIndex;

//CropImage width and height
@property (assign, nonatomic) int imageWidth;
@property (assign, nonatomic) int imageHeight;

@property (assign, nonatomic) int isHelpAbout;

+(AppDelegate *)sharedAppDeleate;
-(NSString*)storyboardName;

- (void) initDatas;

@end

