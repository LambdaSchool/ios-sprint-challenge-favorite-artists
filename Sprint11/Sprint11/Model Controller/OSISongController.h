//
//  OSISongController.h
//  Sprint11
//
//  Created by Sergey Osipyan on 3/1/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSISongController : NSObject

@property (readonly) NSMutableArray *songs;

-(void)searchForSong:(NSString *)artist trackName:(NSString *)trackName completion:(void (^)(NSDictionary *song, NSError *))completion;

-(void)createSong:(NSString*)title artist:(NSString*)artist lyrics:(NSString*)lyrics rating:(NSInteger)rating;

@end

NS_ASSUME_NONNULL_END
