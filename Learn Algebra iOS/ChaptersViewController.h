//
//  ChaptersViewController.h
//  Learn Algebra iOS
//
//  Created by XLab Developer on 1/11/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableTableViewController.h"
#import "LessonViewController.h"
#import "QuickNotesViewController.h"
#import "PracticeViewController.h"

@interface ChaptersViewController :  ExpandableTableViewController <ExpandableTableViewDataSource, ExpandableTableViewDelegate>{
    NSMutableArray *dataModel;
}
@property (strong) NSMutableArray *dataModel;
@end
