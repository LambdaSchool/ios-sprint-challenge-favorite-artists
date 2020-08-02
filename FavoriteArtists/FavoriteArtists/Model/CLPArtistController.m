//
//  CLPArtistController.m
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "CLPArtistController.h"
#import "CLPArtist.h"
#import "LSIErrors.h"
#import "CLPArtist+NSJSONSerialization.h"

static NSString *const ArtistControllerBaseURLString = @"https://www.theaudiodb.com/api/v1/json/1/search.php";
static NSString *const ArtistControllerFavoriteArtistsFilename = @"favoriteArtists.json";

@interface CLPArtistController ()

@property (nonatomic) NSMutableArray *artists;

@end

@implementation CLPArtistController

- (instancetype)init
{
    if (self = [super init]) {
        self.artists = [[NSMutableArray alloc] init];
        
        [self readFavoriteArtists];
    }
    return self;
}

#pragma mark - CRUD

- (void)addArtist:(CLPArtist *)artist
{
    [self.artists addObject:artist];
    [self saveFavoriteArtists];
}

- (NSUInteger)artistCount
{
    return self.artists.count;
}

- (CLPArtist *)artistAtIndex:(int)index
{
    return self.artists[index];
}

- (void)deleteArtistAtIndex:(int)index
{
    [self.artists removeObjectAtIndex:index];
    [self saveFavoriteArtists];
}

#pragma mark - Network

- (void)fetchArtistForQuery:(NSString *)query :(CLPArtistCompletionHandler)completionHandler
{
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:ArtistControllerBaseURLString];
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"s" value:query]
    ];

    [[NSURLSession.sharedSession dataTaskWithURL:urlComponents.URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching artist: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }

        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (!dictionary) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            return;
        }

        NSArray *artists = [dictionary objectForKey:@"artists"];
        if (![artists isKindOfClass:NSArray.class]) {
            NSError *apiError = errorWithMessage(@"Invalid JSON array", LSIAPIError);
            NSLog(@"Error decoding artists: %@", apiError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, apiError);
            });
            return;
        }

        if (artists.count == 0) {
            NSError *apiError = errorWithMessage(@"No artists found", LSIAPIError);
            NSLog(@"No artists found: %@", apiError);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, apiError);
            });
            return;
        }

        CLPArtist *artist = [[CLPArtist alloc] initWithDictionary:artists[0]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(artist, nil);
        });
    }] resume];
}

#pragma mark - File

- (NSURL *)favoriteArtistsURL
{
    NSURL *documentsURL = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    return [documentsURL URLByAppendingPathComponent:ArtistControllerFavoriteArtistsFilename];
}

- (void)saveFavoriteArtists
{
    NSMutableArray *artistsAsDicts = [[NSMutableArray alloc] init];
    for (CLPArtist *artist in self.artists) {
        [artistsAsDicts addObject:[artist toDictionary]];
    }
    NSURL *favArtistsURL = [self favoriteArtistsURL];
    NSError *error;
    [artistsAsDicts writeToURL:favArtistsURL error:&error];
}

- (void)readFavoriteArtists
{
    NSURL *favArtistsURL = [self favoriteArtistsURL];
    NSError *error;
    NSArray *favArtists = [[NSArray alloc] initWithContentsOfURL:favArtistsURL error:&error];
    for (NSDictionary *artistDict in favArtists) {
        [self.artists addObject:[[CLPArtist alloc] initWithDictionary:artistDict]];
    }
}

@end
