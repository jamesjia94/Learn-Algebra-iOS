//
//  AnsweredQuestionViewController.m
//  Learn Algebra iOS
//
//  Created by XLab Developer on 2/9/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "AnsweredQuestionViewController.h"

@interface AnsweredQuestionViewController ()
@end

@implementation AnsweredQuestionViewController
@synthesize lesson=_lesson;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backToChapters)];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

-(void) backToChapters{
    ChaptersViewController *vc;
    for (UIViewController *viewController in self.navigationController.viewControllers){
        if ([viewController isMemberOfClass:[ChaptersViewController class]]){
            vc = (ChaptersViewController *) viewController;
            break;
        }
    }
    if (vc){
        [self.navigationController popToViewController: vc animated:YES];
    }
    else{
    [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (IBAction)backToPractice:(id)sender {
    [self performSegueWithIdentifier:@"practiceSegue" sender:self];

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"practiceSegue"]){
        PracticeViewController *vc = [segue destinationViewController];
        vc.navigationItem.title = self.navigationItem.title;
        [vc setLesson:_lesson];
    }
}

@end
