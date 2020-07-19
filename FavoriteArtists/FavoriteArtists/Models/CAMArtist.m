//
//  CAMArtist.m
//  FavoriteArtists
//
//  Created by Cody Morley on 7/17/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMArtist.h"

@implementation CAMArtist

- (instancetype)initWithName: (NSString *)name
                         bio: (NSString *)bio
                     founded: (int)founded
{
    self = [super init];
    if (self) {
        _name = name;
        _bio = bio;
        _founded = founded;
    }
    return self;
}

@end

