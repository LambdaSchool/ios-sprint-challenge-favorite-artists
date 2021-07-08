//
//  DRMLyric.m
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMLyric.h"

@implementation DRMLyric

- (instancetype)initWith:(NSString *)artist trackName:(NSString *)trackName lyrics:(NSString *)lyrics andRating:(int)rating {
    self = [super init];
    if (self != nil) {
        self.artist = artist;
        self.trackName = trackName;
        self.lyrics = lyrics;
        self.rating = rating;
    }
    return self;
}

@end
