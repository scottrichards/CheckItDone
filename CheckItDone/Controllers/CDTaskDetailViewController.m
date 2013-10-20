//
//  CDTaskDetailViewController.m
//  CheckItDone
//
//  Created by Scott Richards on 10/3/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDTaskDetailViewController.h"
#import "CDTask.h"
#import "CDTaskStore.h"
#import "CDDatePickerViewController.h"
#import "CDTableViewController.h"

@interface CDTaskDetailViewController ()

@end

@implementation CDTaskDetailViewController

@synthesize item;
@synthesize dismissBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UINavigationItem *n = [self navigationItem];
        [[[self navigationItem] leftBarButtonItem] setTitle:@"Back"];
        [n setTitle:@"Task Details"];

    }
    return self;
}

- (id)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:@"CDTaskDetailViewController" bundle:nil];
    
    if (self) {
        if (isNew) {
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
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.taskName setText:[item name]];
    
    // Create a NSDateFormatter that will turn a date into a simple date string
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Use filtered NSDate object to set dateLabel contents
//    [self.dueDate setText:[dateFormatter stringFromDate:[item date]]];
    // Convert time interval to NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[item date]];
    [self.dueDate setText:[dateFormatter stringFromDate:date]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [[self view] endEditing:YES];
    
    // "Save" changes to item
    [item setName:[self.taskName text]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithWhite:.8 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editDate:(id)sender {
    // Create and push Task Detail view controller.
    CDDatePickerViewController *datePickerViewController = [[CDDatePickerViewController alloc] init];
    [datePickerViewController setItem:self.item];
//    [[datePickerViewController datePicker] setDate:[item dateCreated]];
    [[self navigationController] pushViewController:datePickerViewController
                                           animated:YES];

    
}

- (void)save:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                        completion:dismissBlock];
}

- (void)cancel:(id)sender
{
    // If the user cancelled, then remove the BNRItem from the store
    [self.delegate.taskStore removeItem:item];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES
                                                        completion:dismissBlock];
}

@end
