//
//  ChaptersViewController.h
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/11/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableTableViewController.h"

@interface ChaptersViewController :  ExpandableTableViewController <ExpandableTableViewDataSource, ExpandableTableViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationTitle;
@property (strong) NSMutableArray *dataModel;
@end
