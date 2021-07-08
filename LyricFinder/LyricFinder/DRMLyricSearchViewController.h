//
//  DRMLyricSearchViewController.h
//  LyricFinder
//
//  Created by Dillon McElhinney on 3/1/19.
//  Copyright © 2019 Dillon McElhinney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRMLyricController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DRMLyricSearchViewController : UIViewController

@property DRMLyricController *lyricController;

@property DRMLyric *lyric;

@end

NS_ASSUME_NONNULL_END
