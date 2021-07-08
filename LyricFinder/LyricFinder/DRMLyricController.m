//
//  DRMLyricController.m
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMLyricController.h"
#import "DRMLyric+NSJSONSerialization.h"

@interface DRMLyricController ()

- (void)saveToPersistentStore;
- (void)loadFromPersistentStore;

@end

@implementation DRMLyricController

static NSString * baseURL = @"https://musixmatchcom-musixmatch.p.rapidapi.com/wsr/1.1/matcher.lyrics.get";
static NSString * apiKey = @"485bf8151emshd2b8d386cb8abf2p1f19ebjsnc1b5d543e37c";

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _lyrics = [[NSMutableArray alloc] init];
        [self loadFromPersistentStore];
    }
    return self;
}

#pragma mark - CRUD Methods
- (void)createLyricWithArtist:(NSString *)artist trackName:(NSString *)trackName lyrics:(NSString *)lyrics andRating:(int)rating {
    DRMLyric *newLyric = [[DRMLyric alloc] initWith: artist trackName: trackName lyrics: lyrics andRating: rating];
    [self.lyrics addObject: newLyric];
    [self saveToPersistentStore];
}

- (void)updateLyric:(DRMLyric *)lyric withRating:(int)rating {
    [lyric setRating: rating];
    [self saveToPersistentStore];
}

- (void)deleteLyricAt:(NSIndexPath *)indexPath {
    [self.lyrics removeObjectAtIndex: indexPath.row];
    [self saveToPersistentStore];
}

#pragma mark - Persistence
- (void)saveToPersistentStore {
    NSMutableArray *jsonObject = [[NSMutableArray alloc] init];
    for (DRMLyric *lyric in self.lyrics) {
        [jsonObject addObject:[lyric dictionaryRepresentation]];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject: jsonObject options: 0 error: NULL];
    
    NSURL *documentsDirectory = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    NSURL *saveURL = [documentsDirectory URLByAppendingPathComponent:@"lyrics"];
    
    [data writeToURL: saveURL options: 0 error: NULL];
}

- (void)loadFromPersistentStore {
    NSURL *documentsDirectory = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    NSURL *loadURL = [documentsDirectory URLByAppendingPathComponent:@"lyrics"];
    
    NSData *data = [NSData dataWithContentsOfURL: loadURL];
    if (data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData: data options: 0 error: NULL];
        
        for (NSDictionary *dictionary in array) {
            DRMLyric *lyric = [[DRMLyric alloc] initWithDictionary: dictionary];
            [self.lyrics addObject: lyric];
        }
    }
}

#pragma mark - Networking
- (void)fetchLyricsForArtist:(NSString *)artist andTrackName:(NSString *)trackName withCompletion:(CompletionHandler)completion {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString: baseURL];
    NSURLQueryItem *artistItem = [NSURLQueryItem queryItemWithName:@"q_artist" value: artist];
    NSURLQueryItem *trackItem = [NSURLQueryItem queryItemWithName:@"q_track" value: trackName];
    [urlComponents setQueryItems:@[artistItem, trackItem]];
    
    NSURL *requestURL = urlComponents.URL;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    [request setValue: apiKey forHTTPHeaderField:@"X-RapidAPI-Key"];
    
    NSURLSessionDataTask *datatask = [NSURLSession.sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching lyrics: %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (data) {
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData: data options: 0 error: NULL];
            NSString *lyrics = results[@"lyrics_body"];
            completion(lyrics);
            return;
        } else {
            NSLog(@"No data was returned.");
            completion(nil);
        }
    }];
    
    [datatask resume];
}

@end
