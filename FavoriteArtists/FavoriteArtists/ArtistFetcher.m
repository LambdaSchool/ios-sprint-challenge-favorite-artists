//
//  ArtistFetcher.m
//  FavoriteArtists
//
//  Created by Jessie Ann Griffin on 5/29/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "ArtistFetcher.h"
#import "Artist.h"

static NSString *const ArtistFetcherURLString = @"https://www.theaudiodb.com/api/v1/json/1";

@implementation ArtistFetcher

- (void)fetchArtistWithName:(NSString *)name
          completionHandler:(nonnull ArtistFetcherCompletionHandler)completionHandler
{
    NSURL *baseURL = [[[NSURL alloc] initWithString:ArtistFetcherURLString]
                      URLByAppendingPathComponent:@"/search.php"];

    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:baseURL
                                                  resolvingAgainstBaseURL:YES];

    urlComponents.query = [NSString stringWithFormat:@"s=%@",name.lowercaseString];

    NSURL *url = urlComponents.URL;
    NSLog(@"Fetching Artists: %@", url);

    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching artist: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        if (!data) {
            NSLog(@"Data should not be nil.");
            return;
        }
        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
        if (!dictionary) {
            NSLog(@"Error decoding json %@", jsonError);

            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            return;
        }

        NSArray *artistArray = dictionary[@"artists"];
        NSDictionary *artistDictionary = artistArray[0];

        Artist *result = [[Artist alloc] initWithDictionary:artistDictionary];
        if (!result) {
            NSError *error = [NSError errorWithDomain:@"ArtistFetcherDomain" code:-1 userInfo:nil];

            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(result, nil);
        });
    }] resume];
}

@end
