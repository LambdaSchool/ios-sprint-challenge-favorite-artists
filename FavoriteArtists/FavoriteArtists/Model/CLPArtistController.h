//
//  CLPArtistController.h
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLPArtist;

typedef void(^CLPArtistCompletionHandler)(CLPArtist *_Nullable artist, NSError *_Nullable error);

@interface CLPArtistController : NSObject

- (void)addArtist:(nonnull CLPArtist *)artist;
- (NSUInteger)artistCount;
- (nonnull CLPArtist *)artistAtIndex:(int)index;
- (void)deleteArtistAtIndex:(int)index;

- (void)fetchArtistForQuery:(NSString *_Nonnull)query :(CLPArtistCompletionHandler _Nonnull )completionHandler;

@end
