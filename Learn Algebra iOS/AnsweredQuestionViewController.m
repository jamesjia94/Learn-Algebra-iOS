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
-(void) displayAnswer;

/**
 Updates the statistics regarding how well the user is doing in this lesson.
 */
-(void) updateStatistics:(BOOL)isCorrect;

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
    NSLog(@"Lesson: %d Chapter: %d",_lesson,_chapter);
    NSLog(@"Answer: %@  Response: %@   TextField: %@", _answerString, _explanationString, _textFieldString);
    self.navigationItem.hidesBackButton=YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backToChapters)];
    [self.navigationItem setLeftBarButtonItem:backItem];
    [self displayAnswer];
}

#pragma mark private methods
-(void) displayAnswer{
    NSString* htmlString;
    if ([self checkAnswer]){
        htmlString = [NSString stringWithFormat:@"You are Correct!<br/>The answer is: %@.",_answerString];
        [self updateStatistics:YES];
    }
    else{
        htmlString = [NSString stringWithFormat:@"The correct answer is: %@. <br/><br/>%@",_answerString,_explanationString];
        [self updateStatistics:NO];
    }
    if ([_typeString isEqualToString:JQMATH]){
        [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",htmlString,JQMATHHEADER] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    else if ([_typeString isEqualToString:GRAPH]){
        
    }
    else if ([_typeString isEqualToString:MC]){
        
    }
    else if ([_typeString isEqualToString:TEXT]){
        [_webView loadHTMLString:htmlString baseURL:nil];
    }
    else if ([_typeString isEqualToString:MATHJAX]){
        [_webView loadHTMLString:[NSString stringWithFormat:@"%@%@",htmlString, MATHJAXHEADER] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
}

-(BOOL)checkAnswer{
    return true;
//    return [ComExequalsLearnguiPracticeMathInputReader compareEquationsWithNSString:_answerString withNSString:_textFieldString];
}

- (void) updateStatistics: (BOOL) isCorrect{
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingString:@"Data.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *plist = (NSDictionary *)[NSPropertyListSerialization
                                           propertyListFromData:plistXML
                                           mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                           format:&format
                                           errorDescription:&errorDesc];
    if (!plist) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    NSMutableArray *chapters = [plist objectForKey:@"Chapters"];
    NSDictionary *totalDict = [chapters objectAtIndex:0];
    NSDictionary *chapterDict = [chapters objectAtIndex:_chapter];
    NSMutableArray *totalStats = [totalDict objectForKey:[NSString stringWithFormat:@"0.0"]];
    NSMutableArray *chapStats = [chapterDict objectForKey:[NSString stringWithFormat:@"%d.%d",_chapter,_lesson]];
    if (isCorrect){
        [totalStats replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:((NSNumber*)[totalStats objectAtIndex:0]).intValue+1]];
        [chapStats replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:((NSNumber*)[chapStats objectAtIndex:0]).intValue+1]];
    }
    [totalStats replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:((NSNumber*)[totalStats objectAtIndex:1]).intValue+1]];
    [chapStats replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:((NSNumber*)[chapStats objectAtIndex:1]).intValue+1]];
    NSString *error;
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plist format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];

    if (plistData){
        [plistData writeToFile:plistPath atomically:YES];
    }
    else{
        NSLog(@"%@",error);
    }
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
        [vc setLesson:[NSString stringWithFormat:@"%d.%d",_chapter,_lesson]];
    }
}

@end
