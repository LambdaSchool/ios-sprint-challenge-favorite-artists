//
//  SLRArtist+NSJSONSerialization.h
//  FavoriteArtists
//
//  Created by Sameera Roussi on 7/19/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

#import "SLRArtist.h"

NS_ASSUME_NONNULL_BEGIN

@interface SLRArtist (NSJSONSerialization)

- (instancetype) initFromDictionary: (NSDictionary *)dictionary;

- (NSDictionary *) dataDictionary;

@end

NS_ASSUME_NONNULL_END
