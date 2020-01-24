//
//  DPRArtistController.h
//  Favorite Artists
//
//  Created by Dennis Rudolph on 1/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPRArtist.h"

NS_ASSUME_NONNULL_BEGIN

@interface DPRArtistController : NSObject

@property NSMutableArray *artists;

- (void)searchArtistByName:(NSString *)name completion:(void (^)(DPRArtist *artist, NSError *error))completion;
- (void)saveArtists;
- (void)loadArtists;

@end

NS_ASSUME_NONNULL_END
