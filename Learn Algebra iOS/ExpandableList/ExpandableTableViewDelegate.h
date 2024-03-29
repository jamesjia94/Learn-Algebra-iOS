//
//  ExpandableTableViewDelegate.h
//  ExpandableTableView
//
//  Created by James Jia on 01/12/2013.
//  Credit for ExpandableTableView goes to wannabegeek @ github.com/wannabegeek/ExpandableTableView

#import <Foundation/Foundation.h>

@class ExpandableTableView;

@protocol ExpandableTableViewDelegate <NSObject>

@optional
- (void)tableView:(ExpandableTableView *)tableView willExpandSection:(NSUInteger)section;
- (void)tableView:(ExpandableTableView *)tableView didExpandSection:(NSUInteger)section;
- (void)tableView:(ExpandableTableView *)tableView willContractSection:(NSUInteger)section;
- (void)tableView:(ExpandableTableView *)tableView didContractSection:(NSUInteger)section;

- (BOOL)tableView:(ExpandableTableView *)tableView canRemoveSection:(NSUInteger)section;

- (NSInteger)tableView:(ExpandableTableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ExpandableTableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ExpandableTableView *)tableView willDisplayCell:(UITableViewCell *)cell forSection:(NSUInteger)section;

- (NSIndexPath *)tableView:(ExpandableTableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ExpandableTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(ExpandableTableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(ExpandableTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
