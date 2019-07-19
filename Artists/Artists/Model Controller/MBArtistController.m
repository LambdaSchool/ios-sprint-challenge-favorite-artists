//
//  MBArtistController.m
//  Artists
//
//  Created by Mitchell Budge on 7/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import "MBArtistController.h"


@implementation MBArtistController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _artists = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)createArtist:(MBArtist *)artist
{
    [self.artists addObject:artist];
}

static NSString *baseURL = @"https://www.theaudiodb.com/api/v1/json/1/search.php?s=";

- (void)getArtist:(NSString *)name completionBlock:( MBCompletionBlock)completionBlock;
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:baseURL];
    NSArray *queryItems = [NSURLQueryItem queryItemWithName:@"s" value:name];
    components.queryItems = queryItems;
    NSURL *url = components.URL;
   
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (error) {
            NSLog(@"Error getting artist information: %@", error);
            completionBlock(nil, error);
            return;
        }
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"JSON error: %@", jsonError);
            completionBlock(nil, error);
            return;
        }
        NSArray *dictionary = json[@"artists"];
        MBArtist *artist = [[MBArtist alloc] initWithDictionary:dictionary[0]];
        completionBlock(artist, nil);
    }];
    [dataTask resume];
}

- (MBArtist *)fetchSavedArtist:(MBArtist *)artist {
    NSURL *directory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    NSURL *url = [[directory URLByAppendingPathComponent:artist.artist] URLByAppendingPathExtension:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    MBArtist *savedArtist = [[MBArtist alloc] initWithDictionary:dictionary];
    return savedArtist;
}

- (void)deleteArtist:(MBArtist *)artist
{
    [self.artists removeObject:artist];
}

@end
