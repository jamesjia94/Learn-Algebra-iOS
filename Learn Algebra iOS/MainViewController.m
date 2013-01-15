//
//  ViewController.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/7/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

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
-(BOOL)shouldAutorotate{
    return false;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [homeButtons count];
}
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

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"chaptersViewSegue"]) {
        
//Get destination view
        ChaptersViewController *vc = [segue destinationViewController];
//Pass the information to your destination view
        [vc.navigationTitle setTitle: (NSString *) sender];
    }
}

@end
