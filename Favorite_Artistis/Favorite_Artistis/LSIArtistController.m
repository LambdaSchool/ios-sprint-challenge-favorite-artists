//
//  LSIArtistController.m
//  Favorite_Artistis
//
//  Created by Joe on 8/2/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

#import "LSIArtistController.h"
#import "LSIArtist.h"
#import "LSIError.h"

static NSString *const ArtistFetcherBaseURLString = @"https://www.theaudiodb.com/api/v1/json/1/search.php?s=";

@interface LSIArtistController () {
    NSMutableArray<LSIArtist *> *_internalArtists;
    LSIArtist *_internalArtist;
}
@end

@implementation LSIArtistController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalArtists = [[NSMutableArray<LSIArtist *> alloc] init];
        [self artists];
        _artists = _internalArtists;
        _internalArtist = [[LSIArtist alloc] init];
        [self artist];
    }
    return self;
}

- (void)searchForArtists:(NSString *)searchItem completion:(ArtistFetcherCompletionHandler)completion
{
    searchItem = [searchItem stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString *searchURL = [ArtistFetcherBaseURLString stringByAppendingString: searchItem];
    NSURL *baseURL = [NSURL URLWithString:searchURL];
    
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (response) {
            NSLog(@"There was a reponse: %@", response);
        }
        
        if (error) {
            NSLog(@"There was an error: %@", error);
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"There was an Error");
        
            completion(nil, error);
            return;
        }
        
        if (![json isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a Dictionary as expected");
            completion(nil, [[NSError alloc] init]);
        }
        
        NSArray *fetchedData = json[@"artists"];
        NSString *nullCheck = [json valueForKey:@"artists"];
        LSIArtist *newArtist = [[LSIArtist alloc] init];
        if (nullCheck == (id)[NSNull null]) {
           return;
        }
        for (NSDictionary *dictionary in fetchedData) {
                       LSIArtist *myArtist = [[LSIArtist alloc] initWithDictionary:dictionary];
                       newArtist = myArtist;
                       
                   }
        completion(newArtist, nil);
    }];
    [dataTask resume];
}

- (void)addArtist:(LSIArtist *)anArtist
{
    [_internalArtists addObject:anArtist];
}

- (NSDictionary *)toDictionary:(LSIArtist *)inputtedArtist
{
    NSMutableDictionary *artistsInDict = [[NSMutableDictionary alloc] init];
    
    [artistsInDict setValue:inputtedArtist.artistName forKey:@"strArtist"];
    [artistsInDict setValue:inputtedArtist.artistInfo forKey:@"strBiographyEN"];
    [artistsInDict setValue:inputtedArtist.yearFormed forKey:@"intFormedYear"];
    return artistsInDict;
}

- (void)fromDictionary:(NSDictionary<NSString *, NSDictionary *> *)artistsFromFile
{
    for (NSDictionary *artists in artistsFromFile.allValues) {
      
            LSIArtist *artist = [[LSIArtist alloc] initWithDictionary:artists];
             [_internalArtists addObject:artist];
    }
}

@end
