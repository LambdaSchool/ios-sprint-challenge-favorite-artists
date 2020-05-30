//
//  SBAArtist.m
//  Favorite Artists
//
//  Created by Sal B Amer on 5/29/20.
//  Copyright © 2020 Sal B AmerDEv. All rights reserved.
//

#import "SBAArtist.h"

@implementation SBAArtist

- (instancetype)initWithArtistName:(NSString *)name
                         biography:(NSString *)biography
                        yearFormed:(int)yearFormed
{
  if (self = [super init]) {
    _name = [name copy];
    _biography = [biography copy];
    _yearFormed = yearFormed;
  }
  return self;
}

@end
