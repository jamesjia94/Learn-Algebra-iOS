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
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemTrash target:self action:@selector(clearStats)];
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
    return [[_chapters objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *chapterStat = [((NSDictionary *)[_chapters objectAtIndex:indexPath.section]) objectForKey:[NSString stringWithFormat:@"%d.%d",indexPath.section+1,indexPath.row+1]];
    cell.textLabel.text = [NSString stringWithFormat:@"Lesson %d: %@ correct out of %@",indexPath.row+1,[chapterStat objectAtIndex:0],[chapterStat objectAtIndex:1]];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Chapter %d",section+1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
