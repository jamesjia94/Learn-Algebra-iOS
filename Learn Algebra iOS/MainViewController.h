//
//  ViewController.h
//  Learn Algebra iOS
//
//  Created by James Jia on 1/7/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChaptersViewController.h"
#import "AboutPageViewController.h"

/**
 \mainpage To look for documentation, please click on the classes tab.
 
 */
/**
 UIViewController that controls the home screen.
 */
@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSArray *homeButtons;
}

@end
