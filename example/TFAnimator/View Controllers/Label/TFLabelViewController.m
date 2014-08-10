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

#import "TFLabelViewController.h"

#import "TFAnimator.h"
#import "TFFunction.h"
#import "TFFunctionsTableView.h"

// ------------------ //

@interface TFLabelViewController () <TFFunctionTableViewDelegate>

//UI
@property (weak, nonatomic) IBOutlet TFFunctionsTableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UISlider *fromSlider;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UISlider *toSlider;
@property (weak, nonatomic) IBOutlet UILabel *animatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;

@end

// ------------------ //

@implementation TFLabelViewController

#pragma mark - UIViewController - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"UILabel Text Animation";
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
    [self animateLabelTextChange];
}

#pragma mark - User Interation

- (IBAction)fromSliderValueChanged:(id)sender
{
    self.fromLabel.text = [self stringFormatedOfValue:self.fromSlider.value];
}

- (IBAction)toSliderValueChanged:(id)sender
{
    self.toLabel.text = [self stringFormatedOfValue:self.toSlider.value];
}

- (IBAction)durationSliderValueChanged:(id)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"Duration [%.2f seconds]", self.durationSlider.value];
}

#pragma mark - Private

- (void)animateLabelTextChange
{
    TFFunction *function = [self.tableView getFunctionAtSelectedIndexPath];
    double duration = self.durationSlider.value;
    
    double start = self.fromSlider.value;
    double delta = self.toSlider.value - self.fromSlider.value;
    
    [TFAnimator animateWithTimingFunction:function.timingFunction
                                 duration:duration
                                animation:^(CGFloat normalizedValue) {
                                    double newValue = start + delta*normalizedValue;
                                    self.animatedLabel.text = [self stringFormatedOfValue:newValue];
                                }
                               completion:^{}];
}

- (NSString*)stringFormatedOfValue:(double)value
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMinimumFractionDigits:2];
    [formatter setMaximumFractionDigits:2];
    
    return [formatter stringFromNumber:@(value)];
}

@end
