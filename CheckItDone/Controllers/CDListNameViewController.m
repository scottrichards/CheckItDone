//
//  CDListNameViewController.m
//  CheckItDone
//
//  Created by Scott Richards on 10/21/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDListNameViewController.h"
#import "CDList.h"

@interface CDListNameViewController ()

@end

@implementation CDListNameViewController

@synthesize deleteList;
@synthesize createList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UINavigationItem *n = [self navigationItem];
        [[[self navigationItem] leftBarButtonItem] setTitle:@"Back"];
        [n setTitle:@"New List"];
    }
    return self;
}

- (id)init
{
    self = [super initWithNibName:@"CDListNameViewController" bundle:nil];
    
    if (self) {        
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                     target:self
                                     action:@selector(save:)];
        [[self navigationItem] setRightBarButtonItem:doneItem];
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                       target:self
                                       action:@selector(cancel:)];
        [[self navigationItem] setLeftBarButtonItem:cancelItem];
        
        [[self navigationItem] setTitle:@"New List"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save:(id)sender
{
    self.item.listName = [self.nameField text];
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                        completion:createList];
}

- (void)cancel:(id)sender
{    
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                        completion:deleteList];
}

@end
