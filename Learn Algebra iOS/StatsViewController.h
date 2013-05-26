//
//  StatsViewController.h
//  Learn Algebra iOS
//
//  Created by James Jia on 4/4/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 View Controller that handles the display of the user's stats in Practice. TODO: grabbing data from plist to display.
 */
@interface StatsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>{

}
@property NSMutableArray *chapters, *chapter1, *chapter2, *chapter3, *chapter4, *chapter5, *chapter6, *chapter7, *chapter8;
@property (nonatomic) IBOutlet UITableView* tableView;
@end
