//
//  CDListNameViewController.h
//  CheckItDone
//
//  Created by Scott Richards on 10/21/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDList;
@class CDListViewController;

@interface CDListNameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (strong, nonatomic) CDList *item;
@property (nonatomic, copy) void (^deleteList)(void);
@property (nonatomic, copy) void (^createList)(void);
@property (strong, nonatomic) CDListViewController *delegate;

@end
