//
//  GIPSearchViewController.h
//  Favorite-Artists
//
//  Created by Gi Pyo Kim on 12/13/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GIPArtistController;

@interface GIPSearchViewController : UIViewController <UISearchBarDelegate>

@property GIPArtistController *controller;

@end
