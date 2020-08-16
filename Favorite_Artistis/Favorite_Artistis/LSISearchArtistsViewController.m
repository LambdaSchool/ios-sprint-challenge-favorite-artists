//
//  LSISearchArtistsViewController.m
//  Favorite_Artistis
//
//  Created by Joe on 5/30/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

#import "LSISearchArtistsViewController.h"
#import "LSIArtistController.h"
#import "LSIArtist.h"

@interface LSISearchArtistsViewController () {
    
}
@end

@implementation LSISearchArtistsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _lsiArtistController = [[LSIArtistController alloc] init];
        _manager = [[NSFileManager alloc] init];
    }
    return self;
}

- (void)setArtist:(LSIArtist *)artist
{
    if (artist != _artist) {
        _artist = artist;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self clearViews];
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSString *)fileSavePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [paths objectAtIndex:0];
    return [documentFolder stringByAppendingFormat:@"saveFile.plist"];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.lsiArtistController searchForArtists:searchBar.text completion:^(LSIArtist *newArtist, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.artist = newArtist;
            
            [self updateViews];
        });
    }];
}

- (IBAction)artistSaveButtonTapped:(id)sender
{
    [self.lsiArtistController addArtist:self.artist];
    [self.delegate sendControllerToTableView:_lsiArtistController];
    NSDictionary *savedArtists = [[NSMutableDictionary alloc]init];
    for (LSIArtist *artist in _lsiArtistController.artists) {
        NSDictionary* artistDictionary = [self.lsiArtistController toDictionary: artist];
        NSString* artistName = [artistDictionary valueForKey:@"strArtist"];
        [savedArtists setValue:artistDictionary forKey:artistName];
        
    }
    
    [savedArtists writeToFile:self.fileSavePath atomically:YES];
    
}

- (void)updateViews
{
    self.artistLabel.text = self.artist.artistName;
    self.artistBioLabel.text = self.artist.artistInfo;
    self.dateFormedLabel.text = [NSString stringWithFormat:@"Date Formed: %@", self.artist.yearFormed];
    self.navigationController.title = self.artist.artistName;
    self.searchBar.text = @"";
}

- (void)clearViews
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.artistLabel.text = @"Add New Artist";
        self.artistBioLabel.text = @"Artist Bio:";
        self.dateFormedLabel.text = @"Date Formed:";
    });
}

- (void)saveController
{
    [self.delegate sendControllerToTableView:self.lsiArtistController];
}



@end
