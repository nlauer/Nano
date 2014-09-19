//
//  ProfileViewController.m
//  Nano
//
//  Created by Jamie Karraker on 9/16/14.
//  Copyright (c) 2014 Lauer. All rights reserved.
//

#import "ProfileViewController.h"
#import "ShortcutStore.h"
#import "Shortcut.h"
#import "ShortcutTableViewCell.h"
#import "EditTaskViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"My Shortcuts";
        self.shortcuts = [[ShortcutStore sharedStore] getSharedShortcuts];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark UITableViewDelegate/DataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shortcuts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ShortcutCell";
    ShortcutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShortcutTableViewCell" owner:self options:nil];
        cell = nib[0];
    }
    
    Shortcut *shortcut = self.shortcuts[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:[shortcut.icon stringByAppendingString:@"-profile"]];
    cell.actionLabel.text = shortcut.name;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditTaskViewController *editVC = [[EditTaskViewController alloc] init];
    editVC.shortcut = self.shortcuts[indexPath.row];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:editVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
