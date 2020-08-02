//
//  CLPFavoriteArtistsTableViewController.m
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "CLPFavoriteArtistsTableViewController.h"
#import "CLPArtistController.h"
#import "CLPArtist.h"
#import "CLPAddNewArtistViewController.h"
#import "CLPViewArtistViewController.h"

@interface CLPFavoriteArtistsTableViewController ()

@property (nonatomic) CLPArtistController *artistController;

@end

@implementation CLPFavoriteArtistsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.artistController = [[CLPArtistController alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.artistController artistCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteArtistCell" forIndexPath:indexPath];
    
    CLPArtist *artist = [self.artistController artistAtIndex:(int)indexPath.row];
    cell.textLabel.text = artist.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Formed in %d", artist.yearFormed];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.artistController deleteArtistAtIndex:(int)indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewArtistSegue"]) {

        CLPAddNewArtistViewController *addVC = segue.destinationViewController;
        addVC.artistController = self.artistController;

    } else if ([segue.identifier isEqualToString:@"ViewArtistSegue"]) {
        
        CLPViewArtistViewController *viewVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        viewVC.artist = [self.artistController artistAtIndex:(int)indexPath.row];
    }
}

@end
