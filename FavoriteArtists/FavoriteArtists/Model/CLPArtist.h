//
//  CLPArtist.h
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLPArtist : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) int yearFormed;
@property (nonatomic, copy) NSString *biography;

- (instancetype)initWithName:(NSString *)name yearFormed:(int)yearFormed biography:(NSString *)biography;

@end

NS_ASSUME_NONNULL_END
