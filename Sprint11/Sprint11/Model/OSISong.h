//
//  OSISong.h
//  Sprint11
//
//  Created by Sergey Osipyan on 3/1/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSISong : NSObject

@property NSString *title;
@property NSString *artist;
@property NSString *lyrics;
@property NSInteger rating;

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist lyrics:(NSString *)lyrics rating:(NSInteger)rating;

@end

NS_ASSUME_NONNULL_END
