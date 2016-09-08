//
//  UserModel.h
//  Adplotter
//
//  Created by Csaba Toth on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#ifndef Adplotter_UserModel_h
#define Adplotter_UserModel_h

#import <Foundation/Foundation.h>

@protocol UserModel
@end


@interface UserModel : NSObject

@property (strong, nonatomic) NSString *UserGUID;
@property (strong, nonatomic) NSString *UserID;
@property (strong, nonatomic) NSString *Username;
@property (strong, nonatomic) NSString *Password;
@property (strong, nonatomic) NSString *AffiliateSponsorID;
@property (strong, nonatomic) NSString *Email;
@property (strong, nonatomic) NSString *FirstName;
@property (strong, nonatomic) NSString *LastName;
@property (strong, nonatomic) NSString *Address;
@property (strong, nonatomic) NSString *City;
@property (strong, nonatomic) NSString *State;
@property (strong, nonatomic) NSString *Zip;
@property (strong, nonatomic) NSString *Phone;
@property (strong, nonatomic) NSString *Country;
@property (strong, nonatomic) NSString *IP;
@property (strong, nonatomic) NSString *Referer;
@property (strong, nonatomic) NSString *FacebookID;

- (instancetype) initUserData;
- (instancetype) initUserWithDic: (NSDictionary *) dic;
@end

#endif
