//
//  MSKArtistController.m
//  FavoriteArtists
//
//  Created by Lambda_School_Loaner_268 on 5/16/20.
//  Copyright © 2020 Lambda. All rights reserved.
//
#import "MSKArtistController.h"
#import "MSKArtist.h"
#import "MSKArtist+NSJSONSerialization.h"

#import "AppDelegate.h"
static NSString *baseURL = @"https://www.theaudiodb.com/api/v1/json/1/search.php";
@implementation MSKArtistController
- (instancetype)init {
    self = [super init];
    if (self) {
        _artists = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)fetchArtistWithName:(NSString *)artistName
            completionBlock:(void (^)(MSKArtist *artist,
                                      NSError * _Nullable error))completionBlock {
    NSURL *base = [NSURL URLWithString: baseURL];
        NSURLComponents *components = [NSURLComponents componentsWithURL:base
                                                 resolvingAgainstBaseURL:YES];
        NSURLQueryItem *searchItem = [NSURLQueryItem queryItemWithName:@"s"
                                                                 value:artistName];
    [components setQueryItems:@[searchItem]];
    NSURL *url = [components URL];
    [[[NSURLSession sharedSession] dataTaskWithURL:url
                                 completionHandler:^(NSData * _Nullable data,
                                                     NSURLResponse * _Nullable response,
                                                     NSError * _Nullable error) {
        if (error) {
            completionBlock(nil,
                            error);
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
        if (jsonError) {
            completionBlock(nil,
                            jsonError);
            return;
        }
        if (dictionary[@"artists"] != [NSNull null]) {
            NSArray *artistDicts = dictionary[@"artists"];
            NSDictionary *artistDict = artistDicts.firstObject;
            MSKArtist *artist = [[MSKArtist alloc] initFromDict:artistDict];

                    completionBlock(artist, nil);
            self.artist = artist;
        }
    }] resume];
}
-(NSURL *)persistentURL {
    NSURL *docs = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *artists = @"artists.json";
    return [docs URLByAppendingPathComponent:artists];
}
- (void)loadArtistsFromPersistence:(void (^)(NSError * _Nullable error))completionBlock {
    NSURL *url = [self persistentURL];
    NSDictionary *artistDict = [NSDictionary dictionaryWithContentsOfURL:url];
    NSArray *artistArray = artistDict[@"artists"];
    for (NSDictionary *dict in artistArray) {
        MSKArtist *artist = [[MSKArtist alloc] initFromDict:dict];
        [self.artists addObject:artist];
    }
}
-(void)saveArtistToPersistence:(MSKArtist *)artist
                completionBlock:(void (^)(NSError * _Nullable error))completionBlock;{
    NSURL *url = [self persistentURL];
    NSDictionary *artistDict = [artist toDict];
    [self.artists addObject:artistDict];
    [artistDict writeToURL:url
                     error:nil];
}
@end
