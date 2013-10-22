//
//  CDTableViewController.m
//  CheckItDone
//
//  Created by Scott Richards on 9/30/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDTableViewController.h"
#import "CDTaskStore.h"
#import "CDTask.h"
#import "CDList.h"
#import "CDTaskDetailViewController.h"
#import "CDTaskItemViewCell.h"

@interface CDTableViewController ()

@end

@implementation CDTableViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        
        [n setTitle:@"Tasks"];

        // Create a new bar button item that will send
        // addNewItem: to ItemsViewController
/*        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        
        // Set this bar button item as the right item in the navigationItem
        [[self navigationItem] setRightBarButtonItem:bbi]; */
        
//        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
        
         self.taskStore = [[CDTaskStore alloc] init];

    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIView *)headerView
{
    // If we haven't loaded the headerView yet...
    if (!headerView) {
        // Load HeaderView.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
/*        [self.editButton setImage:[UIImage imageNamed:@"Edit_Pencil"] forState:UIControlStateNormal];
        [self.newButton setImage:[UIImage imageNamed:@"Add"] forState:UIControlStateNormal]; */
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tv viewForHeaderInSection:(NSInteger)sec
{
    return [self headerView];
}

- (CGFloat)tableView:(UITableView *)tv heightForHeaderInSection:(NSInteger)sec
{
    // The height of the header view should be determined from the height of the
    // view in the XIB file
    return [[self headerView] bounds].size.height;
}



- (IBAction)toggleEditMode:(id)sender {
    // If we are currently in editing mode...
    if ([self isEditing]) {
        // Change text of button to inform user of state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        // Turn off editing mode
        [self setEditing:NO animated:YES];
        if (![[self.editField text]isEqualToString:self.tableItem.listName])
        {
            self.tableItem.listName = [self.editField text];
            [self.listName setText:self.tableItem.listName];
        }
        [self.listName setHidden:NO];
        [self.editField setHidden:YES];
    } else {
        [self.listName setHidden:YES];
        [self.editField setText:self.tableItem.listName];
        [self.editField setHidden:NO];
        // Change text of button to inform user of state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        // Enter editing mode
        [self setEditing:YES animated:YES];
    }
}

- (IBAction)addNewItem:(id)sender {
    // Create a new BNRItem and add it to the store
//    CDTask *newItem = [[CDTaskStore sharedStore] createItem];
    CDTask *newItem = [self.taskStore createItem];
    [newItem setValue:self.tableItem forKey:@"taskList"];
    CDTaskDetailViewController *detailViewController =
    [[CDTaskDetailViewController alloc] initForNewItem:YES];
//    [detailViewController self];
    [detailViewController setItem:newItem];
    [detailViewController setDelegate:self];
    
    [detailViewController setDismissBlock:^{
        [[self tableView] reloadData];
    }];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailViewController];
    
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.listName setText:self.tableItem.listName];
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"CDTaskItemViewCell" bundle:nil];

    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"CDTaskItemViewCell"];
}

- (void)loadList:(CDList *)list
{
    [self.taskStore loadList:list];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [[[CDTaskStore sharedStore] allItems] count];
    return [[self.taskStore allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSDateFormatter *dateFormatter /*, *longDateFormatter*/  = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    }
 /*   if (!longDateFormatter) {
        longDateFormatter = [[NSDateFormatter alloc] init];
        [longDateFormatter setDateFormat:@"MM/dd/yyyy 'at' hh:mm:ss a"];
    }
   */ 
    // Check for a reusable cell first, use that if it exists
    CDTaskItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDTaskItemViewCell"];
    
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[CDTaskItemViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"UITableViewCell"];
    }
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    CDTask *task = [[self.taskStore allItems]
                    objectAtIndex:[indexPath row]];
    
    [[cell taskName] setText:[task name]];
    if ([task date]) {
        [[cell dueDate] setText:[dateFormatter stringFromDate:[task date]]];
 /*       NSDate *now = [NSDate date];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:[NSDate date] toDate:[task date] options:0];
        NSInteger days = [components day];
        NSString *nowStr = [longDateFormatter stringFromDate:now];
        NSString *dateStr = [longDateFormatter stringFromDate:[task date]];
        NSLog(@"Now = %@, To = %@ # of Days: %d",nowStr,dateStr,days);
        if (days <= 0)  // if we are on or before the due date flag the date with red
            [[cell dueDate] setTextColor:[UIColor redColor]];
  */
    } else {
        [[cell dueDate] setText:@""];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CDTaskStore *taskStore = self.taskStore;
        NSArray *items = [taskStore allItems];
        CDTask *p = [items objectAtIndex:[indexPath row]];
        [taskStore removeItem:p];
        
        // We also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.taskStore moveItemAtIndex:[sourceIndexPath row]
                                        toIndex:[destinationIndexPath row]];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create and push Task Detail view controller.
    CDTaskDetailViewController *detailViewController = [[CDTaskDetailViewController alloc] init];

    [detailViewController setDismissBlock:^{
        [[self tableView] reloadData];
    }];

    [detailViewController setDelegate:self];
    NSArray *items = [self.taskStore allItems];
    CDTask *selectedItem = [items objectAtIndex:[indexPath row]];
    
    // Give detail view controller a pointer to the item object in row
    [detailViewController setItem:selectedItem];
    
    // Push it onto the top of the navigation controller's stack
    [[self navigationController] pushViewController:detailViewController
                                           animated:YES];
}



@end
