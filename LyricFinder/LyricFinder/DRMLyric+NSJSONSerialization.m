//
//  DRMLyric+NSJSONSerialization.m
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMLyric+NSJSONSerialization.h"

@implementation DRMLyric (NSJSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *artist = dictionary[@"artist"];
    NSString *trackName = dictionary[@"trackName"];
    NSString *lyrics = dictionary[@"lyrics"];
    NSNumber *rating = dictionary[@"rating"];
    
    return [self initWith: artist trackName: trackName lyrics: lyrics andRating: rating.intValue];
}

- (NSDictionary *)dictionaryRepresentation {
    return @{@"artist": self.artist, @"trackName": self.trackName, @"lyrics": self.lyrics, @"rating": @(self.rating)};
}

@end
