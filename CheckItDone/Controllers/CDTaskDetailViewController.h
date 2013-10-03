//
//  CDTaskDetailViewController.h
//  CheckItDone
//
//  Created by Scott Richards on 10/3/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRItem.h"

@interface CDTaskDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
- (IBAction)editDate:(id)sender;
@property (nonatomic, strong) BNRItem *item;
@end
