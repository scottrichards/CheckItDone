//
//  CDTaskDetailViewController.h
//  CheckItDone
//
//  Created by Scott Richards on 10/3/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDTask.h"
@class CDTableViewController;

@interface CDTaskDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;

@property (strong, nonatomic) CDTask *item;
@property (strong, nonatomic) CDTableViewController *delegate;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (IBAction)editDate:(id)sender;
- (id)initForNewItem:(BOOL)isNew;

@end
