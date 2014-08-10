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

@interface TFBoxViewController () <TFFunctionTableViewDelegate>

//UI
@property (weak, nonatomic) IBOutlet TFFunctionsTableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *playgroundView;
@property (weak, nonatomic) IBOutlet UILabel *labelA;
@property (weak, nonatomic) IBOutlet UILabel *labelB;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;

@end

// ------------------ //

@implementation TFBoxViewController

#pragma mark - UIViewController - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"UIView Frame Animation";
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

#pragma mark - User Interation

- (IBAction)durationSliderValueChanged:(id)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"Duration [%.2f seconds]", self.durationSlider.value];
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
    [TFAnimator animateWithTimingFunction:function.timingFunction
                                 duration:duration
                                animation:^(CGFloat normalizedValue) {
                                    CGFloat x = CGRectGetMinX(self.labelA.frame) + xDelta*normalizedValue;
                                    CGFloat y = CGRectGetMinY(self.labelA.frame) + yDelta*normalizedValue;
                                    CGFloat w = CGRectGetWidth(self.labelA.frame) + wDelta*normalizedValue;
                                    CGFloat h = CGRectGetHeight(self.labelA.frame) + hDelta*normalizedValue;
                                    redBox.frame = CGRectMake(x, y, w, h);
                                    
                                }
                               completion:^{
                                   [redBox performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.f];
                               }];
}

@end
