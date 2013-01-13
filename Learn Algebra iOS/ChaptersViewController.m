//
//  ChaptersViewController.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/11/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "ChaptersViewController.h"

@interface ChaptersViewController ()

@end

@implementation ChaptersViewController
@synthesize dataModel = _dataModel;
@synthesize navigationTitle = _navigationTitle;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_dataModel count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_dataModel count] == 0) {
		return 0;
	}
    // Return the number of rows in the section.
    return [[_dataModel objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(ExpandableTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RowCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	cell.textLabel.text = [[_dataModel objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	// just change the cells background color to indicate group separation
	cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
	cell.backgroundView.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:243.0/255.0 blue:1.0 alpha:1.0];
	
    return cell;
}

- (UITableViewCell *)tableView:(ExpandableTableView *)tableView cellForGroupInSection:(NSUInteger)section
{
    static NSString *CellIdentifier = @"GroupCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	cell.textLabel.text = [NSString stringWithFormat: @"Chapter %d", section+1];
	
	// We add a custom accessory view to indicate expanded and colapsed sections
	cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ExpandableAccessoryView"] highlightedImage:[UIImage imageNamed:@"ExpandableAccessoryView"]];
	UIView *accessoryView = cell.accessoryView;
	if ([[tableView indexesForExpandedSections] containsIndex:section]) {
		accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
	} else {
		accessoryView.transform = CGAffineTransformMakeRotation(0);
	}
    return cell;
}

// The next two methods are used to rotate the accessory view indicating whjether the
// group is expanded or now
- (void)tableView:(ExpandableTableView *)tableView willExpandSection:(NSUInteger)section {
	UITableViewCell *headerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
	[UIView animateWithDuration:0.3f animations:^{
		headerCell.accessoryView.transform = CGAffineTransformMakeRotation(M_PI - 0.00001); // we need this little hack to subtract a small amount to make sure we rotate in the correct direction
	}];
}

- (void)tableView:(ExpandableTableView *)tableView willContractSection:(NSUInteger)section {
	UITableViewCell *headerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
	[UIView animateWithDuration:0.3f animations:^{
		headerCell.accessoryView.transform = CGAffineTransformMakeRotation(0);
	}];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
