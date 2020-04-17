//
//  SAHArtist+NSJSONSerialization.h
//  Favorite Artists
//
//  Created by scott harris on 4/17/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

#import "SAHArtist.h"

NS_ASSUME_NONNULL_BEGIN

@interface SAHArtist (NSJSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
