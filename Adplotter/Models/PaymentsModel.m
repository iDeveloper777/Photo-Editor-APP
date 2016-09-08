//
//  CategoryModel.h
//  Adplotter
//
//  Created by Csaba Toth on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#import "PaymentsModel.h"

@implementation PaymentsModel

- (instancetype) initWithData:(NSString *)UserID
                      Invoice:(NSString *)Invoice
                  Transaction:(NSString *)Transaction
                         Date:(NSString *)Date
                       Amount:(NSString *)Amount
                      Details:(NSString *)Details{

    _UserID = UserID;
    _Invoice = Invoice;
    _Transaction = Transaction;
    _Date = Date;
    _Amount = Amount;
    _Details = Details;
    
    return self;
}
@end
