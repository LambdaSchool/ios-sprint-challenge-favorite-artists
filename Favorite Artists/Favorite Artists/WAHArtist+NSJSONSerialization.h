//
//  WAHArtist+NSJSONSerialization.h
//  Favorite Artists
//
//  Created by Wyatt Harrell on 5/15/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

#import "WAHArtist.h"

NS_ASSUME_NONNULL_BEGIN

@interface WAHArtist (NSJSONSerialization)

- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
