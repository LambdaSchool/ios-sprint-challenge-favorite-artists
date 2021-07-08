//
//  DRMLyric+NSJSONSerialization.h
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMLyric.h"

NS_ASSUME_NONNULL_BEGIN

@interface DRMLyric (NSJSONSerialization)

- (instancetype)initWithDictionary: (NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END
