//
//  CLPArtistInfoViewController.m
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "CLPArtistInfoViewController.h"
#import "CLPArtist.h"

@interface CLPArtistInfoViewController ()

@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearFormedLabel;
@property (strong, nonatomic) IBOutlet UITextView *biographyTextView;

@end

@implementation CLPArtistInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.artistNameLabel.text = @"";
    self.yearFormedLabel.text = @"";
    self.biographyTextView.text = @"";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateViews];
}

- (void)setArtist:(CLPArtist *)artist
{
    _artist = artist;
    [self updateViews];
}

- (void)updateViews
{
    if (self.artist) {
        if (self.showArtistName) {
            self.artistNameLabel.hidden = NO;
        } else {
            self.artistNameLabel.hidden = YES;
        }
        self.artistNameLabel.text = self.artist.name;
        self.yearFormedLabel.text = [NSString stringWithFormat:@"Formed in %d", self.artist.yearFormed];
        self.biographyTextView.text = self.artist.biography;
    }
}

@end
