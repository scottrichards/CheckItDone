//
//  CDTableViewController.h
//  CheckItDone
//
//  Created by Scott Richards on 9/30/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDList;
@class CDTaskStore;

@interface CDTableViewController : UITableViewController
{
    IBOutlet UIView *headerView;
}
@property (strong, nonatomic) IBOutlet UILabel *listName;
@property (weak, nonatomic) IBOutlet UITextField *editField;


@property (strong, nonatomic) CDList *tableItem;
@property (strong, nonatomic) CDTaskStore *taskStore;

- (UIView *)headerView;
- (IBAction)toggleEditMode:(id)sender;
- (IBAction)addNewItem:(id)sender;

- (void)loadList:(CDList *)list;
@end
