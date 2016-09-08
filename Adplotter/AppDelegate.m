//
//  AppDelegate.m
//  Adplotter
//
//  Created by Csaba Toth on 23/4/15..
//  Copyright (c) 2015 Csaba Toth. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){

}

@end

@implementation AppDelegate

static AppDelegate* sharedDelegate = nil;
+(AppDelegate *)sharedAppDeleate{
    if (sharedDelegate == nil)
        sharedDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    
    return sharedDelegate;
}

-(NSString*)storyboardName
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){ //iPad
        _nDeviceType = 3;
        return @"Main_iPad";
    }else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        if (iOSDeviceScreenSize.height == 480){ //iphone 4
            _nDeviceType = 2;
            return @"Main_iPhone4";
        }else{
            _nDeviceType = 1;
            return @"Main";
        }
    }
    
    return @"Main";
}

#pragma mark initStoryboard
- (void) initStoryboard{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[[AppDelegate sharedAppDeleate] storyboardName] bundle:nil];
    
    RootNavi *viewController = (RootNavi *)[storyboard instantiateViewControllerWithIdentifier:@"RootNavi"];
    self.window.rootViewController = viewController;
}

#pragma mark - initDatas
- (void) initDatas{
    _arrCategory = [NSMutableArray new];
    _arrCategory01 = [NSMutableArray new];
    _arrCategory02 = [NSMutableArray new];
    _arrCategory03 = [NSMutableArray new];
    _arrCategory04 = [NSMutableArray new];
    _arrCategory05 = [NSMutableArray new];
    _arrCategory06 = [NSMutableArray new];
    _arrCategory07 = [NSMutableArray new];
    
    _isFacebookLogin = 0;
    _isFacebookSignup = 0;
    _facebookEmail = @"";
    _user = [[UserModel alloc] initUserData];
    _nSegmentIndex = 0;
    _nCategoryFlag = 0;
    _facebookID = @"";
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self initDatas];

    _imageWidth = 320;
    _imageHeight = 320;
    
    [self getOriginalUserInfo];
    [self initStoryboard];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark getOriginalUserInfo
- (void) getOriginalUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *tempUser = (NSString *)[userDefaults objectForKey:@"Username"];
    if (![tempUser isKindOfClass:[NSString class]]){
        [userDefaults setObject:@"" forKey:@"Username"];
        [userDefaults setObject:@"" forKey:@"Password"];
        [userDefaults synchronize];
        
        _Username = @"";
        _Password = @"";
    }else{
        _Username = (NSString *)[userDefaults objectForKey:@"Username"];
        _Password = (NSString *)[userDefaults objectForKey:@"Password"];
    }
}

@end
