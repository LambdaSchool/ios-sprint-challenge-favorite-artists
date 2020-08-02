//
//  LSIErrors.h
//
//  Created by Paul Solt on 1/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// LSIErrors.h
extern NSString * const LSIErrorDomain;

typedef enum : NSInteger {
    LSIAPIError = 1000,   		// generic API error
    LSIJSONDecodeError = 1001,	// JSON decoding error
    LSIDataNilError = 1002,   	// Data is nil error
    // TODO: Add any other error codes here for generic types of errors, your message can provide more details to the user
} LSIErrorCode;

//typedef NS_ENUM(NSUInteger, NameGoesHere) {
//    <#MyEnumValueA#>,
//    <#MyEnumValueB#>,
//    <#MyEnumValueC#>,
//};

/// Creates an error with a localized message in the 
NSError *errorWithMessage(NSString *message, NSInteger errorCode);
