//
//  ALWSongController.m
//  

#import "ALWSongController.h"
#import "ALWSong.h"

// Category
@interface ALWSong (NSJSONSerialization)

@end

// Implementation of Category
@implementation ALWSong (NSJSONSerialization)

// Initializer to initialize model object from a dictionary
- (instancetype)initWithADictionary:(NSDictionary *)dictionary title:(NSString *)title artist:(NSString *)artist lyrics:(NSString *)lyrics rating:(NSInteger)rating {
    
    // Pull out lyrics from dictionary
    lyrics = dictionary[@"lyrics_body"];
    
    // Check to make sure it's not nil
    if (lyrics == nil) {
        return nil;
    }
    
    // Initialize an object with the lyrics received from the dictionary
    return [self initWithTitle:title artist:artist lyrics:lyrics rating:rating];
}

// Return model object in dictionary form
//[[ALWSong alloc] initWithDictionary:dictionary];

@end

@interface ALWSongController ()

@property (nonatomic) NSMutableArray *internalSongs;
@property NSString *baseURLString;
@property NSString *apiKey;

@end

@implementation ALWSongController

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        _internalSongs = [[NSMutableArray alloc] init];
        _baseURLString = @"https://musixmatchcom-musixmatch.p.rapidapi.com/wsr/1.1/matcher.lyrics.get";
        _apiKey = @"cf6d82bad1msh23e41922669f60ep127ec0jsnc636b337599c";
        
    }
    return self;
}

// Define a getter
- (NSArray *)savedSongs {
    return [self.internalSongs copy];
}

- (void)addSong:(ALWSong *)song {
    [self.internalSongs addObject:song];
}

- (void)searchForLyricsWithArtist:(NSString *)artist title:(NSString *)title withCompletionBlock:(CompletionBlock)completionBlock {
    
    // Create a URL
    NSURL *baseURL = [NSURL URLWithString:_baseURLString];
    
    // Turn it into components
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    // Add query items
    
    // artist
    NSURLQueryItem *firstSearchItem = [NSURLQueryItem queryItemWithName:@"q_artist" value:artist];
    
    // song title
    NSURLQueryItem *secondSearchItem = [NSURLQueryItem queryItemWithName:@"q_track" value:title];
    
    // Add query items to components
    [components setQueryItems:@[firstSearchItem, secondSearchItem]];
    
    // Create url with components
    NSURL *url = [components URL];
    
    // URL Request with API Key as header
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:_apiKey forHTTPHeaderField:@"X-Mashape-Key"];
    
    NSLog(@"%@", request);
    
    // Create a data task
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error !=nil) {
            NSLog(@"Error fetching data %@", error);
            completionBlock(nil, error);
            return;
        }
        
        // Take data and turn it into a JSON object (a dictionary)
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSLog(@"%@", dictionary);
        
        // Check to make sure it's a dictionary and not an array
        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a dictionary");
            completionBlock(nil, error);
            return;
        }
        
        // If it is a dictionary, pull out the song lyrics
        
        // This works, but tried below in order to use the dictionary I made in ALWSong.m
        self.savedSong = [[ALWSong alloc] init];
        self.savedSong.lyrics = [dictionary objectForKey:@"lyrics_body"];
        
        // This is the one that I've been using - changing it to extended init
        //self.savedSong = [[ALWSong alloc] initWithDictionary:dictionary];
        //self.savedSong = [[ALWSong alloc] initWithDictionary:dictionary title:title artist:artist lyrics: rating:rating];
        
        //ALWSong *song = [[ALWSong alloc] init];
        //song.lyrics = [dictionary objectForKey:@"lyrics_body"];
        
        // Save song to array
        NSMutableArray *songs = [[NSMutableArray alloc] init];
        [songs addObject:self.savedSong];
        self.internalSongs = songs;
        
        completionBlock(self.savedSong, nil);
        
    }] resume] ;
}

@end
