//
//  BHSearchNetworkController.h
//  LyricFinder
//
//  Created by Benjamin Hakes on 3/1/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHSearchNetworkController : NSObject

@property NSMutableArray *songs;

- (void)searchForSongLyricsForArtist:(NSString *)artist withSong:(NSString *)song completion:(void (^)(NSString *forecastsFromZipcode, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
