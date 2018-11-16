//
//  DYPSong+NSJSONSerialization.m
//  LyricFinder
//
//  Created by Daniela Parra on 11/16/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPSong+NSJSONSerialization.h"

@implementation DYPSong (NSJSONSerialization)

- (instancetype)initFromDictionary:(NSDictionary *)dictionary songTitle:(NSString *)title artistName:(NSString *)artistName
{
    NSString *lyrics = dictionary[@"lyrics_body"];
    return [[DYPSong alloc] initWithTitle:title artistName:artistName lyrics:lyrics rating:0];
}

- (NSDictionary *)songDictionary
{
    return [[NSDictionary alloc] initWithObjectsAndKeys:@[self.title, @"title", self.artistName, @"artistName", self.lyrics, @"lyrics", [NSString stringWithFormat:@"Ratings: %ld", (long)self.rating], @"rating"], nil];
}

@end
