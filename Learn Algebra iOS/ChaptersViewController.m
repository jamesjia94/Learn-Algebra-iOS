//
//  ChaptersViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 1/11/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "ChaptersViewController.h"

@interface ChaptersViewController ()
/**
 Implements TableViewDataSource method. Returns the number of sections in the tableView based on the number of chapters - [dataModel count].
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

/**
 Implements TableViewDataSource method. Returns the number of rows in a particular section based on the number of lessons within a specified chapter.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 Implements TableViewDelegate method. Adds the appropriate view controller to the stack based on selection.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Overrides TableView method. Returns the particular cell/lesson at a particular row in a section.
 */
- (UITableViewCell *)tableView:(ExpandableTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Implements ExpandableTableViewDataSource method. If the header is Quicknotes, there is only one group cell named Chapters. Otherwise, name the group cells by its corresponding chapter title.
 */
- (UITableViewCell *)tableView:(ExpandableTableView *)tableView cellForGroupInSection:(NSUInteger)section;

/**
 Implements ExpandableTableViewDelegate method. Creates an animation to "expand" the cells.
 */
- (void)tableView:(ExpandableTableView *)tableView willExpandSection:(NSUInteger)section;

/**
 Implements ExpandableTableViewDelegate method. Creates an animation to "contract" the cells.
 */
- (void)tableView:(ExpandableTableView *)tableView willContractSection:(NSUInteger)section;


/**
 Pushes the appropriate view controller onto the stack.
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end

@implementation ChaptersViewController
@synthesize dataModel = _dataModel;
@synthesize chapterTitles = _chapterTitles;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, format);
    }
    else{
        
        NSMutableArray *allchaps = [plist objectForKey:@"Chapters"];
        _dataModel = [NSMutableArray arrayWithCapacity:0];
        _chapterTitles = [NSMutableArray arrayWithCapacity:0];
        
        if ([self.navigationItem.title isEqualToString:@"Quicknotes"]){
            [_dataModel addObject:[NSMutableArray arrayWithCapacity:0]];
            for (int i = 1; i  < allchaps.count; i++)
            {
                [_chapterTitles addObject:[NSString stringWithFormat:@"Ch. %d: %@", i, [allchaps[i] objectForKey:@"name"]]];
                [_dataModel[0] addObject:[NSString stringWithFormat:@"%d.0", i]];
            }
        }
        else{
            for (int i = 1; i  < allchaps.count; i++) {
                [_chapterTitles addObject:[NSString stringWithFormat:@"Ch. %d: %@", i, [allchaps[i] objectForKey:@"name"]]];
                NSDictionary *chap = allchaps[i];
                NSMutableArray *lessons = [NSMutableArray arrayWithCapacity:0];
                for(int j = 1; j  <= [chap count] - 1; j++)
                {
                    NSString *lesNums = [NSString stringWithFormat:@"%d.%d", i, j];
                    [lessons addObject:[lesNums stringByAppendingString:[NSString stringWithFormat:@" %@", [chap objectForKey:lesNums][2]]]];
                }
                [_dataModel addObject:lessons];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataModel count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_dataModel count] == 0) {
		return 0;
	}
    return [[_dataModel objectAtIndex:section] count];
}

#pragma mark - TableViewDelegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.navigationItem.title isEqualToString:@"Quicknotes"])
    {
        [self performSegueWithIdentifier:@"loadQuicknotes" sender:indexPath];
    }
    else if ([self.navigationItem.title isEqualToString:@"Practice"]){
        [self performSegueWithIdentifier:@"loadPractice" sender:indexPath];
    }
    else{
        [self performSegueWithIdentifier:@"loadChapter" sender:indexPath];
    }
}

#pragma mark - UITableView methods
- (UITableViewCell *)tableView:(ExpandableTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RowCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([self.navigationItem.title isEqualToString:@"Quicknotes"]){
        cell.textLabel.text = [_chapterTitles objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text = [[_dataModel objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
	cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
	cell.backgroundView.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:243.0/255.0 blue:1.0 alpha:1.0];
	
    return cell;
}

#pragma mark - ExpandableTableViewDataSource methods
- (UITableViewCell *)tableView:(ExpandableTableView *)tableView cellForGroupInSection:(NSUInteger)section
{
    static NSString *CellIdentifier = @"GroupCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if ([self.navigationItem.title isEqualToString:@"Quicknotes"]){
        cell.textLabel.text = @"Chapters";
        [tableView expandSection:section];
        cell.userInteractionEnabled=NO;
    }
    else{
        cell.textLabel.text = [NSString stringWithFormat: @"%@", _chapterTitles[section]];
    }
	
	cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandableAccessoryView"] highlightedImage:[UIImage imageNamed:@"ExpandableAccessoryView"]];
	UIView *accessoryView = cell.accessoryView;
	if ([[tableView indexesForExpandedSections] containsIndex:section]) {
		accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
	} else {
		accessoryView.transform = CGAffineTransformMakeRotation(0);
	}
    return cell;
}

#pragma mark - ExpandableTableViewDelegate methods
- (void)tableView:(ExpandableTableView *)tableView willExpandSection:(NSUInteger)section {
	UITableViewCell *headerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
	[UIView animateWithDuration:0.3f animations:^{
		headerCell.accessoryView.transform = CGAffineTransformMakeRotation(M_PI - 0.00001); //rotate in correct direction
	}];
}

- (void)tableView:(ExpandableTableView *)tableView willContractSection:(NSUInteger)section {
	UITableViewCell *headerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
	[UIView animateWithDuration:0.3f animations:^{
		headerCell.accessoryView.transform = CGAffineTransformMakeRotation(0);
	}];
}

#pragma mark - private methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"loadQuicknotes"]){
        QuickNotesViewController *viewController = segue.destinationViewController;
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        NSString *lessonName = [NSString stringWithFormat:@"%@", [_chapterTitles objectAtIndex:indexPath.row]];
        viewController.navigationItem.title = [NSString stringWithFormat:@"%@", lessonName];
        [viewController setLesson:[NSString stringWithFormat:@"%@", [[_dataModel objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
    }
    else if ([[segue identifier] isEqualToString:@"loadPractice"]){
        PracticeViewController *viewController = segue.destinationViewController;
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        NSString *lessonName = [NSString stringWithFormat:@"%@", [[_dataModel objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        viewController.navigationItem.title = [NSString stringWithFormat:@"%@", lessonName];
        [viewController setLesson: [NSString stringWithFormat:@"%.01f",lessonName.floatValue]];
    }
    else{
        LessonViewController *viewController = segue.destinationViewController;
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        NSString *lessonName = [NSString stringWithFormat:@"%@", [[_dataModel objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        viewController.navigationItem.title = [NSString stringWithFormat:@"%@", lessonName];
        [viewController setLesson: [NSString stringWithFormat:@"%.01f",lessonName.floatValue]];
	}
}


@end
