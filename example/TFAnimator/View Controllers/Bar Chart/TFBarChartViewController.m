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

#import "TFBarChartViewController.h"

#import "TFAnimator.h"
#import "TFFunction.h"
#import "TFFunctionsTableView.h"

// ------------------ //

static inline CGRect CGRectSetHFromBottom(CGRect r, CGFloat h)
{
    if (h >= 0) {
        return CGRectMake(CGRectGetMinX(r), CGRectGetMaxY(r) - h, CGRectGetWidth(r), h);
    }
    else {
        return CGRectSetHFromBottom(r, 0);
    }
    
}

// ------------------ //

@interface TFBarChartViewController () <TFFunctionTableViewDelegate>

//UI
@property (weak, nonatomic) IBOutlet TFFunctionsTableView *tableView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *barViews;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;

@end

// ------------------ //

@implementation TFBarChartViewController


#pragma mark - UIViewController - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"Example: Bar Chart Animation";
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
    [self showBarChartWithAnimation];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - User Interation

- (IBAction)durationSliderValueChanged:(id)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"Duration [%.2f seconds]", self.durationSlider.value];
}

#pragma mark - Private

- (int)getFinalValueForTag:(int)tag
{
    if (tag == 1) {
        return 470;
    }
    else if (tag == 2) {
        return 200;
    }
    else if (tag == 3) {
        return 100;
    }
    else if (tag == 4) {
        return 500;
    }
    else if (tag == 5) {
        return 422;
    }
    else if (tag == 6) {
        return 450;
    }
    else if (tag == 7) {
        return 124;
    }
    else if (tag == 8) {
        return 312;
    }
    else {
        return 0;
    }
}

- (void)setValue:(double)value toBar:(UIView*)bar andlabel:(UILabel*)label
{
    bar.frame = CGRectSetHFromBottom(bar.frame, 0);
    label.text = [NSString stringWithFormat:@"%.2f", value];
}

- (void)resestBarChart
{
    for (UIView *barView in self.barViews){
        barView.frame = CGRectSetHFromBottom(barView.frame, 0);
    }
    
    for (UILabel *label in self.labels) {
        label.text = @"0";
    }
}

- (void)showBarChartWithAnimation
{
    [self resestBarChart];
    
    TFFunction *function = [self.tableView getFunctionAtSelectedIndexPath];
    double duration = self.durationSlider.value;
    
    [TFAnimator animateWithTimingFunction:function.timingFunction
                                    duration:duration
                                   animation:^(CGFloat normalizedValue) {
                                       for (UIView *barView in self.barViews){
                                           int finalValue = [self getFinalValueForTag:barView.tag];
                                           barView.frame = CGRectSetHFromBottom(barView.frame, normalizedValue*finalValue);
                                       }
                                       
                                 for (UILabel *label in self.labels) {
                                     int finalValue = [self getFinalValueForTag:label.tag];
                                     label.text = [NSString stringWithFormat:@"%.2f", normalizedValue*finalValue];
                                 }
    }
                            completion:NULL];
}

@end
