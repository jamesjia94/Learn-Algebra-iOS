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
    
    if ([self.navigationItem.title isEqualToString:@"Quicknotes"]){
        _dataModel = [NSMutableArray arrayWithObject:[NSMutableArray arrayWithObjects:@"1.0", @"2.0", @"3.0", @"4.0", @"5.0", @"6.0", @"7.0", nil]];
    }
    else{
        _dataModel = [NSMutableArray arrayWithObjects:
                      [NSMutableArray arrayWithObjects:@"1.1 Building Blocks of Algebra", @"1.2 Solving Equations", @"1.3 Solving Inequalities", @"1.4 Ratio and Proportions", @"1.5 Exponents", @"1.6 Negative Exponents", @"1.7 Scientific Notation", nil],
                      [NSMutableArray arrayWithObjects:@"2.1 Rectangular Coordinate System", @"2.2 Graphing by Plotting Points/Intercept", @"2.3 Graphing using slopes and y-intercepts", @"2.4 Parallel and Perpendicular Lines", @"2.5 Introduction to Functions", nil],
                      [NSMutableArray arrayWithObjects:@"3.1 Systems of Equations by Substitution", @"3.2 Systems of Equations by Elimination", @"3.3 Systems of Equations by Graphing", nil],
                      [NSMutableArray arrayWithObjects:@"4.1 Introduction to Polynomials", @"4.2 Adding and Subtracting Polynomials", @"4.3 Multiplying and Dividing Polynomials", nil],
                      [NSMutableArray arrayWithObjects: @"5.1 Simplifying Rational Expressions", @"5.2 Multiplying and Dividing Rational Expressions", @"5.3 Adding and Subtracting Rational Expressions", @"5.4 Complex Rational Expressions", @"5.5 Solving Rational Equations", nil],
                      [NSMutableArray arrayWithObjects:@"6.1 Intorduction to Factoring", @"6.2 Factoring Trinomials", @"6.3 Factoring Binomials", @"6.4 Solving Equations by Factoring", nil],
                      [NSMutableArray arrayWithObjects: @"7.1 Introduction to Radicals", @"7.2 Simplifying Radical Expressions", @"7.3 Adding and Subtracting Radical Expressions", @"7.4 Multiplying and Dividing Radical Expressions", @"7.5 Rational Exponents", @"7.6 Solving Radical Equations", nil],
                      [NSMutableArray arrayWithObjects: @"8.1 Extracting Square Roots", @"8.2 Completing the Square", @"8.3 Quadratic Formula", @"8.4 Graphing Parabolas", nil],
                      nil];
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
	
	cell.textLabel.text = [[_dataModel objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
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
        cell.textLabel.text = [NSString stringWithFormat: @"Chapter %d", section+1];
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
        NSString *lessonName = [NSString stringWithFormat:@"%@", [[_dataModel objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        viewController.navigationItem.title = [NSString stringWithFormat:@"Quicknotes: %@", lessonName];
        [viewController setLesson:lessonName];
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
