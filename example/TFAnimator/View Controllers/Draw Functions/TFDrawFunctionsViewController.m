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

#import "TFDrawFunctionsViewController.h"

#import "TFAnimator.h"
#import "UIColor+RandomColor.h"
#import "TFFunction.h"

// ------------------ //

@interface TFFunction2 : TFFunction
@property (nonatomic) UIColor *color;
@end

@implementation TFFunction2
@end

// ------------------ //

@interface TFCell : UITableViewCell
@property (strong, nonatomic) TFFunction2 *function;
@end

@implementation TFCell

- (void)setFunction:(TFFunction2 *)function{
    _function = function;
    self.textLabel.text = function.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.function.color = [UIColor randomColor];
        self.textLabel.textColor = self.function.color;
    }
    else {
        self.function.color = nil;
        self.textLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    }
}

@end

// ------------------ //

@interface TFDrawFunctionsViewController () <UITableViewDataSource, UITableViewDelegate>

//UI
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *drawingView;

//Data
@property (strong, nonatomic) NSArray *datasource;
@end

// ------------------ //

@implementation TFDrawFunctionsViewController

#pragma mark - Constructors 

- (void)setUpDataSource
{
    TFFunction2 *f1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionLinear title:@"Linear"];
    NSArray *g1 = @[f1];
    
    TFFunction2 *f2_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionBackIn title:@"Back In"];
    TFFunction2 *f2_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionBackOut title:@"Back Out"];
    TFFunction2 *f2_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionBackInOut title:@"Back InOut"];
    NSArray *g2 = @[f2_1, f2_2, f2_3];
    
    TFFunction2 *f3_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionBounceIn title:@"Bounce In"];
    TFFunction2 *f3_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionBounceOut title:@"Bounce Out"];
    TFFunction2 *f3_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionBounceInOut title:@"Bounce InOut"];
    NSArray *g3 = @[f3_1, f3_2, f3_3];
    
    TFFunction2 *f4_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionCircIn title:@"Circ In"];
    TFFunction2 *f4_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionCircOut title:@"Circ Out"];
    TFFunction2 *f4_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionCircInOut title:@"Circ InOut"];
    NSArray *g4 = @[f4_1, f4_2, f4_3];
    
    TFFunction2 *f5_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionCubicIn title:@"Cubic In"];
    TFFunction2 *f5_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionCubicOut title:@"Cubic Out"];
    TFFunction2 *f5_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionCubicInOut title:@"Cubic InOut"];
    NSArray *g5 = @[f5_1, f5_2, f5_3];
    
    TFFunction2 *f6_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionElasticIn title:@"Elastic In"];
    TFFunction2 *f6_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionElasticOut title:@"Elastic Out"];
    TFFunction2 *f6_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionElasticInOut title:@"Elastic InOut"];
    NSArray *g6 = @[f6_1, f6_2, f6_3];
    
    TFFunction2 *f7_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionExpoIn title:@"Expo In"];
    TFFunction2 *f7_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionExpoOut title:@"Expo Out"];
    TFFunction2 *f7_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionExpoInOut title:@"Expo InOut"];
    NSArray *g7 = @[f7_1, f7_2, f7_3];
    
    TFFunction2 *f8_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuadIn title:@"Quad In"];
    TFFunction2 *f8_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuadOut title:@"Quad Out"];
    TFFunction2 *f8_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuadInOut title:@"Quad InOut"];
    NSArray *g8 = @[f8_1, f8_2, f8_3];
    
    TFFunction2 *f9_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuartIn title:@"Quart In"];
    TFFunction2 *f9_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuartOut title:@"Quart Out"];
    TFFunction2 *f9_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuartInOut title:@"Quart InOut"];
    NSArray *g9 = @[f9_1, f9_2, f9_3];
    
    TFFunction2 *f10_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuintIn title:@"Quint In"];
    TFFunction2 *f10_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuintOut title:@"Quint Out"];
    TFFunction2 *f10_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionQuintInOut title:@"Quint InOut"];
    NSArray *g10 = @[f10_1, f10_2, f10_3];
    
    TFFunction2 *f11_1 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionSineIn title:@"Sine In"];
    TFFunction2 *f11_2 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionSineInOut title:@"Sine Out"];
    TFFunction2 *f11_3 = [[TFFunction2 alloc] initWithFunction:PRTweenTimingFunctionSineInOut title:@"Sine InOut"];
    NSArray *g11 = @[f11_1, f11_2, f11_3];
    
    self.datasource = @[g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11];
}

#pragma mark - UIViewController - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"PRTween Timing Functions Ploting";
    [self setUpDataSource];
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
    return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.datasource[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = NSStringFromClass([self class]);
    TFCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.function = [self getFunctionAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self redrawFunctions];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self redrawFunctions];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

#pragma mark - User Interaction

- (IBAction)helpButtonPressed:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"" message:@"Horinzontal axis: Time\nVertical axis: Position, normalized value" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}


#pragma mark - Private

- (TFFunction2*)getFunctionAtIndexPath:(NSIndexPath*)indexPath
{
    @try {
        return (TFFunction2*)self.datasource[indexPath.section][indexPath.row];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
}

- (void)cleanDrawingView
{
    while (self.drawingView.subviews.count > 0) {
        [[self.drawingView.subviews lastObject] removeFromSuperview];
    }
}

- (void)drawFunction:(TFFunction2*)function
{
    for (int x = 0; x<CGRectGetWidth(self.drawingView.bounds); x+=3) {
        int y = CGRectGetHeight(self.drawingView.bounds) - function.timingFunction(x, 0, CGRectGetHeight(self.drawingView.bounds), CGRectGetWidth(self.drawingView.bounds));
        [self drawPoint:CGPointMake(x, y) withColor:function.color];
    }
}

- (void)redrawFunctions
{
    [self cleanDrawingView];
    
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in selectedRows)
    {
        TFFunction2 *function = [self getFunctionAtIndexPath:indexPath];
        [self drawFunction:function];
    }
}

- (void)drawPoint:(CGPoint)point withColor:(UIColor*)color
{
    UIView *v = [[UIView alloc] initWithFrame: CGRectMake(point.x-1.f, point.y-1.f, 3.f, 3.f)];
    v.backgroundColor = color;
    [self.drawingView addSubview:v];
}

@end
