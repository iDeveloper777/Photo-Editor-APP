//
//  CategoryModel
//  Adplotter
//
//  Created by Csaba Toth on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#ifndef Adplotter_CategoryModel_h
#define Adplotter_CategoryModel_h

#import <Foundation/Foundation.h>

@protocol CategoryModel
@end


@interface CategoryModel : NSObject

@property (assign, nonatomic) int CategoryID;
@property (strong, nonatomic) NSString *Name;

- (instancetype) initWithData:(int) categoryID Name:(NSString *) strName;
@end

#endif
