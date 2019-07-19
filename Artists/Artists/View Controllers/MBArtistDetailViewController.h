//
//  MBArtistDetailViewController.h
//  Artists
//
//  Created by Mitchell Budge on 7/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBArtist.h"
#import "MBArtistController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBArtistDetailViewController : UIViewController <UISearchBarDelegate>

@property MBArtist *artist;
@property MBArtistController *artistController;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;

- (IBAction)saveButtonPressed:(id)sender;

@end

NS_ASSUME_NONNULL_END
