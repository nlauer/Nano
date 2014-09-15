//
//  CreateTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "GoogleMapsTaskViewController.h"
#import "ShortcutStore.h"
#import "TaskViewController.h"
#import "EditTaskViewController.h"

@interface CreateTaskViewController ()

@end

@implementation CreateTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.appData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Tasks" ofType:@"plist"]];
        self.appVCs = [[NSMutableArray alloc] initWithCapacity:self.appData.count];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    self.carousel.type = iCarouselTypeLinear;
    for (NSDictionary *data in self.appData) {
        TaskViewController *vc = [[TaskViewController alloc] initWithPlistData:data WithMainController:self WithArgs:nil];
        [self.appVCs addObject:vc];
    }

    [self loadTaskVCForAppAtIndex:0 WithRefresh:NO];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [self.appData count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75.0f, 75.0f)];
        //view.contentMode = UIViewContentModeCenter;
    }
    TaskViewController *taskVC = self.appVCs[index];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:taskVC.appImage];
    imageView.frame = CGRectMake(0, 0, 68.0f, 68.0f);
    [view addSubview:imageView];
    
    if ([taskVC deviceHasApp]) {
        [view setAlpha:1.0f];
    } else {
        [view setAlpha:0.5f];
    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing) {
        return value * 1.1f;
    } else if (option == iCarouselOptionWrap) {
        return NO;
    }
    return value;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    [self.currentTaskVC.view removeFromSuperview];
    [self loadTaskVCForAppAtIndex:[carousel currentItemIndex] WithRefresh:NO];
}

-(void)refreshCurrentTask
{
    [self.currentTaskVC.view removeFromSuperview];
    [self loadTaskVCForAppAtIndex:[self.carousel currentItemIndex] WithRefresh:YES];
}

-(void)loadTaskVCForAppAtIndex:(int)index WithRefresh:(BOOL)refresh
{
    TaskViewController *taskVC = self.appVCs[index];
    if (refresh || !taskVC) {
        taskVC = [[TaskViewController alloc] initWithPlistData:self.appData[index] WithMainController:self WithArgs:nil];
        self.appVCs[index] = taskVC;
    }
    self.taskLabel.text = taskVC.action;
    [self addChildViewController:taskVC];
    [self.containerView addSubview:taskVC.view];
    self.currentTaskVC = taskVC;
    [self rerenderButtons];
}

- (IBAction)submitButtonClicked:(id)sender {
    Shortcut *shortcut = [self.currentTaskVC formShortcut];
    self.shortcut = shortcut;
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    [self.submitButton setHidden:YES];
    [self.successLabel setHidden:NO];
    [self.createNewButton setHidden:NO];
    self.currentTaskVC.saved = YES;
}

- (IBAction)createNewButtonClicked:(id)sender {
    EditTaskViewController *editvc = [[EditTaskViewController alloc] init];
    editvc.shortcut = self.shortcut;
    [self presentViewController:editvc animated:YES completion:nil];
    [self refreshCurrentTask];
    [self.successLabel setHidden:YES];
    [self.createNewButton setHidden:YES];
}

- (IBAction)downloadAppButtonClicked:(id)sender {
    [self.currentTaskVC openInAppStore];
}

-(void)rerenderButtons{
    if (self.currentTaskVC.saved) {
        [self.submitButton setHidden:YES];
        [self.successLabel setHidden:NO];
        [self.createNewButton setHidden:NO];
    } else {
        [self.submitButton setHidden:![self.currentTaskVC shouldShowSubmit]];
        [self.successLabel setHidden:YES];
        [self.createNewButton setHidden:YES];
    }
    
    if (self.currentTaskVC.deviceHasApp) {
        [self.downloadAppButton setHidden:YES];
    } else {
        [self.downloadAppButton setHidden:NO];
    }
}

-(void)dismissKeyboard {
    [self dismissAllKeyboardsInView:self.view];
}

- (void)dismissAllKeyboardsInView:(UIView *)view {
    for (UIView *subview in [view subviews]) {
        if ([subview isMemberOfClass:[UITextField class]]) {
            [(UITextField *)subview resignFirstResponder];
        } else if ([subview isMemberOfClass:[UITextView class]]) {
            [(UITextView *)subview resignFirstResponder];
        }
        [self dismissAllKeyboardsInView:subview];
    }
}

@end
