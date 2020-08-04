//
//  JMCArtist.h
//  FavoriteArtists
//
//  Created by Jarren Campos on 8/3/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCArtist : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *biography;
@property (nonatomic, readonly) int yearFormed;

- (instancetype)initWithName:(NSString *)name
                   biography:(NSString *)biography
                  yearFormed:(int)yearFormed;

@end

NS_ASSUME_NONNULL_END
