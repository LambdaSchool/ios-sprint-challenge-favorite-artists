//
//  Artist.h
//  FavoriteArtists
//
//  Created by Bobby Keffury on 2/7/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Artist : NSObject

//MARK: - Initialization

- (instancetype)initWithName:(NSString *)name founded:(NSString *)founded details:(NSString *)details;

//MARK: - Properties

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *founded;
@property (nonatomic, readonly, copy) NSString *details;

@end

NS_ASSUME_NONNULL_END
