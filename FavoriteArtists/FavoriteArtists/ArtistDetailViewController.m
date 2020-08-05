//
//  ArtistDetailViewController.m
//  FavoriteArtists
//
//  Created by Sean Acres on 8/2/20.
//  Copyright © 2020 Sean Acres. All rights reserved.
//

#import "ArtistDetailViewController.h"

@interface ArtistDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistFormationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistBiographyLabel;

@end

@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.artistNameLabel.text = self.favoriteArtist.artistName;
    self.artistBiographyLabel.text = self.favoriteArtist.biography;
    self.artistFormationDateLabel.text = [NSString stringWithFormat:@"%.0f", self.favoriteArtist.formationDate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
