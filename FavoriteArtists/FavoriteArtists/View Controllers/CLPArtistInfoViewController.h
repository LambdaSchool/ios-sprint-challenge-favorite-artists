//
//  CLPArtistInfoViewController.h
//  FavoriteArtists
//
//  Created by Chad Parker on 7/31/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLPArtist;

@interface CLPArtistInfoViewController : UIViewController

@property (nonatomic) CLPArtist *artist;
@property (nonatomic) BOOL showArtistName;

@end
