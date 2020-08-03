//
//  FavoriteArtistsTableViewController.m
//  FavoriteArtists
//
//  Created by Matthew Martindale on 8/2/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import "FavoriteArtistsTableViewController.h"
#import "Artist.h"
#import "ArtistController.h"
#import "SearchViewController.h"

@interface FavoriteArtistsTableViewController ()

@property ArtistController *artistController;

@end

@implementation FavoriteArtistsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.artistController = [[ArtistController alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.artistController.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteArtistCell" forIndexPath:indexPath];
    
    Artist *artist = [self.artistController.artists objectAtIndex:indexPath.row];
    cell.textLabel.text = artist.name;
    
    if (artist.yearFormed != 0) {
        NSString *yearFormed = [NSString stringWithFormat:@"Year Formed: %d", artist.yearFormed];
        cell.detailTextLabel.text = yearFormed;
    } else {
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SearchArtistSegue"]) {
        SearchViewController *searchViewControllerVC = [segue destinationViewController];
        searchViewControllerVC.artistController = self.artistController;
    } else if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SearchViewController *detailVC = [segue destinationViewController];
        detailVC.artistController = self.artistController;
        Artist *artist = [self.artistController.artists objectAtIndex:indexPath.row];
        detailVC.artist = artist;
    }
}

@end
