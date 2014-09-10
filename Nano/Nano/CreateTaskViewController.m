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

@interface CreateTaskViewController ()

@end

@implementation CreateTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.appNames = @[@"Google Maps",
                          @"Venmo",
                          @"Uber",
                          @"Rdio",
                          @"Yelp",
                          @"Facebook",
                          @"iMessage",
                          @"Yo"];
        self.appInfos = @{@"Google Maps": [[AppInfo alloc] initWithAppName:@"Google Maps"],
                     @"Venmo": [[AppInfo alloc] initWithAppName:@"Venmo"],
                     @"Uber": [[AppInfo alloc] initWithAppName:@"Uber"],
                     @"Rdio": [[AppInfo alloc] initWithAppName:@"Rdio"],
                     @"Yelp": [[AppInfo alloc] initWithAppName:@"Yelp"],
                     @"Facebook": [[AppInfo alloc] initWithAppName:@"Facebook"],
                     @"iMessage": [[AppInfo alloc] initWithAppName:@"iMessage"],
                     @"Yo": [[AppInfo alloc] initWithAppName:@"Yo"]};
        self.appVCs = [[NSMutableDictionary alloc]initWithCapacity:self.appInfos.count];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.carousel.type = iCarouselTypeLinear;
    
    NSString *startingAppName = @"Google Maps";
    [self loadTaskVCForApp:startingAppName WithRefresh:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [self.appInfos count];
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
    UIImageView *imageView = [[UIImageView alloc] initWithImage:((AppInfo *)self.appInfos[self.appNames[index]]).appImage];
    imageView.frame = CGRectMake(0, 0, 68.0f, 68.0f);
    [view addSubview:imageView];
    
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
    NSString *appName = self.appNames[[carousel currentItemIndex]];
    [self loadTaskVCForApp:appName WithRefresh:NO];
}

-(void)refreshCurrentTask
{
    [self.currentTaskVC.view removeFromSuperview];
    NSString *appName = self.appNames[[self.carousel currentItemIndex]];
    [self loadTaskVCForApp:appName WithRefresh:YES];
}

-(void)loadTaskVCForApp:(NSString *)appName WithRefresh:(BOOL)refresh
{
    UIViewController<TaskViewControllerProtocol> *taskVC = self.appVCs[appName];
    self.currentAppInfo = self.appInfos[appName];
    if (refresh || !taskVC) {
        taskVC = [self.currentAppInfo initializeTaskViewControllerWithMainController:self];
        self.appVCs[appName] = taskVC;
    }
    self.taskLabel.text = self.currentAppInfo.appAction;
    [self addChildViewController:taskVC];
    [self.containerView addSubview:taskVC.view];
    self.currentTaskVC = taskVC;
    [self rerenderButtons];
}

- (IBAction)submitButtonClicked:(id)sender {
    Shortcut *shortcut = [self.currentTaskVC formShortcut];
    [[ShortcutStore sharedStore] addShortcutToStore:shortcut];
    [self.submitButton setHidden:YES];
    [self.successLabel setHidden:NO];
    [self.createNewButton setHidden:NO];
    self.currentTaskVC.saved = YES;
}

- (IBAction)createNewButtonClicked:(id)sender {
    [self refreshCurrentTask];
    [self.successLabel setHidden:YES];
    [self.createNewButton setHidden:YES];
}

- (IBAction)downloadAppButtonClicked:(id)sender {
    [self.currentAppInfo openInAppStore];
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
    
    if (self.currentAppInfo.deviceHasApp) {
        [self.downloadAppButton setHidden:YES];
    } else {
        [self.downloadAppButton setHidden:NO];
    }
}

@end
