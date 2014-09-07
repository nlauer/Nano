//
//  TodayViewController.m
//  NanoTodayExtension
//
//  Created by Nick Lauer on 2014-09-06.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <Venmo-iOS-SDK/Venmo.h>
#import "Shortcut.h"

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *shortcutURLs;
@end

@implementation TodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
        [self updateShortcutURLs];
    }
    return self;
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self updateShortcutURLs];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateShortcutURLs];
    self.preferredContentSize = CGSizeMake(0, 50*[self.shortcutURLs count]);
    self.tableView.bounds = CGRectMake(0, 0, 320, 50*[self.shortcutURLs count]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [Venmo startWithAppId:@"1944" secret:@"YdFGe8KjDCePjgZshL76xJTPkJenaCbT" name:@"Nano"];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)updateShortcutURLs
{
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.lauer.NanoExtension"];
    NSData *encodedObject = [sharedDefaults objectForKey:@"shortcuts"];
    self.shortcutURLs = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    self.preferredContentSize = CGSizeMake(0, 50*[self.shortcutURLs count]);
    self.tableView.bounds = CGRectMake(0, 0, 320, 50*[self.shortcutURLs count]);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    self.tableView.bounds = CGRectMake(0, 0, 320, 50*[self.shortcutURLs count]);
    self.preferredContentSize = CGSizeMake(0, 50*[self.shortcutURLs count]);
    [self updateShortcutURLs];

    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

#pragma mark - Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shortcutURLs count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NanoCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];

    Shortcut *shortcut = [self.shortcutURLs objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:shortcut.icon]];

    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    cell.textLabel.text = shortcut.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];

    return cell;
}

#pragma mark - UITableViewViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.extensionContext openURL:((Shortcut *)[self.shortcutURLs objectAtIndex:indexPath.row]).url completionHandler:nil];
}

@end
