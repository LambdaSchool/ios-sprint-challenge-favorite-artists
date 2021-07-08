//
//  DRMLyricSearchViewController.m
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import "DRMLyricSearchViewController.h"

@interface DRMLyricSearchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIStepper *ratingStepper;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;
@property (weak, nonatomic) IBOutlet UITextField *trackTextField;
@property (weak, nonatomic) IBOutlet UITextView *lyricTextView;

- (IBAction)changeRating:(UIStepper *)sender;
- (IBAction)searchForLyrics:(id)sender;
- (IBAction)saveLyrics:(id)sender;

- (void)updateViews;
- (void)updateRatingLabel: (int)rating;

@end

@implementation DRMLyricSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
}

- (IBAction)changeRating:(UIStepper *)sender {
    [self updateRatingLabel: sender.value];
}

- (IBAction)searchForLyrics:(UIButton *)sender {
    NSString *artist = self.artistTextField.text;
    NSString *trackName = self.trackTextField.text;
    [sender setEnabled: NO];
    if (artist && ![artist isEqualToString:@""] && trackName && ![trackName isEqualToString:@""]) {
        [self.lyricController fetchLyricsForArtist:artist andTrackName:trackName withCompletion:^(NSString *lyrics) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.lyricTextView setText: lyrics];
                [sender setEnabled: YES];
            });
        }];
    }
}

- (IBAction)saveLyrics:(id)sender {
    NSString *artist = self.artistTextField.text;
    NSString *trackName = self.trackTextField.text;
    NSString *lyrics = self.lyricTextView.text;
    int rating = self.ratingStepper.value;
    
    if (self.lyric) {
        [self.lyricController updateLyric: self.lyric withRating: rating];
        [self.navigationController popViewControllerAnimated: YES];
    } else {
        if (artist && ![artist isEqualToString:@""] && trackName && ![trackName isEqualToString:@""] && lyrics && ![lyrics isEqualToString:@""]) {
            [self.lyricController createLyricWithArtist: artist trackName: trackName lyrics: lyrics andRating: rating];
            [self.navigationController popViewControllerAnimated: YES];
        }
    }
    
}

- (void)updateViews {
    if (_lyric) {
        [self setTitle: self.lyric.trackName];
        [self.artistTextField setText: self.lyric.artist];
        [self.trackTextField setText: self.lyric.trackName];
        [self.lyricTextView setText: self.lyric.lyrics];
        [self.ratingStepper setValue: self.lyric.rating];
    } else {
        [self setTitle: @"New Lyrics"];
        [self.ratingStepper setValue: 5];
    }
    
    [self updateRatingLabel: self.ratingStepper.value];
}

- (void)updateRatingLabel:(int)rating {
    [self.ratingLabel setText:[NSString stringWithFormat:@"Rating: %d", rating]];
}

@end
