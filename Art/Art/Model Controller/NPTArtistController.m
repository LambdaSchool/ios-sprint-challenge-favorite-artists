//
//  ViewController.h
//  Art
//
//  Created by Nick Nguyen on 4/17/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//


#import "NPTArtistController.h"
#import "NPTArtist.h"
#import "NPTArtist+NSJSONSerialization.h"

@interface NPTArtistController() {}

@property (nonatomic) NSMutableArray *internalSavedArtists;

@end

@implementation NPTArtistController

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalSavedArtists = [[NSMutableArray alloc] init];
    }
    return self;
}


- (NSArray *)savedArtists {
    return [self.internalSavedArtists copy];
}

- (void)saveArtist:(NPTArtist *)artist {
    NSLog(@"saveArtist");
    [self.internalSavedArtists addObject:artist];
    [self saveToPersistentStore];
}

- (void)removeArtist:(NPTArtist *)artist {
    [self.internalSavedArtists removeObject:artist];
    [self saveToPersistentStore];
}

- (NSURL *)persistentFileURL {
    
    NSURL *documentDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *fileName = @"artists.json";
    return [documentDirectory URLByAppendingPathComponent:fileName];
}

- (void)saveToPersistentStore {
    NSError *saveError = nil;
    NSURL *url = [self persistentFileURL];
    NSMutableArray *artistsArray = [[NSMutableArray alloc] init];
    
    for (NPTArtist *artist in self.internalSavedArtists) {
        NSDictionary *artistDict = [artist toDictionary];
        [artistsArray addObject:artistDict];
    }
    NSDictionary *artistsDictionary = @{
        @"artists" : artistsArray
    };
    bool successfulSave = [artistsDictionary writeToURL:url error:nil];
    if (successfulSave) {
        NSLog(@"saved");
        return;
    } else {
        NSLog(@"Error saving artists: %@", saveError);
    }
}

- (void)loadFromPersistentStore {
    NSURL *url = [self persistentFileURL];
    
    NSDictionary *artistsDictionary = [NSDictionary dictionaryWithContentsOfURL:url];
    
    if (![artistsDictionary[@"artists"]  isEqual: @""]) {
        NSArray *artistDictionaries = artistsDictionary[@"artists"];
        for (NSDictionary *artistDictionary in artistDictionaries) {
            NPTArtist *artist = [[NPTArtist alloc] initWithDictionary:artistDictionary];
            [self.internalSavedArtists addObject:artist];
        }
    }
}
static NSString * const baseURLString = @"https://www.theaudiodb.com/api/v1/json/1/search.php";

- (void)searchForArtistWithName:(NSString *)name completion:(void (^)(NPTArtist *artist, NSError *error))completion {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *searchItem = [NSURLQueryItem queryItemWithName:@"s" value:name];
    [components setQueryItems:@[searchItem]];
    NSURL *url = [components URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a Dictionary as expected");
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        if (dictionary[@"artists"] != [NSNull null]) {
            NSArray *artistDictionaries = dictionary[@"artists"];
            NSDictionary *artistDictionary = artistDictionaries.firstObject;
            NPTArtist *artist = [[NPTArtist alloc] initWithDictionary:artistDictionary];
            
            completion(artist, nil);
        }
    }] resume];
}


@end
