//
//  UserModel.h
//  Adplotter
//
//  Created by Csaba Toth on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype) initUserData{
    _Username = @"";
    _Password = @"";
    _UserGUID = @"";
    _AffiliateSponsorID = @"";
    _Email = @"";
    _FirstName = @"";
    _LastName = @"";
    _Address = @"";
    _City = @"";
    _State = @"";
    _Zip = @"";
    _Phone = @"";
    _Country = @"";
    _IP = @"";
    _Referer = @"";
    _FacebookID = @"";

    return self;
}

- (instancetype) initUserWithDic:(NSDictionary *)dic{
    
    return self;
}

@end
