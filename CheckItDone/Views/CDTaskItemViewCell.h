//
//  CDItemViewCell.h
//  CheckItDone
//
//  Created by Scott Richards on 10/6/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UICheckbox;
@class CDTask;

@interface CDTaskItemViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
@property (weak, nonatomic) IBOutlet UICheckbox *doneCheckbox;
@property (strong, nonatomic) CDTask *item;

- (void)clickedCheckbox:(BOOL)boolValue;

@end
