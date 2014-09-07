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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [Venmo startWithAppId:@"1944" secret:@"YdFGe8KjDCePjgZshL76xJTPkJenaCbT" name:@"Nano"];
    self.tableView.backgroundColor = [UIColor clearColor];

    self.shortcutURLs = [NSArray arrayWithObjects:
                         [self googleMapsShortcutFrom:@"" to:@"Home" mode:@"transit"],
                         [self facebookEventShortcutForEventID:@"620819504700967"],
                         [self smsShortcutForNumber:@"4159351717"],
                         [self yelpShortcutForSearch:@"Starbucks"],
                         nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    self.tableView.bounds = CGRectMake(0, 0, 320, 44*[self.shortcutURLs count]);
    self.preferredContentSize = CGSizeMake(0, 44*[self.shortcutURLs count]);

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NanoCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];

    Shortcut *shortcut = [self.shortcutURLs objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:shortcut.icon]];
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

#pragma mark - Custom Actions
- (void)sendPaymentTo:(NSString *)recipient amount:(NSUInteger)amount
{
    [[Venmo sharedInstance] sendPaymentTo:recipient
                                   amount:amount
                                     note:@" "
                        completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                            if (success) {
                                NSLog(@"Transaction succeeded!");
                            }
                            else {
                                NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                            }
                        }];
}

- (Shortcut *)venmoShortcutForRecipient:(NSString *)recipient amount:(NSUInteger)amount
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Venmo";
    shortcut.amount = amount;
    shortcut.recipient = recipient;
    shortcut.icon = @"venmo";

    return shortcut;
}

- (Shortcut *)googleMapsShortcutFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Transit from here to home";
    shortcut.icon = @"google";
    shortcut.url = [self googleMapsURLFrom:from to:to mode:mode];

    return shortcut;
}

- (NSURL *)googleMapsURLFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?saddr=%@&daddr=%@&directionsmode=%@", from, to, mode]];
}

- (Shortcut *)facebookEventShortcutForEventID:(NSString *)eventID
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Open TechCrunch Disrupt Event";
    shortcut.icon = @"fb";
    shortcut.url = [self facebookEventURLForEventID:eventID];

    return shortcut;
}

- (NSURL *)facebookEventURLForEventID:(NSString *)eventID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"fb://event?id=%@", eventID]];
}

- (Shortcut *)smsShortcutForNumber:(NSString *)number
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Text Message Josh";
    shortcut.icon = @"imessage";
    shortcut.url = [self smsURLForPhoneNumber:number];

    return shortcut;
}

- (NSURL *)smsURLForPhoneNumber:(NSString *)number
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", number]];
}

- (Shortcut *)yelpShortcutForSearch:(NSString *)search
{
    Shortcut *shortcut = [[Shortcut alloc] init];
    shortcut.name = @"Search Yelp for Starbucks";
    shortcut.icon = @"yelp";
    shortcut.url = [self yelpSearchForName:search];

    return shortcut;
}

- (NSURL *)yelpSearchForName:(NSString *)name
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"yelp:///search?terms=%@", name]];
}

@end
