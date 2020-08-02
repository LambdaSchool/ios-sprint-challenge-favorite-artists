//
//  CLPArtist+NSJSONSerialization.h
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "CLPArtist.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLPArtist (NSJSONSerialization)

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
