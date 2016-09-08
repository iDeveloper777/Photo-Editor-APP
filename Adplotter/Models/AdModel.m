//
//  AdModel.h
//  Adplotter
//
//  Created by Csaba Toth on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#import "AdModel.h"

@implementation AdModel

- (instancetype) initWithData:(int)AdID
                       UserID:(int)UserID
                   CategoryID:(int)CategoryID
                        Title:(NSString *)Title
                  Description:(NSString *)Description
                        Price:(NSString *)Price
                   PictureURL:(NSString *)PictureURL{

    _AdID = AdID;
    _UserID = UserID;
    _CategoryID = CategoryID;
    _Title = Title;
    _Description = Description;
    _Price = Price;
    _PictureURL = PictureURL;
    
    return self;
}

@end
