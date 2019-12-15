//
//  GIPArtistController.m
//  Favorite-Artists
//
//  Created by Gi Pyo Kim on 12/13/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPArtistController.h"
#import "GIPArtist+NSJSONSerialization.h"
#import "GIPArtist.h"

@interface GIPArtistController()

- (void)save;
- (void)load;

@end

@implementation GIPArtistController

static NSString *const baseURLString = @"https://theaudiodb.com/api/v1/json";
static NSString *const testApiKey = @"1";

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *docURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *saveURL = [docURL URLByAppendingPathComponent:@"Favorite-Artists"];
        
        _artists = [[NSMutableArray alloc] initWithContentsOfURL:saveURL];
    }
    return self;
}

- (void)searchArtistWithName:(NSString *)name completion:(void (^)(GIPArtist *artist, NSError *error))completion {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:testApiKey];
    baseURL = [baseURL URLByAppendingPathComponent:@"search.php"];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *searchName = [NSURLQueryItem queryItemWithName:@"s" value:name];
    [components setQueryItems:@[searchName]];
     
    NSURL *url = [components URL];
    NSLog(@"URL: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            NSLog(@"Data returned nil");
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if(jsonError) {
            completion(nil, error);
            return;
        }
        
        if (![json isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a top level dictionary as expected");
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        NSNull *errorCheck = json[@"artists"];
        if (errorCheck != [NSNull null]) {
            NSArray *results = json[@"artists"];
            NSDictionary *result = results[0];
            
            GIPArtist *artist = [[GIPArtist alloc] initWithDictionary:result];
            
            completion(artist, nil);
            return;
        }
        
        NSLog(@"No artist was found.");
        completion(nil, nil);
        
            

    }];
    [task resume];
     
}

- (void)addArtist:(GIPArtist *)artist {
    [self.artists addObject:[artist toDictionary]];
    [self save];
}

- (void)removeArtist:(GIPArtist *)artist {
    [self.artists removeObject:[artist toDictionary]];
    [self save];
}

- (void)save {
    NSURL *docURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *saveURL = [docURL URLByAppendingPathComponent:@"Favorite-Artists"];
    NSLog(@"Saved URL: %@", saveURL.absoluteString);
    bool saved = [self.artists writeToURL:saveURL atomically:YES];
    NSLog(@"Saved: %d", saved);
}


@end
