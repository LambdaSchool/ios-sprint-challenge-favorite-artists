//
//  CLPArtist+NSJSONSerialization.m
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "CLPArtist+NSJSONSerialization.h"

@implementation CLPArtist (NSJSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"strArtist"];
    if (![name isKindOfClass:NSString.class]) return nil;
    
    NSNumber *yearFormed = dictionary[@"intFormedYear"];
    if ([yearFormed isKindOfClass:[NSNull class]]) yearFormed = nil;
    
    NSString *biography = dictionary[@"strBiographyEN"];
    if (![biography isKindOfClass:NSString.class]) return nil;
    
    return [self initWithName:name yearFormed:yearFormed.intValue biography:biography];
}

- (NSDictionary *)toDictionary
{
    NSDictionary *dictionary = @{
        @"strArtist": self.name,
        @"intFormedYear": @(self.yearFormed),
        @"strBiographyEN": self.biography,
    };
    return dictionary;
}

@end
