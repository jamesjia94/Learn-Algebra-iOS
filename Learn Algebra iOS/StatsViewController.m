//
//  StatsViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 4/4/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "StatsViewController.h"

@interface StatsViewController ()

@end

@implementation StatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemTrash target:self action:@selector(confirmClear)];
    self.navigationItem.rightBarButtonItem=clearButton;
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingString:@"Data.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *plist = (NSDictionary *)[NSPropertyListSerialization
                                           propertyListFromData:plistXML
                                           mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                           format:&format
                                           errorDescription:&errorDesc];
    if (!plist) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    else{
        _chapters = [plist objectForKey:@"Chapters"];
    }
}

-(void)confirmClear
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to reset the statistics?  This action cannot be undone" delegate:self cancelButtonTitle:@"Reset" otherButtonTitles:@"Cancel", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self clearStats];
    }
}

#pragma mark private methods
-(void)clearStats
{
    for (NSDictionary* chapter in _chapters){
        for (NSMutableArray *chapterStat in [chapter allValues]){
            [chapterStat replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:0]];
            [chapterStat replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:0]];
        }
    }
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingString:@"Data.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    NSDictionary* plist = [NSDictionary dictionaryWithObject:_chapters forKey:@"Chapters"];
    NSString *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plist format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    
    if (plistData){
        [plistData writeToFile:plistPath atomically:YES];
        [self.tableView reloadData];
    }
    else{
        NSLog(@"%@",error);
    }
}

#pragma mark UITableViewDelegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_chapters count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"Num rows per section %d: %d",section,[[_chapters objectAtIndex:section]count]);
    return [[_chapters objectAtIndex:section] count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    if (indexPath.section == 0)
    {
        NSArray *totalStat = [((NSDictionary *)[_chapters objectAtIndex:indexPath.section]) objectForKey:[NSString stringWithFormat:@"0.0"]];
        if([[totalStat objectAtIndex:1] integerValue] != 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%d%%", [[totalStat objectAtIndex:0] integerValue]*100/[[totalStat objectAtIndex:1] integerValue]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ / %@",[totalStat objectAtIndex:0],[totalStat objectAtIndex:1]];
        }
        else
        {
            cell.textLabel.text = [NSString stringWithFormat:@"No Data"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"--"];
        }
    }
    else
    {
        NSArray *chapterStat = [((NSDictionary *)[_chapters objectAtIndex:indexPath.section]) objectForKey:[NSString stringWithFormat:@"%d.%d",indexPath.section,indexPath.row+1]];
        cell.textLabel.text = [NSString stringWithFormat:@"%d.%d %@: ",indexPath.section,indexPath.row+1,[chapterStat objectAtIndex:2]];
        if([[chapterStat objectAtIndex:1] integerValue] != 0)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ / %@",[chapterStat objectAtIndex:0],[chapterStat objectAtIndex:1]];
        }
        else
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"--"];
        }
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0)
    {
        return [NSString stringWithFormat:@"Total"];
    }
    else
    {
        return [NSString stringWithFormat:@"Chapter %d: %@",section, [((NSDictionary *)[_chapters objectAtIndex:section]) objectForKey:[NSString stringWithFormat:@"name"]]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
