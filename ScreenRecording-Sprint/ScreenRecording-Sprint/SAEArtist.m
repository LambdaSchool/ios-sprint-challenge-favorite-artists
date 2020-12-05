//
//  SAEArtist.m
//  ScreenRecording-Sprint
//
//  Created by Sammy Alvarado on 12/1/20.
//

#import "SAEArtist.h"

@implementation SAEArtist

- (instancetype)initWithArtist:(NSString *)artist
                        biography:(NSString *)biography
                       yearFormed:(int)yearFormed
{
    if (self = [super init]) {
        _name = artist.copy;
        _biography = biography.copy;
        _yearFormed = yearFormed;
    }
    return self;
}

@end
