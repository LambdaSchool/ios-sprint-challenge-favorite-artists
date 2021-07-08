//
//  DRMLyricController.h
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRMLyric.h"

typedef void (^CompletionHandler)(NSString * lyrics);

NS_ASSUME_NONNULL_BEGIN

@interface DRMLyricController : NSObject

@property (readonly) NSMutableArray *lyrics;

- (void)createLyricWithArtist: (NSString *)artist trackName: (NSString *)trackName lyrics: (NSString *)lyrics andRating: (int)rating;
- (void)updateLyric: (DRMLyric *)lyric withRating: (int)rating;
- (void)deleteLyricAt: (NSIndexPath *)indexPath;

- (void)fetchLyricsForArtist: (NSString *)artist andTrackName: (NSString *)trackName withCompletion: (CompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
