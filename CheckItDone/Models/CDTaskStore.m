//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Scott Richards on 9/13/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDTaskStore.h"
#import "CDTask.h"
#import "CDDataModel.h"
#import "CDAppDelegate.h"

@implementation CDTaskStore

+ (CDTaskStore *)sharedStore
{
    static CDTaskStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self) {
//        CDAppDelegate *appDelegate = [NSApp delegate];
  //      model = [[NSApp delegate] dataModel];
/*  ARCHIVE METHOD NO LONGER USED
        NSString *path = [self itemArchivePath];
        allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one
        if (!allItems)
            allItems = [[NSMutableArray alloc] init];
 */
        // Read in Homepwner.xcdatamodeld
       model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // Where does the SQLite file go?
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        // Create the managed object context
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        // The managed object context can manage undo, but we don't need it
        [context setUndoManager:nil];
        
        [self loadAllItems];
    }
    
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

- (CDTask *)createItem
{
 //    CDTask *p = [[CDTask alloc] init];
 
    double order;
    if ([allItems count] == 0) {
        order = 1.0;
    } else {
        order = [[allItems lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %d items, order = %.2f", [allItems count], order);
    
    CDTask *task = [NSEntityDescription insertNewObjectForEntityForName:@"CDTask"
                                               inManagedObjectContext:context];
    
    [task setOrderingValue:order];
    
    [allItems addObject:task];
    
    return task;
}

- (CDTask *)createBlankItem
{
    CDTask *p = [[CDTask alloc] init];
    
    [allItems addObject:p];
    
    return p;
}

- (void)removeItem:(CDTask *)task
{
    [allItems removeObjectIdenticalTo:task];
    [context deleteObject:task];
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    if (from == to) {
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    CDTask *task = [allItems objectAtIndex:from];
    
    // Remove task from array
    [allItems removeObjectAtIndex:from];
    
    // Insert task in array at new location
    [allItems insertObject:task atIndex:to];
    
    // Computing a new orderValue for the object that was moved
    double lowerBound = 0.0;
    
    // Is there an object before it in the array?
    if (to > 0) {
        lowerBound = [[allItems objectAtIndex:to - 1] orderingValue];
    } else {
        lowerBound = [[allItems objectAtIndex:1] orderingValue] - 2.0;
    }
    
    double upperBound = 0.0;
    
    // Is there an object after it in the array?
    if (to < [allItems count] - 1) {
        upperBound = [[allItems objectAtIndex:to + 1] orderingValue];
    } else {
        upperBound = [[allItems objectAtIndex:to - 1] orderingValue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    [task setOrderingValue:newOrderValue];
}


- (NSString *)itemArchivePath
{
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
//    return [documentDirectory stringByAppendingPathComponent:@"tasks.archive"];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    // returns success or failure
/* ARCHIVE METHOD DEPRECATED FOR Core Data
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:allItems
                                       toFile:path];
*/
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}


- (void)loadAllItems
{
    if (!allItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"CDTask"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allItems = [[NSMutableArray alloc] initWithArray:result];
    }
}
@end
