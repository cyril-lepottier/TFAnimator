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

#import "TFHomeViewController.h"

#import "TFDrawFunctionsViewController.h"
#import "TFBarChartViewController.h"
#import "TFBoxViewController.h"

// ------------------ //

@implementation TFHomeViewController

#pragma mark - UIViewController - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Home";
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }
    else {
        cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Plot Timing Functions";
    }
    else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Animate Frame";
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"Animate Color";
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"Animate Label Text";
        }
        else if (indexPath.row == 3) {
            cell.textLabel.text = @"Animate Bar Chart";
        }
        else if (indexPath.row == 4) {
            cell.textLabel.text = @"Fancy animations";
        }
        else {
            cell.textLabel.text = @"***";
        }
    }
    
    return cell;
}

#pragma mark - UITableviewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *segueID;
    if (indexPath.section == 0) {
        segueID = @"DrawFunctionSegue";
    }
    else {
        if (indexPath.row == 0) {
            segueID = @"BoxSegue";
        }
        else if (indexPath.row == 1) {
            segueID = @"ColorSegue";
        }
        else if (indexPath.row == 2) {
            segueID = @"LabelSegue";
        }
        else if (indexPath.row == 3) {
            segueID = @"BarChartSegue";
        }
        else if (indexPath.row == 4) {
            segueID = @"FancySegue";
        }
        else {
            return;
        }
    }
    
    [self performSegueWithIdentifier:segueID sender:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *header = [[UILabel alloc] init];
    header.backgroundColor = [UIColor darkGrayColor];
    header.textColor = [UIColor whiteColor];
    header.font = [UIFont systemFontOfSize:20.f];
    if (section == 0) {
        header.text = @"PRTween Timing Functions";
    }
    else {
        header.text = @"TFAnimator Examples";
    }
    return header;
}

@end
