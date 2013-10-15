//
//  CDTableViewController.h
//  CheckItDone
//
//  Created by Scott Richards on 9/30/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDList;

@interface CDTableViewController : UITableViewController
{
//    IBOutlet UIView *headerView;
}

@property (strong, nonatomic) CDList *tableItem;

//- (UIView *)headerView;
//- (IBAction)toggleEditMode:(id)sender;
- (IBAction)addNewItem:(id)sender;

@end
