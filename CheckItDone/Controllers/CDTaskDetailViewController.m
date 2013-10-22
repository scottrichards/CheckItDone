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
            
            [[self navigationItem] setTitle:@"New Task"];
            
        }
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.taskName setText:[item name]];
    
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
    
    // when click on the due date bring up the date picker control
    self.dueDate.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnDate)];
    [self.dueDate addGestureRecognizer:tapGesture];
}

- (void) clickOnDate
{
    CDDatePickerViewController *datePickerViewController = [[CDDatePickerViewController alloc] init];
    [datePickerViewController setItem:self.item];
    [[self navigationController] pushViewController:datePickerViewController
                                           animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleRemindMe:(id)sender {
    if (self.remindMeSwitch.on) {
        NSTimeInterval t = [[NSDate date] timeIntervalSinceReferenceDate];
        [self.item setDate:t];
        NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[item date]];
        
        // Create a NSDateFormatter that will turn a date into a simple date string
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        
        [self.dueDate setText:[dateFormatter stringFromDate:date]];
        [self.dueDate setHidden:NO];
        [self.dateLabel setHidden:NO];
    } else {
        [item setDate:0];
        [self.dueDate setHidden:YES];
        [self.dateLabel setHidden:YES];
    }
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
