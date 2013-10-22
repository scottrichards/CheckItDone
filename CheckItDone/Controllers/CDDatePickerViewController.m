//
//  CDDatePickerViewController.m
//  CheckItDone
//
//  Created by Scott Richards on 10/3/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDDatePickerViewController.h"

@interface CDDatePickerViewController ()

@end

@implementation CDDatePickerViewController

@synthesize item;
@synthesize dismissBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[item date]];
    [self.datePicker setDate:[item date]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [[self view] endEditing:YES];
    
    // "Save" changes to item
//    NSTimeInterval timeInterval = [[self.datePicker date] timeIntervalSinceReferenceDate];

    [item setDate:[self.datePicker date]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
	NSString *dateStr = [NSString stringWithFormat:@"%@",
                         [df stringFromDate:[item date]]];
    NSLog(@"Date: %@",dateStr);
}

- (IBAction)selectDate:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
	NSString *dateStr = [NSString stringWithFormat:@"%@",
                  [df stringFromDate:self.datePicker.date]];
    NSLog(@"Date: %@",dateStr);
}
@end
