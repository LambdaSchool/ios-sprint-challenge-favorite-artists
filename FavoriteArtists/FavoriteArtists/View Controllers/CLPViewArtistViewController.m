//
//  CLPViewArtistViewController.m
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "CLPViewArtistViewController.h"
#import "CLPArtistInfoViewController.h"

@implementation CLPViewArtistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.title = self.artist.name;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CLPArtistInfoViewController *infoVC = segue.destinationViewController;
    infoVC.artist = self.artist;
    infoVC.showArtistName = NO;
}

@end
