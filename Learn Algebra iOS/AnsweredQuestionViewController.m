//
//  AnsweredQuestionViewController.m
//  Learn Algebra iOS
//
//  Created by James Jia on 2/9/13.
//  Copyright (c) 2013 ExEquals. All rights reserved.
//

#import "AnsweredQuestionViewController.h"
@interface AnsweredQuestionViewController()
/**
 Grabs the appropriate problem from the JSON file and displays the answer, the explanation, and the user's answer.
 */
-(void) displayProblem;

/**
 Updates the statistics regarding how well the user is doing in this lesson.
 */
-(void) updateStatistics;

/**
 Pops current viewcontroller from the stack until ChaptersViewController is on the top of the stack.
 */
-(void) backToChapters;

/**
 Pops current viewcontroller from the stack until PracticeViewController is on the top of the stack.
 */
-(IBAction)backToPractice:(id)sender;

/**
 Sends the necessary information to next view controller.
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end

@implementation AnsweredQuestionViewController
@synthesize lesson=_lesson;
@synthesize answerString=_answerString;
@synthesize explanationString = _explanationString;
@synthesize textFieldString = _textFieldString;

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
    NSLog(@"Answer: %@  Response: %@   TextField: %@", _answerString, _explanationString, _textFieldString);
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backToChapters)];
    [self.navigationItem setLeftBarButtonItem:backItem];
    [self displayProblem];
    [self updateStatistics];
}

#pragma mark private methods
-(void) displayProblem{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:self.lesson ofType:@"json" inDirectory:@"Practice"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSDictionary *json =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *problemsArray = [json objectForKey:@"problemsArray"];
    NSDictionary *pickedQuestion=[problemsArray objectAtIndex:arc4random_uniform([problemsArray count])];
    self.answerString = [pickedQuestion objectForKey:@"answer"];
    self.explanationString = [pickedQuestion objectForKey:@"explanation"];
    NSString *question = [pickedQuestion objectForKey:@"question"];
    NSString *type = [pickedQuestion objectForKey:@"type"];
    
    if ([type isEqualToString:JQMATH]){
        [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",question,JQMATHHEADER] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    else if ([type isEqualToString:GRAPH]){
        
    }
    else if ([type isEqualToString:MC]){
        
    }
    else if ([type isEqualToString:TEXT]){
        [_webView loadHTMLString:question baseURL:nil];
    }
    else if ([type isEqualToString:MATHJAX]){
        [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",question, MATHJAXHEADER] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
}

- (void) updateStatistics{
    //TODO update plist to reflect new stats.
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
