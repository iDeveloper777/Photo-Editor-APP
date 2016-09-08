//
//  PaymentsModel
//  Adplotter
//
//  Created by Csaba Toth on 21/04/15.
//  Copyright (c) 2015 Digi. All rights reserved.
//

#ifndef Adplotter_PaymentsModel_h
#define Adplotter_PaymentsModel_h

#import <Foundation/Foundation.h>

@protocol PaymentsModel
@end


@interface PaymentsModel : NSObject

@property (strong, nonatomic) NSString *UserID;
@property (strong, nonatomic) NSString *Invoice;
@property (strong, nonatomic) NSString *Transaction;
@property (strong, nonatomic) NSString *Date;
@property (strong, nonatomic) NSString *Amount;
@property (strong, nonatomic) NSString *Details;

- (instancetype) initWithData:(NSString *) UserID
                      Invoice:(NSString *) Invoice
                  Transaction:(NSString *) Transaction
                         Date:(NSString *) Date
                       Amount:(NSString *) Amount
                      Details:(NSString *) Details;
@end

#endif
