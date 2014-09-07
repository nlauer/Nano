//
//  CreateTaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/6/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "CreateTaskViewController.h"
#import "GoogleMapsTaskViewController.h"

@interface CreateTaskViewController ()

@end

@implementation CreateTaskViewController {
    NSArray *apps;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        apps = @[@"venmo", @"gmaps", @"uber", @"rdio", @"yelp", @"fb", @"imessage", @"yo"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.carousel.type = iCarouselTypeLinear;
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
    return [apps count];
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
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:apps[index]]];
        imageView.frame = CGRectMake(0, 0, 68.0f, 68.0f);
        [view addSubview:imageView];
        //view.contentMode = UIViewContentModeCenter;
    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing) {
        return value * 1.1f;
    } else if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    [self.taskVC.view removeFromSuperview];
    NSString *app = apps[[carousel currentItemIndex]];
    if ([app  isEqual: @"gmaps"]) {
        if (!self.googleVC) {
            self.googleVC = [[GoogleMapsTaskViewController alloc] init];
            self.googleVC.mainVC = self;
        }
        [self addChildViewController:self.googleVC];
        [self.containerView addSubview:self.googleVC.view];
        self.taskVC = self.googleVC;
    } else if ([app  isEqual: @"venmo"]) {
    } else {
    }
}

@end
