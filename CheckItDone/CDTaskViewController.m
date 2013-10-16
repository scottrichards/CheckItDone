//
//  CDTaskViewController.m
//  CheckItDone
//
//  Created by Scott Richards on 9/11/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDTaskViewController.h"
#import "CDTableViewController.h"

@interface CDTaskViewController ()

@end

@implementation CDTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     CDTableViewController *tableViewController = [[CDTableViewController alloc]init];
    [self addChildViewController:tableViewController];
    [self.view addSubview:tableViewController.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
