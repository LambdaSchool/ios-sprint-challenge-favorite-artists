//
//  DRMLyric.h
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRMLyric : NSObject

@property (copy) NSString *artist;
@property (copy) NSString *trackName;
@property (copy) NSString *lyrics;
@property int rating;

- (instancetype)initWith: (NSString *)artist trackName: (NSString *)trackName lyrics: (NSString *)lyrics andRating: (int)rating;

@end

NS_ASSUME_NONNULL_END
