//
//  CDDatePickerViewController.h
//  CheckItDone
//
//  Created by Scott Richards on 10/3/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRItem.h"

@interface CDDatePickerViewController : UIViewController
@property (strong, nonatomic) BNRItem *item;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) NSDate *dueDate;
- (IBAction)selectDate:(id)sender;
@end
