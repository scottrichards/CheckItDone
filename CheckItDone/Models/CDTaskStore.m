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
#import "CDList.h"

@implementation CDTaskStore

/*
+ (CDTaskStore *)sharedStore:(CDList *)list
{
    static CDTaskStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    
    return sharedStore;
}
*/
- (id)init
{
    self = [super init];
    if (self) {
        CDAppDelegate *appDelegate = (CDAppDelegate *)[[UIApplication sharedApplication] delegate];
        CDDataModel *dataModel = [appDelegate dataModel];
        self.dataModel = dataModel;
    }
    
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

- (CDTask *)createItem
{
 
    double order;
    if ([allItems count] == 0) {
        order = 1.0;
    } else {
        order = [[allItems lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %d items, order = %.2f", [allItems count], order);
    
    CDTask *task = [NSEntityDescription insertNewObjectForEntityForName:@"CDTask"
                                               inManagedObjectContext:self.dataModel->context];
    
    [task setOrderingValue:order];
    
    [allItems addObject:task];
    
    return task;
}


- (void)removeItem:(CDTask *)task
{
    [allItems removeObjectIdenticalTo:task];
    [self.dataModel->context deleteObject:task];
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

- (void)loadList:(CDList *)list
{
    if (!allItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSPredicate *predicate = [NSPredicate
                                  predicateWithFormat:@"taskList = %@", list];
        [request setPredicate:predicate];
        
        NSEntityDescription *e = [[self.dataModel->model entitiesByName] objectForKey:@"CDTask"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [self.dataModel->context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

/*
- (void)loadAllItems
{
    if (!allItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];

        NSPredicate *predicate = [NSPredicate
                                  predicateWithFormat:@"taskList = %@", self.taskList];
        [request setPredicate:predicate];
        
        NSEntityDescription *e = [[self.dataModel->model entitiesByName] objectForKey:@"CDTask"];
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
 */
@end
