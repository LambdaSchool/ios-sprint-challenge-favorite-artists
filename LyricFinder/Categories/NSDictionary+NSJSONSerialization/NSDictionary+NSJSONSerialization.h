//
//  NSDictionary+NSJSONSerialization.h
//  LyricFinder
//
//  Created by TuneUp Shop  on 3/1/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (NSJSONSerialization)

+ (void)savedSongsDictFrom:(NSArray *)savedSongs;

@end

NS_ASSUME_NONNULL_END
