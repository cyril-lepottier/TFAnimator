/*
 * Copyright (c) 2014 Cyril Le Pottier.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms are permitted
 * provided that the above copyright notice and this paragraph are
 * duplicated in all such forms and that any documentation,
 * advertising materials, and other materials related to such
 * distribution and use acknowledge that the software was developed
 * by Cyril Le Pottier. The name of the
 * Cyril Le Pottuer may not be used to endorse or promote products derived
 * from this software without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
 */

#import "TFBoxViewController.h"

#import "TFAnimator.h"
#import "TFFunction.h"
#import "TFFunctionsTableView.h"

// ------------------ //

@interface TFBoxViewController () <TFFunctionTableViewDelegate, UIGestureRecognizerDelegate>

//UI
@property (weak, nonatomic) IBOutlet TFFunctionsTableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *playgroundView;
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelB;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;

//
@property (assign, nonatomic) BOOL isGesture;
@property (assign, nonatomic) CGPoint pinchDistance;
@property (assign, nonatomic) CGPoint panLocation;

@end

// ------------------ //

@implementation TFBoxViewController

#pragma mark - UIViewController - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"UIView Frame Animation";
    self.isGesture = NO;
    
    //To prevent the view to reset their position after an animation
    self.labelA.translatesAutoresizingMaskIntoConstraints = YES;
    self.labelB.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewController - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

#pragma mark - TFFunctionsTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self animateBoxMove];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIGestureRecognizerDelegate

/**
 The user can only update the frame of one view at time
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //TODO: Add an isAnimating property to TFAnimator
    return !self.isGesture;
}

#pragma mark - User Interation

- (IBAction)durationSliderValueChanged:(id)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"Duration [%.2f seconds]", self.durationSlider.value];
}

- (IBAction)helpButtonPressed:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"" message:@"Try to pan or pinch the views A and B" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

/**
 We update the size of the view following the pinch gesture
 */
- (IBAction)pinchGestureRecognizer:(UIPinchGestureRecognizer*)recognizer
{
    UIView *pinchedView = recognizer.view;
    
    if (recognizer.numberOfTouches > 1) {
        CGPoint locationInView1 = [recognizer locationInView:self.playgroundView];
        CGPoint locationInView2 = [recognizer locationOfTouch:1 inView:self.playgroundView];
        
        CGFloat x = fabs((locationInView1.x - locationInView2.x)/10.f);
        CGFloat y = fabs((locationInView1.y - locationInView2.y)/10.f);
        
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            self.isGesture = YES;
            self.pinchDistance = CGPointMake(x, y);
            pinchedView.backgroundColor = [UIColor darkGrayColor];
        }
        else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
            self.isGesture = NO;
            self.pinchDistance = CGPointZero;
            pinchedView.backgroundColor = [UIColor whiteColor];
        }
        else {
            CGFloat width = CGRectGetWidth(pinchedView.frame) + (x - self.pinchDistance.x);
            width = fmin(fmax(100.f, width), 400.f);
            CGFloat height = CGRectGetHeight(pinchedView.frame) + (y - self.pinchDistance.y);
            height = fmin(fmax(100.f, height), 600.f);
            pinchedView.bounds = CGRectMake(.0f, .0f, width, height);
            pinchedView.frame = [self rectToKeepViewInBounds:pinchedView.frame];
        }
    }
    else {
        if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
            self.isGesture = NO;
            self.pinchDistance = CGPointZero;
            pinchedView.backgroundColor = [UIColor whiteColor];
        }
    }
}

/**
 We move the view following the pan gesture
 */
- (IBAction)panGestureRecognizer:(UIPanGestureRecognizer*)recognizer
{
    UIView *pannedView = recognizer.view;
    
    CGPoint locationInView = [recognizer locationInView:pannedView];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.isGesture = YES;
        self.panLocation = locationInView;
        pannedView.backgroundColor = [UIColor darkGrayColor];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        self.isGesture = NO;
        self.panLocation = CGPointZero;
        pannedView.backgroundColor = [UIColor whiteColor];
    }
    else {
        //Update the center of the view,
        //The distance from the center of the view to the user touch should be the same than in StateBegan
        pannedView.center = CGPointMake(pannedView.center.x + locationInView.x - self.panLocation.x,
                                        pannedView.center.y + locationInView.y - self.panLocation.y);
        CGRect newRect = [self rectToKeepViewInBounds:pannedView.frame];
        if (CGRectEqualToRect(pannedView.frame, newRect)) {
            pannedView.frame = [self rectToKeepViewInBounds:pannedView.frame];
        }
    }
}

#pragma mark - Private

- (void)animateBoxMove
{
    TFFunction *function = [self.tableView getFunctionAtSelectedIndexPath];
    double duration = self.durationSlider.value;
    
    UIView *redBox = [[UIView alloc] initWithFrame:self.labelA.frame];
    redBox.backgroundColor = [UIColor redColor];
    [self.playgroundView addSubview:redBox];
    
    CGFloat xDelta = CGRectGetMinX(self.labelB.frame) - CGRectGetMinX(self.labelA.frame);
    CGFloat yDelta = CGRectGetMinY(self.labelB.frame) - CGRectGetMinY(self.labelA.frame);
    CGFloat wDelta = CGRectGetWidth(self.labelB.frame) - CGRectGetWidth(self.labelA.frame);
    CGFloat hDelta = CGRectGetHeight(self.labelB.frame) - CGRectGetHeight(self.labelA.frame);
    CGRect originRect = self.labelA.frame;
    [TFAnimator animateWithTimingFunction:function.timingFunction
                                 duration:duration
                                animation:^(CGFloat normalizedValue) {
                                    CGFloat x = CGRectGetMinX(originRect) + xDelta*normalizedValue;
                                    CGFloat y = CGRectGetMinY(originRect) + yDelta*normalizedValue;
                                    CGFloat w = CGRectGetWidth(originRect) + wDelta*normalizedValue;
                                    CGFloat h = CGRectGetHeight(originRect) + hDelta*normalizedValue;
                                    redBox.frame = CGRectMake(x, y, w, h);
                                }
                               completion:^{
                                   [redBox performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.f];
                               }];
}

- (CGRect)rectToKeepViewInBounds:(CGRect)rect
{
    CGRect newRect = rect;
    
    CGFloat maxX = CGRectGetWidth(self.playgroundView.frame) - CGRectGetWidth(newRect);
    newRect.origin.x = fmin(fmax(.0f, CGRectGetMinX(newRect)), maxX);
    
    CGFloat maxY = CGRectGetHeight(self.playgroundView.frame) - CGRectGetHeight(newRect);
    newRect.origin.y = fmin(fmax(.0f, CGRectGetMinY(newRect)), maxY);
    
    return newRect;
}

@end
