//
//  DPRSearchViewController.m
//  Favorite Artists
//
//  Created by Dennis Rudolph on 1/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "DPRSearchViewController.h"
#import "DPRArtistController.h"

@interface DPRSearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
@property DPRArtist *artist;

- (IBAction)saveButton:(UIBarButtonItem *)sender;
- (void)updateViews;

@end

@implementation DPRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar setDelegate:self];
    [self updateViews];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.artistController searchArtistByName:searchBar.text completion:^(DPRArtist * artist, NSError * error) {
        if (error) {
            NSLog(@"Error searching: %@", error);
            return;
        } else if (artist) {
            self.artist = artist;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
            });
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    
}

- (void)updateViews {
    if (self.artist) {
        self.nameLabel.text = self.artist.name;
        self.yearLabel.text = [NSString stringWithFormat:@"Formed in %li", (long)self.artist.yearFormed];
        self.bioTextView.text = self.artist.bio;
    } else {
        self.nameLabel.text = @"";
        self.yearLabel.text = @"";
        self.bioTextView.text = @"";
    }
}

@end
