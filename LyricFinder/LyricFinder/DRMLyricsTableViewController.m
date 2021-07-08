//
//  DRMLyricsTableViewController.m
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMLyricsTableViewController.h"
#import "DRMLyricController.h"
#import "DRMLyricSearchViewController.h"

@interface DRMLyricsTableViewController ()

@property DRMLyricController *lyricController;

@end

@implementation DRMLyricsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lyricController = [[DRMLyricController alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lyricController.lyrics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LyricCell" forIndexPath:indexPath];
    DRMLyric *lyric = [self.lyricController.lyrics objectAtIndex: indexPath.row];
    
    [cell.textLabel setText: lyric.trackName];
    [cell.detailTextLabel setText: lyric.artist];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.lyricController deleteLyricAt: indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }  
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddLyricsSegue"]) {
        DRMLyricSearchViewController *destinationVC = segue.destinationViewController;
        destinationVC.lyricController = self.lyricController;
    } else if ([segue.identifier isEqualToString:@"ShowLyricsSegue"]) {
        DRMLyricSearchViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        DRMLyric *lyric = self.lyricController.lyrics[indexPath.row];
        destinationVC.lyricController = self.lyricController;
        destinationVC.lyric = lyric;
    }
}


@end
