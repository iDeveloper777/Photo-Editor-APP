//
//  AdModel
//  Adplotter
//
//  Created by Csaba Toth on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#ifndef Adplotter_AdModel_h
#define Adplotter_AdModel_h

#import <Foundation/Foundation.h>

@protocol AdModel
@end


@interface AdModel : NSObject

@property (assign, nonatomic) int AdID;
@property (assign, nonatomic) int UserID;
@property (assign, nonatomic) int CategoryID;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *Description;
@property (strong, nonatomic) NSString *Price;
@property (strong, nonatomic) NSString *PictureURL;

- (instancetype) initWithData:(int) AdID
                       UserID:(int) UserID
                   CategoryID:(int) CategoryID
                        Title:(NSString *) Title
                  Description:(NSString *) Description
                        Price:(NSString *) Price
                   PictureURL:(NSString *) PictureURL;

@end

#endif
