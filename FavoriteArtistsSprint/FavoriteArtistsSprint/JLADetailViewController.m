//
//  JLADetailViewController.m
//  FavoriteArtistsSprint
//
//  Created by Jorge Alvarez on 3/20/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLADetailViewController.h"
#import "JLAFavoriteArtistController.h"
#import "JLAFavoriteArtist.h"

@interface JLADetailViewController () <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearFormedLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JLADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    [self updateViews];
}

- (IBAction)saveTapped:(UIBarButtonItem *)sender {
    NSLog(@"Save Tapped");
    
    if (!_favoriteArtist) { return; }
    
    [self.favoriteArtistController addArtistWithArtist:_favoriteArtist.strArtist year:_favoriteArtist.intFormedYear bio:_favoriteArtist.strBiographyEN];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //Do search logic here
    NSString *searchTerm = searchBar.text;
    NSLog(@"searchTerm%@", searchTerm);
    [self.favoriteArtistController fetchFavoriteArtistByName:searchTerm completion:^(JLAFavoriteArtist *favoriteArtist, NSError *error) {
        
        // hey
        if (error) {
            NSLog(@"Error fetching artist");
            return;
        }
        
        // missing property year
        if (!favoriteArtist) {
            NSLog(@"nice try, John Williams");
            return;
        }
        
       dispatch_async(dispatch_get_main_queue(), ^{
           NSLog(@"search result = %@", favoriteArtist);
           
           if (!favoriteArtist.strArtist || !favoriteArtist.intFormedYear || !favoriteArtist.strBiographyEN) {
               NSLog(@"empty prop");
               return;
           }
           self.favoriteArtist = favoriteArtist;
           [self updateViews];
//           self.title = favoriteArtist.strArtist;
//           self.artistNameLabel.text = favoriteArtist.strArtist;
//           self.yearFormedLabel.text = [NSString stringWithFormat:@"%i", favoriteArtist.intFormedYear];
//           self.textView.text = favoriteArtist.strBiographyEN;
           
//           [self.favoriteArtistController addArtistWithArtist:favoriteArtist.strArtist
//                                                         year:favoriteArtist.intFormedYear
//                                                          bio:favoriteArtist.strBiographyEN];
        });
    }];

}

// didSet
- (void)setFavoriteArtist:(JLAFavoriteArtist *)favoriteArtist {
    NSLog(@"favoriteArtist SET");
    _favoriteArtist = favoriteArtist;
    NSLog(@"%@", _favoriteArtist.strArtist);
    [self updateViews];
}

- (void)updateViews {
    NSLog(@"updateViews");
    
    if (!self.viewIfLoaded) { return; }
    
    // view
    if (self.favoriteArtist) {
        NSLog(@"VIEW MODE");
        self.title = self.favoriteArtist.strArtist;
        self.artistNameLabel.text = self.favoriteArtist.strArtist;
        self.yearFormedLabel.text = [NSString stringWithFormat:@"%i", self.favoriteArtist.intFormedYear];
        self.textView.text = self.favoriteArtist.strBiographyEN;
    }
    
    // add
    else {
        NSLog(@"ADD MODE");
        self.title = self.favoriteArtist.strArtist;
        self.artistNameLabel.text = self.favoriteArtist.strArtist;
        self.yearFormedLabel.text = [NSString stringWithFormat:@"%i", self.favoriteArtist.intFormedYear];
        self.textView.text = self.favoriteArtist.strBiographyEN;
    }
}

@end
