//
//  MJPArtistsTableViewController.h
//  Artists
//
//  Created by Mark Poggi on 6/12/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJPArtist.h"
#import "MJPArtistController.h"
#import "MJPArtistsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJPArtistsTableViewController : UITableViewController

@property MJPArtistController *artistController;

@end

NS_ASSUME_NONNULL_END
