//
//  PLGameViewController.h
//  TapIt
//
//  Created by Gabriel Afonso on 6/3/14.
//  Copyright (c) 2014 parallel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLGameViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *beeView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)beeTapped:(id)sender;
- (IBAction)quit:(id)sender;

@end
