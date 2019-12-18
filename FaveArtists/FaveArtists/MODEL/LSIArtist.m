//
//  LSIArtist.m
//  FaveArtists
//
//  Created by John Pitts on 7/19/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import "LSIArtist.h"

@implementation LSIArtist

- (instancetype)initWithStrArtist:(NSString *)strArtist
                   strBiographyEN:(NSString *)strBiographyEN
                    intFormedYear:(long)intFormedYear {
    self = [super init];
    if (self) {
        _strArtist = [strArtist copy];
        _strBiographyEN = [strBiographyEN copy];
        _intFormedYear = intFormedYear;
    }
    return self;
}


/*  removed bc LS wanted it contained in NSJSONSerialization 'extension'
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        _strArtist = dictionary[@"artists"][@"strArtist"];
        _strBiographyEN = dictionary[@"artists"][@"strBiographyEN"];
        
        _intFormedYear = [dictionary[@"artists"][@"intFormedYear"] longValue];
                     //= (NSUInteger)yearInInt; // not sure what they want wrt using primitive but longValue is indeed primitive. also thought i remember someone saying Model objects cannot take primitives.  guess that wasn't true after all?
    }
    return self;
}
*/

- (NSString *)description {
    return [NSString stringWithFormat:@"Artist: %@\n\tBio: %@\n\tFounded: %d\n\t", self.strArtist, self.strBiographyEN, self.intFormedYear];
}

@end
