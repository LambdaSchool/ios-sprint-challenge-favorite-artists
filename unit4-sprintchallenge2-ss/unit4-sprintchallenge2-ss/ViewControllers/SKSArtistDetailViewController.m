//
//  SKSArtistDetailViewController.m
//  unit4-sprintchallenge2-ss
//
//  Created by Lambda_School_Loaner_204 on 1/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SKSArtistDetailViewController.h"
#import "SKSArtist.h"
#import "SKSArtistController.h"

@interface SKSArtistDetailViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *formedYearLabel;
@property (weak, nonatomic) IBOutlet UITextView *biographyTextView;

- (void)updateViews;

@end

@implementation SKSArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
    [self.searchBar setDelegate:self];
}

- (void)updateViews {
    if (self.artist) {
        self.title = self.artist.name;
        self.nameLabel.text = self.artist.name;
        self.formedYearLabel.text = [self.artist formedYearString];
        self.biographyTextView.text = self.artist.biography;
    } else {
        self.nameLabel.text = @"";
        self.formedYearLabel.text = @"";
        self.biographyTextView.text = @"";
    }
}

- (IBAction)saveButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}


#pragma mark UISearchBarDelegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [self.artistController searchForArtistsByName:searchBar.text completion:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Error: %@", error);
                return;
            }
            [self updateViews];
        });

    }];
}

@end
