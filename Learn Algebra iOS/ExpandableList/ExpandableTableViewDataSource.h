//
//  ExpandableTableViewDataSource.h
//  ExpandableTableView
//
//  Created by James Jia on 01/12/2013.
//  Credit for ExpandableTableView goes to wannabegeek @ github.com/wannabegeek/ExpandableTableView

#import <Foundation/Foundation.h>

@class ExpandableTableView;

@protocol ExpandableTableViewDataSource <NSObject>

@required
- (UITableViewCell *)tableView:(ExpandableTableView *)tableView cellForGroupInSection:(NSUInteger)section;
- (UITableViewCell *)tableView:(ExpandableTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(ExpandableTableView *)tableView numberOfRowsInSection:(NSInteger)section;
@optional
- (void)tableView:(ExpandableTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(ExpandableTableView *)tableView;
- (BOOL)tableView:(ExpandableTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(ExpandableTableView *)tableView canEditSection:(NSInteger)section;
- (BOOL)tableView:(ExpandableTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(ExpandableTableView *)tableView titleForFooterInSection:(NSInteger)section;
- (NSString *)tableView:(ExpandableTableView *)tableView titleForHeaderInSection:(NSInteger)section;

- (BOOL)ungroupSimpleElementsInTableView:(ExpandableTableView *)tableView;

@end
