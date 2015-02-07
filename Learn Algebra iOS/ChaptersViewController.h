//
//  ChaptersViewController.h
//  Learn Algebra iOS
//
//  Created by James Jia on 1/11/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableTableViewController.h"
#import "LessonViewController.h"
#import "QuickNotesViewController.h"
#import "PracticeViewController.h"

/**
 ViewController that handles views that need an expandableTableView such as Lessons, Practice, and QuickNotes.
 */
@interface ChaptersViewController :  ExpandableTableViewController <ExpandableTableViewDataSource, ExpandableTableViewDelegate>{
    NSMutableArray *dataModel;
    NSMutableArray *chapterTitles;
}

@property (strong) NSMutableArray *dataModel;
@property (strong) NSMutableArray *chapterTitles;
@end
