//
//  IIISong.m
//  Lyric Finder
//
//  Created by Ilgar Ilyasov on 11/16/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIISong.h"

@implementation IIISong

- (instancetype)initWithTitle:(NSString *)title
                       artist:(NSString *)artist
                       lyrics:(NSString *)lyrics
                       rating:(int)rating
{
    self = [super init];
    if (self) {
        _title = title;
        _artist = artist;
        _lyrics = lyrics;
        _rating = &rating;
    }
    return self;
}

@end
