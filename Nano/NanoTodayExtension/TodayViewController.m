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
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *shortcutURLs;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [Venmo startWithAppId:@"1944" secret:@"YdFGe8KjDCePjgZshL76xJTPkJenaCbT" name:@"Nano"];

    self.preferredContentSize = CGSizeMake(0, 80);

    [self.collectionView registerClass:[UICollectionViewCell class]
                forCellWithReuseIdentifier:@"NanoCell"];

    self.shortcutURLs = [NSArray arrayWithObjects:
                         [self googleMapsURLFrom:@"" to:@"Home" mode:@"transit"],
                         [self facebookEventURLForGroupID:@"620819504700967"],
                         [self smsURLForPhoneNumber:@"4159351717"],
                         [self yelpSearchForName:@"Starbucks"],
                         nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

#pragma mark - Collection View
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.shortcutURLs count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"NanoCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.extensionContext openURL:[self.shortcutURLs objectAtIndex:indexPath.row] completionHandler:nil];

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
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

- (NSURL *)googleMapsURLFrom:(NSString *)from to:(NSString *)to mode:(NSString *)mode
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?saddr=%@&daddr=%@&directionsmode=%@", from, to, mode]];
}

- (NSURL *)facebookEventURLForGroupID:(NSString *)eventID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"fb://event?id=%@", eventID]];
}

- (NSURL *)smsURLForPhoneNumber:(NSString *)number
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", number]];
}

- (NSURL *)yelpSearchForName:(NSString *)name
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"yelp:///search?terms=%@", name]];
}

@end
