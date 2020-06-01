//
//  ArtistDetailViewController.m
//  Favorite Artists
//
//  Created by David Wright on 5/31/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "Artist.h"
#import "ArtistFetcher.h"
#import "FavoriteArtistsController.h"

@interface ArtistDetailViewController ()

// Properties
@property ArtistFetcher *artistFetcher;

// IBOutlets
@property (nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) IBOutlet UILabel *artistNameLabel;
@property (nonatomic) IBOutlet UILabel *yearFormedLabel;
@property (nonatomic) IBOutlet UILabel *biographyLabel;

@end

@interface ArtistDetailViewController (UISearchBarDelegate) <UISearchBarDelegate>

@end

@implementation ArtistDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.artistFetcher = [[ArtistFetcher alloc] init];
    
    self.searchBar.delegate = self;
    
    if (self.isShowingFavoriteArtistDetail) {
        [self.searchBar removeFromSuperview];
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self updateViews];
}

- (IBAction)saveButtonTapped:(UIBarButtonItem *)sender
{
    if (self.artist == nil) return;
    [self.favoriteArtistsController addArtist:self.artist];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateViews
{
    if (self.artist != nil) {
        
        self.artistNameLabel.text = self.artist.name;
        self.biographyLabel.text = self.artist.biography;
        
        if (self.artist.yearFormed != 0) {
            NSString *yearFormedString = [NSString stringWithFormat:@"Formed in %d", self.artist.yearFormed];
            self.yearFormedLabel.text = yearFormedString;
        } else {
            self.yearFormedLabel.text = @"Year Formed: Unkown";
        }
    } else {
        self.artistNameLabel.text = nil;
        self.biographyLabel.text = nil;
        self.yearFormedLabel.text = nil;
    }
}

@end

/// MARK: UISearchBarDelegate Methods

@implementation ArtistDetailViewController(UISearchBarDelegate)

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchTerm = searchBar.text;
    if ((searchTerm == nil) | [searchTerm isEqualToString:@""]) return;
    
    NSLog(@"Searching for %@", searchTerm);
    
    [self.artistFetcher fetchArtistsWithName:searchTerm completionHandler:^(NSArray * _Nullable artists, NSError * _Nullable error) {
        NSLog(@"Found %ld results!", artists.count);
        
        if (artists.count > 0) {
            self.artist = artists[0];
        }
        
        [self updateViews];
    }];
}

@end
