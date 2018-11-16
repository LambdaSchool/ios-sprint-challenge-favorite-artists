//
//  DYPSongController.m
//  LyricFinder
//
//  Created by Daniela Parra on 11/16/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

#import "DYPSongController.h"
#import "DYPSong.h"

@interface DYPSongController ()

@property (nonatomic, copy) NSMutableArray *internalSongs;

@end

@implementation DYPSongController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalSongs = [@[] mutableCopy];
    }
    return self;
}

- (void)addASongWithTitle:(NSString *)title artistName:(NSString *)artistName lyrics:(NSString *)lyrics rating:(NSInteger)rating
{
    DYPSong *song = [[DYPSong alloc] initWithTitle:title artistName:artistName lyrics:lyrics rating:rating];
    [self.internalSongs addObject:song];
}

- (void)searchLyricsForSongTitle:(NSString *)title artistName:(NSString *)artistName completion:(void (^)(NSString * _Nullable lyrics, NSError * _Nullable error))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLQueryItem *artistItem = [[NSURLQueryItem alloc] initWithName:@"q_artist" value:artistName];
    
    NSURLQueryItem *songTitleItem = [[NSURLQueryItem alloc] initWithName:@"q_track" value:title];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    [components setQueryItems:@[artistItem, songTitleItem]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:components.URL];
    
    [request setValue:APIKey forHTTPHeaderField:@"X-Mashape-Key"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error searching for lyrics: %@", error);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"No data returned from data task");
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        
        
    }] resume];
    
}

- (NSArray *)songs
{
    return self.internalSongs;
}

static NSString * const baseURLString = @"https://musixmatchcom-musixmatch.p.mashape.com/wsr/1.1/matcher.lyrics.get";
static NSString * const APIKey = @"s5sDpvaGIxmshWxJHrvDozLn9VUPp1rrLwXjsnaSqXGlizcXAd";

@end
