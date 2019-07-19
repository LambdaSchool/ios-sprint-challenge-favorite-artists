//
//  HSVArtistDetailViewController.h
//  Artists
//
//  Created by Hector Steven on 7/19/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVArtistDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *serchBar;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *formedDateLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

NS_ASSUME_NONNULL_END
