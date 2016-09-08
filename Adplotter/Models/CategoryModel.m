//
//  CategoryModel.h
//  Adplotter
//
//  Created by Csaba Toth on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (instancetype) initWithData:(int)categoryID Name:(NSString *)strName{
    _CategoryID = categoryID;
    _Name = strName;
    
    return self;
}
@end
