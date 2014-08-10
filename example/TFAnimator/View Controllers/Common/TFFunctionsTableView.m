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

#import "TFFunctionsTableView.h"

#import "TFFunction.h"

// ------------------ //

@interface TFFunctionsTableView () <UITableViewDataSource, UITableViewDelegate>

//Data
@property (strong, nonatomic) NSArray *datasource;

@end

// ------------------ //
@implementation TFFunctionsTableView

#pragma mark - Constructors

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setUpDataSource];
    self.delegate = self;
    self.dataSource = self;
}

- (void)setUpDataSource
{
    TFFunction *f1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionLinear title:@"Linear"];
    NSArray *g1 = @[f1];
    
    TFFunction *f2_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionBackIn title:@"Back In"];
    TFFunction *f2_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionBackOut title:@"Back Out"];
    TFFunction *f2_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionBackInOut title:@"Back InOut"];
    NSArray *g2 = @[f2_1, f2_2, f2_3];
    
    TFFunction *f3_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionBounceIn title:@"Bounce In"];
    TFFunction *f3_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionBounceOut title:@"Bounce Out"];
    TFFunction *f3_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionBounceInOut title:@"Bounce InOut"];
    NSArray *g3 = @[f3_1, f3_2, f3_3];
    
    TFFunction *f4_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionCircIn title:@"Circ In"];
    TFFunction *f4_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionCircOut title:@"Circ Out"];
    TFFunction *f4_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionCircInOut title:@"Circ InOut"];
    NSArray *g4 = @[f4_1, f4_2, f4_3];
    
    TFFunction *f5_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionCubicIn title:@"Cubic In"];
    TFFunction *f5_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionCubicOut title:@"Cubic Out"];
    TFFunction *f5_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionCubicInOut title:@"Cubic InOut"];
    NSArray *g5 = @[f5_1, f5_2, f5_3];
    
    TFFunction *f6_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionElasticIn title:@"Elastic In"];
    TFFunction *f6_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionElasticOut title:@"Elastic Out"];
    TFFunction *f6_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionElasticInOut title:@"Elastic InOut"];
    NSArray *g6 = @[f6_1, f6_2, f6_3];
    
    TFFunction *f7_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionExpoIn title:@"Expo In"];
    TFFunction *f7_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionExpoOut title:@"Expo Out"];
    TFFunction *f7_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionExpoInOut title:@"Expo InOut"];
    NSArray *g7 = @[f7_1, f7_2, f7_3];
    
    TFFunction *f8_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuadIn title:@"Quad In"];
    TFFunction *f8_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuadOut title:@"Quad Out"];
    TFFunction *f8_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuadInOut title:@"Quad InOut"];
    NSArray *g8 = @[f8_1, f8_2, f8_3];
    
    TFFunction *f9_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuartIn title:@"Quart In"];
    TFFunction *f9_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuartOut title:@"Quart Out"];
    TFFunction *f9_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuartInOut title:@"Quart InOut"];
    NSArray *g9 = @[f9_1, f9_2, f9_3];
    
    TFFunction *f10_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuintIn title:@"Quint In"];
    TFFunction *f10_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuintOut title:@"Quint Out"];
    TFFunction *f10_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionQuintInOut title:@"Quint InOut"];
    NSArray *g10 = @[f10_1, f10_2, f10_3];
    
    TFFunction *f11_1 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionSineIn title:@"Sine In"];
    TFFunction *f11_2 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionSineInOut title:@"Sine Out"];
    TFFunction *f11_3 = [[TFFunction alloc] initWithFunction:PRTweenTimingFunctionSineInOut title:@"Sine InOut"];
    NSArray *g11 = @[f11_1, f11_2, f11_3];
    
    self.datasource = @[g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    TFFunction *function = [self getFunctionAtIndexPath:indexPath];
    cell.textLabel.text = function.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tfDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Public

- (TFFunction*)getFunctionAtIndexPath:(NSIndexPath*)indexPath
{
    @try {
        return (TFFunction*)self.datasource[indexPath.section][indexPath.row];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
}

- (TFFunction*)getFunctionAtSelectedIndexPath
{
    return [self getFunctionAtIndexPath:[self indexPathForSelectedRow]];
}

@end
