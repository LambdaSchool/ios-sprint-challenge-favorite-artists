//
//  Artist.h
//  Artists
//
//  Created by Alexander Supe on 20.03.20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Artist : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *biography;
@property (nonatomic, readonly) int yearFormed;

- (instancetype)initWithName:(NSString *)name
                   biography:(NSString *)biography
                  yearFormed:(int)yearFormed;

@end

NS_ASSUME_NONNULL_END
