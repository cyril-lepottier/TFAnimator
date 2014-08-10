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

#import "TFColorViewController.h"

#import "TFAnimator.h"
#import "TFFunction.h"
#import "TFFunctionsTableView.h"

// ------------------ //

@interface TFColorViewController () <TFFunctionTableViewDelegate>

//UI
@property (weak, nonatomic) IBOutlet TFFunctionsTableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *colorBox1;
@property (weak, nonatomic) IBOutlet UILabel *redLabel1;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel1;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel1;
@property (weak, nonatomic) IBOutlet UISlider *redSlider1;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider1;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider1;
@property (weak, nonatomic) IBOutlet UIView *colorBox2;
@property (weak, nonatomic) IBOutlet UILabel *redLabel2;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel2;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel2;
@property (weak, nonatomic) IBOutlet UISlider *redSlider2;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider2;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider2;
@property (weak, nonatomic) IBOutlet UIView *animatedBox;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;

@end

// ------------------ //

@implementation TFColorViewController

#pragma mark - UIViewController - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"UIColor Animation";
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
    [self animateColorChange];
}

#pragma mark - User Interation

- (IBAction)slider1ValueChanged:(UISlider*)sender
{
    if (sender == self.redSlider1) {
        self.redLabel1.text = [NSString stringWithFormat:@"Red [%.0f]", sender.value];
    }
    else if (sender == self.greenSlider1) {
        self.greenLabel1.text = [NSString stringWithFormat:@"Green [%.0f]", sender.value];
    }
    else if (sender == self.blueSlider1) {
        self.blueLabel1.text = [NSString stringWithFormat:@"Blue [%.0f]", sender.value];
    }
    
    self.colorBox1.backgroundColor = [UIColor colorWithRed:self.redSlider1.value/255.f
                                                     green:self.greenSlider1.value/255.f
                                                      blue:self.blueSlider1.value/255.f
                                                     alpha:1.f];
}

- (IBAction)slider2ValueChanged:(UISlider*)sender
{
    if (sender == self.redSlider2) {
        self.redLabel2.text = [NSString stringWithFormat:@"Red [%.0f]", sender.value];
    }
    else if (sender == self.greenSlider2) {
        self.greenLabel2.text = [NSString stringWithFormat:@"Green [%.0f]", sender.value];
    }
    else if (sender == self.blueSlider2) {
        self.blueLabel2.text = [NSString stringWithFormat:@"Blue [%.0f]", sender.value];
    }
    
    self.colorBox2.backgroundColor = [UIColor colorWithRed:self.redSlider2.value/255.f
                                                     green:self.greenSlider2.value/255.f
                                                      blue:self.blueSlider2.value/255.f
                                                     alpha:1.f];
}

- (IBAction)durationSliderValueChanged:(id)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"Duration [%.2f seconds]", self.durationSlider.value];
}

#pragma mark - Private

- (void)animateColorChange
{
    TFFunction *function = [self.tableView getFunctionAtSelectedIndexPath];
    double duration = self.durationSlider.value;
    
    CGFloat r = self.redSlider1.value;
    CGFloat g = self.greenSlider1.value;
    CGFloat b = self.blueSlider1.value;
    CGFloat rDelta = (self.redSlider2.value - self.redSlider1.value)/255.f;
    CGFloat gDelta = (self.greenSlider2.value - self.greenSlider1.value)/255.f;
    CGFloat bDelta = (self.blueSlider2.value - self.blueSlider1.value)/255.f;

    [TFAnimator animateWithTimingFunction:function.timingFunction
                                 duration:duration
                                animation:^(CGFloat normalizedValue) {
                                    CGFloat newR = fmin(fmax(r+rDelta*normalizedValue, 0), 1);
                                    CGFloat newG = fmin(fmax(g+gDelta*normalizedValue, 0), 1);
                                    CGFloat newB = fmin(fmax(b+bDelta*normalizedValue, 0), 1);
                                    self.animatedBox.backgroundColor = [UIColor colorWithRed:newR
                                                                                       green:newG
                                                                                        blue:newB
                                                                                       alpha:1.0f];
                                }
                               completion:^{}];
}

@end
