//
//  ExpandableTableView.h
//  ExpandableTableView
//
//  Created by James Jia on 01/12/2013.
//  Credit for ExpandableTableView goes to wannabegeek @ github.com/wannabegeek/ExpandableTableView

#import <UIKit/UIKit.h>
#import "ExpandableTableViewDataSource.h"
#import "ExpandableTableViewDelegate.h"

@interface ExpandableTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

- (void)expandSection:(NSUInteger)section;
- (void)contractSection:(NSUInteger)section;

- (UITableViewCell *)cellForSection:(NSUInteger)section;
- (UITableViewCell *)cellForChildRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)cellVisibleForIndexPath:(NSIndexPath *)indexPath;

- (NSIndexSet *)indexesForExpandedSections;
- (void)reloadSectionCellsAtIndexes:(NSIndexSet *)indexes withRowAnimation:(UITableViewRowAnimation)animation;

@property (assign) BOOL ungroupSingleElement;

@end
