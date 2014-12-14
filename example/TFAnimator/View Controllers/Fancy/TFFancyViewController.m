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

#import "TFFancyViewController.h"

#import "TFAnimator.h"
#import "TFFunction.h"

// ------------------ //

@interface TFFancyViewController () <UITableViewDataSource>

//UI
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *playgroundView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;

//Data
@property (strong, nonatomic) NSArray *datasource;

@end

// ------------------ //

@implementation TFFancyViewController

#pragma mark - Constructors

- (void)setupDatasource
{
    self.datasource = @[@{@"title": @"Escargot", @"selector": @"escargotAnimation"}];
}

#pragma mark - UIViewController - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Fancy animations";
    
    [self setupDatasource];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary *dict = self.datasource[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.datasource[indexPath.row];
    NSString *stringSel = dict[@"selector"];
    SEL selector = NSSelectorFromString(stringSel);
    if (selector) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:nil];
#pragma clang diagnostic pop
    }
}

#pragma mark - User Interation

- (IBAction)durationSliderValueChanged:(id)sender
{
    self.durationLabel.text = [NSString stringWithFormat:@"Duration [%.2f seconds]", self.durationSlider.value];
}

#pragma mark - Private animation

- (void)escargotAnimation
{
    double duration = self.durationSlider.value;
    
    UIView *redBox = [[UIView alloc] init];
    redBox.backgroundColor = [UIColor redColor];
    [self.playgroundView addSubview:redBox];
    
    CGPoint finalDestination = CGPointMake(CGRectGetMidX(self.playgroundView.bounds), CGRectGetMidY(self.playgroundView.bounds));
    
    int numberOfOscillation = 5; //Will give the number of half oscillations of the cosinus/sinus
    CGFloat coef = M_PI*numberOfOscillation; //Coefficient to apply to the cosinus/sinus
    [TFAnimator animateWithTimingFunction:PRTweenTimingFunctionLinear
                                 duration:duration
                                animation:^(CGFloat normalizedValue) {
                                    //n will be the parameters of the cosinus/sinus function
                                    //We apply a coef to the normalize value to ensure an exact amout of oscillation
                                    //So n will go from -pi to pi*x instead of 0 to 1
                                    CGFloat n = normalizedValue*coef;
                                    //sin will start at 0 (center) and finish at 0 (center)
                                    //applying '1-normalizedValue' ensures the oscillations will lost amplitude with time
                                    //adding finalDestination.x, so oscillations are centered on final destination
                                    CGFloat x = sin(n - M_PI) * (finalDestination.x * (1-normalizedValue)) + finalDestination.x;
                                    //cos will start at 1 (top) and finish at 0 (center)
                                    //applying '1-normalizedValue' ensures the oscillations will lost amplitude with time
                                    //adding finalDestination.y, so oscillations are centered on final destination
                                    CGFloat y = cos(n - M_PI) * (finalDestination.y * (1-normalizedValue)) + finalDestination.y;
                                    //The size is 200 at start and will reduce to reach 0 at the end of the animation
                                    CGFloat s = 200.f * (1.f-normalizedValue);
                                    //And apply all the calculated value, notice we center the view on x and y
                                    redBox.frame = CGRectMake(x - s/2.f, y - s/2.f, s, s);
                                    
                                    //Bellow, find how I debug my apps =D
                                    
                                    //Here I plot the function use to calculate the x position
                                    //UIView *xF = [[UIView alloc] initWithFrame:CGRectMake(normalizedValue*100.f, x-3, 6, 6)];
                                    //xF.backgroundColor = [UIColor purpleColor];
                                    //[self.playgroundView addSubview:xF];
                                    
                                    //Here I plot the function to calculate the y position
                                    //UIView *yF = [[UIView alloc] initWithFrame:CGRectMake(normalizedValue*100.f, y-3, 6, 6)];
                                    //yF.backgroundColor = [UIColor blueColor];
                                    //[self.playgroundView addSubview:yF];
                                    
                                    //Here I plot the trajectory of the object
                                    //UIView *t = [[UIView alloc] initWithFrame:CGRectMake(x-3, y-3, 6, 6)];
                                    //t.backgroundColor = [UIColor redColor];
                                    //[self.playgroundView addSubview:t];
                                }
                               completion:^{
                                   [redBox performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.f];
                               }];
}

@end
