//
//  JACArtistViewController.m
//  Favorite Artists
//
//  Created by Jordan Christensen on 11/9/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import "JACArtistViewController.h"
#import "JACArtistController.h"
#import "JACArtist.h"

@interface JACArtistViewController ()
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearFormedLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *artistSearchBar;

@end

@implementation JACArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews {
    if (_artist) {
        self.artistSearchBar.hidden = YES;
        self.artistNameLabel.hidden = NO;
        self.yearFormedLabel.hidden = NO;
        self.descriptionLabel.hidden = NO;
        self.artistNameLabel.text = self.artist.name;
        self.yearFormedLabel.text = [NSString stringWithFormat:@"Formed %d", self.artist.yearFormed];
        self.descriptionLabel.text = self.artist.desc;
    } else {
        self.artistSearchBar.hidden = NO;
        self.artistNameLabel.hidden = YES;
        self.yearFormedLabel.hidden = YES;
        self.descriptionLabel.hidden = YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (_controller && searchBar.text) {
        [_controller fetchArtistByName:searchBar.text completion:^(JACArtist *artist, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.artist = artist;
                    self.artistNameLabel.text = artist.name;
                    self.yearFormedLabel.text = [NSString stringWithFormat:@"Formed %d", artist.yearFormed];
                    self.descriptionLabel.text = artist.desc;
                    [self updateViews];
                });
                
            }
        }];
    } else {
        NSLog(@"controller is not valid!");
    }
}

- (IBAction)saveTapped:(id)sender {
    if (self.artist) {
        [_controller addFavoriteArtist: self.artist];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
