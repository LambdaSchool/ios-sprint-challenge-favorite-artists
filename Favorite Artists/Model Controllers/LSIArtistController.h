//
//  LSIArtistController.h
//  Favorite Artists
//
//  Created by macbook on 1/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//


#import <Foundation/Foundation.h>

@class LSIArtist;

@interface LSIArtistController : NSObject

@property (nonatomic, copy, readonly) NSArray *favoriteArtists;

@property LSIArtist *fetchedArtist;

- (void)searchArtistWithSearchTerm:(NSString *)searchTerm
completion:(void (^)(NSError *error))completion;



- (LSIArtist *)AddArtistWithName:(NSString *)name
                       biography:(NSString *)biography
                      yearFormed:(int)yearFormed;


- (void)deleteArtist:(LSIArtist *)artist;

@end
