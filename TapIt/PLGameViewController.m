//
//  PLGameViewController.m
//  TapIt
//
//  Created by Gabriel Afonso on 6/3/14.
//  Copyright (c) 2014 parallel. All rights reserved.
//

#import "PLGameViewController.h"
#import "PLConnection.h"

@interface PLGameViewController ()

@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger seconds;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger position;
@property BOOL stopped;

@end

@implementation PLGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupGame
{
    self.stopped = NO;
    self.seconds = 20;
    self.count = 0;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%li", (long)self.seconds];
    self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.count];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(subtractTime) userInfo:nil repeats:YES];
    [self animateBee];
}

- (void)subtractTime
{
    self.seconds--;
    self.timeLabel.text = [NSString stringWithFormat:@"%li", (long)self.seconds];
    
    if (self.seconds == 0) {
        self.stopped = YES;
        [self.timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Time is up!"
                                                        message:[NSString stringWithFormat:@"You scored %li points. Enter your name", (long)self.count]
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Send and Play",nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}

//Animation

- (void)animateBee
{
    self.position = 1;
    [self moveBeeTo:self.position];
}

- (void)moveBeeTo:(NSInteger)position
{
    CGPoint center = CGPointMake(50, 300);
    switch (position) {
        case 1:
            center = CGPointMake(50, 300);
            break;
        case 2:
            center = CGPointMake(200, 700);
            break;
        case 3:
            center = CGPointMake(600, 100);
            break;
            
        case 4:
            center = CGPointMake(600, 700);
            break;

        default:
            NSLog(@"position");
            self.position = 1;
            break;
    }
    if (self.stopped) return;
    
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.beeView.center = center;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:0.2
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.beeView.center = center;
                                              
                                          } completion:nil];
                     }];
    
}

//Animation end

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    CGRect beeRect = [[[self.beeView layer] presentationLayer] frame];
    
    if (CGRectContainsPoint(beeRect, touchLocation)) {
        NSLog(@"Bee tapped!");
        [self beeTapped:nil];
        self.position ++;
        [self moveBeeTo:self.position];
    } else {
        NSLog(@"Bee not tapped.");
        return;
    }
}

- (IBAction)beeTapped:(id)sender
{
    NSLog(@"OUCH");
    self.count += 10;
    self.scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.count];
}

- (IBAction)quit:(id)sender
{
    self.stopped = YES;
    [self.timer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *nameTextField = [alertView textFieldAtIndex:0];
        if (!nameTextField.text || [@"" isEqualToString:nameTextField.text]) {
            nameTextField.text = @"anonimo";
        }
        PLConnection* connection = [[PLConnection alloc] init];
        [connection sendScore:self.scoreLabel.text.integerValue forUser:nameTextField.text];
        [self setupGame];
    } else {
        [self quit:nil];
    }
}

@end
