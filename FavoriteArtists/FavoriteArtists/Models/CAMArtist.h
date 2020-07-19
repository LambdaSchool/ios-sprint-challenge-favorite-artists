//
//  CAMArtist.h
//  FavoriteArtists
//
//  Created by Cody Morley on 7/17/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAMArtist : NSObject

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *bio;
@property (readonly, nonatomic) int founded;

- (instancetype)initWithName:(NSString *)name
                         bio:(NSString *)bio
                     founded:(int)founded;

@end

NS_ASSUME_NONNULL_END

