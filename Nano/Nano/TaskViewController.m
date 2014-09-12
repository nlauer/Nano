//
//  TaskViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/11/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskComponentViewControllerProtocol.h"
#import "CreateTaskViewController.h"

@interface TaskViewController ()

@end

@implementation TaskViewController

-(TaskViewController *)initWithPlistData:(NSDictionary *)data WithMainController:(CreateTaskViewController *)mainVC {
    self = [super init];
    if( !self ) return nil;

    self.mainVC = mainVC;
    self.saved = NO;
    self.appName = data[@"appName"];
    self.action = data[@"action"];
    self.components = data[@"components"];
    self.shortcutSelectorString = data[@"shortcutSelector"];
    self.urlScheme = data[@"urlScheme"];
    self.appStoreLink = data[@"appStoreLink"];
    self.appImage = [UIImage imageNamed:data[@"appImage"]];
    self.componentVCs = [[NSMutableArray alloc] initWithCapacity:self.components.count];

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    int height = 0;
    for (NSDictionary *component in self.components) {
        NSString *classname = component[@"type"];
        Class compClass = NSClassFromString(classname);
        UIViewController *componentVC = [[compClass alloc] initWithComponentData:component];
        ((UIViewController<TaskComponentViewControllerProtocol> *)componentVC).parent = self;

        componentVC.view.frame = CGRectMake(0, height, componentVC.view.frame.size.width, componentVC.view.frame.size.height);
        height += componentVC.view.frame.size.height;
        
        [self.componentVCs addObject:componentVC];
        [self addChildViewController:componentVC];
        [self.view addSubview:componentVC.view];
    }
    
    if (![self deviceHasApp]) {
        [self disableAllButtonsInView:self.view];
        [self disableAllTextFieldsInView:self.view];
        [self disableAllTextViewsInView:self.view];
        [self setSubviewsForView:self.view toAlpha:0.5f];
    }
}

- (Shortcut *)formShortcut {
    NSMutableArray *args = [[NSMutableArray alloc] initWithCapacity:self.components.count];
    for (int i = 0; i < self.components.count; i++) {
        args[i] = [self.componentVCs[i] shortcutValue];
    }
    
    return [Shortcut shortcutForSelectorString:self.shortcutSelectorString WithArgs:args];
}

- (BOOL)shouldShowSubmit {
    BOOL shouldShow = YES;
    for (UIViewController<TaskComponentViewControllerProtocol> *component in [self childViewControllers]) {
        shouldShow = shouldShow && [component isCompleted];
    }
    return shouldShow;
}

- (BOOL)deviceHasApp {
    // uncomment for simulator testing
    return true;
    NSString *appURLScheme = self.urlScheme;
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appURLScheme]];
}

- (void)openInAppStore {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appStoreLink]];
}

- (void)rerenderButtons {
    [self.mainVC rerenderButtons];
}

- (void)disableAllButtonsInView:(UIView *)view {
    for (UIView *subview in [view subviews]) {
        if ([subview isMemberOfClass:[UIButton class]]) {
            [(UIButton *)subview setEnabled:NO];
        }
        [self disableAllButtonsInView:subview];
    }
}

- (void)disableAllTextFieldsInView:(UIView *)view {
    for (UIView *subview in [view subviews]) {
        if ([subview isMemberOfClass:[UITextField class]]) {
            [(UITextField *)subview setEnabled:NO];
        }
        [self disableAllTextFieldsInView:subview];
    }
}

- (void)disableAllTextViewsInView:(UIView *)view {
    for (UIView *subview in [view subviews]) {
        if ([subview isMemberOfClass:[UITextView class]]) {
            [(UITextView *)subview setEditable:NO];
        }
        [self disableAllTextViewsInView:subview];
    }
}

- (void)setSubviewsForView:(UIView *)view toAlpha:(CGFloat)alpha {
    for (UIView *subview in [view subviews]) {
        [subview setAlpha:alpha];
    }
}

@end