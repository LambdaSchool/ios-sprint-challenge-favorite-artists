//
//  LSIErrors.m
//
//  Created by Paul Solt on 1/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIErrors.h"

NSString * const LSIErrorDomain = @"LSIErrorDomain";

NSError *errorWithMessage(NSString *message, NSInteger errorCode) {
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : message };
    NSError *error = [NSError errorWithDomain:LSIErrorDomain code:errorCode userInfo:userInfo];
    return error;
}
