//
//  ViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 1/7/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
/**
 Implements TableViewDataSource method. Returns the number of rows in a particular section based on the number of lessons within a specified chapter.
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 Overrides TableView method. Returns the particular cell/lesson at a particular row in a section.
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Implements TableViewDelegate method. Adds the appropriate view controller to the stack based on selection.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Pushes the appropriate view controller onto the stack.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

/**
 Autorotate is set to NO. TODO: Change later if want to support landscape.
 */
-(BOOL)shouldAutorotate;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	homeButtons = [NSArray arrayWithObjects:@"Lessons", @"Practice", @"Quicknotes", @"Stats", @"About", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [homeButtons count];
}

#pragma mark TableViewDelegate methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableID = @"HomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableID];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableID];
    }
    
    cell.textLabel.text = [homeButtons objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Lessons"]){
        [self performSegueWithIdentifier:@"chaptersViewSegue" sender:@"Lessons"];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Practice"]){
        [self performSegueWithIdentifier:@"chaptersViewSegue" sender:@"Practice"];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Quicknotes"]){
        [self performSegueWithIdentifier:@"chaptersViewSegue" sender:@"Quicknotes"];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"About"]){
        [self performSegueWithIdentifier:@"aboutSegue" sender:@"About"];
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:@"Stats"]){
        [self performSegueWithIdentifier:@"statsSegue" sender:@"Stats"];
    }
}

#pragma mark private methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"chaptersViewSegue"]) {
        ChaptersViewController *vc = [segue destinationViewController];
        [vc.navigationItem setTitle: (NSString *) sender];
    }
}

-(BOOL)shouldAutorotate{
    return false;
}

@end
