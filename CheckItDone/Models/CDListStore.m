//
//  CDListStore.m
//  CheckItDone
//
//  Created by Scott Richards on 10/10/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDListStore.h"
#import "CDList.h"
#import "CDAppDelegate.h"
#import "CDDataModel.h"

@implementation CDListStore

+ (CDListStore *)sharedStore
{
    static CDListStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self) {
        CDAppDelegate *appDelegate = (CDAppDelegate *)[[UIApplication sharedApplication] delegate];
        CDDataModel *dataModel = [appDelegate dataModel];
        self.dataModel = dataModel;
        model = self.dataModel->model;
        context = dataModel->context;
        [self loadAllItems];
    }
    
    return self;
}


- (NSArray *)allLists
{
    return allLists;
}

- (CDList *)createBlankList
{
    static int listNum = 0;
    
    double order;
    if ([allLists count] == 0) {
        order = 1.0;
    } else {
        order = [[allLists lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %d items, order = %.2f", [allLists count], order);
    
    CDList *list = [NSEntityDescription insertNewObjectForEntityForName:@"CDList"
                                                 inManagedObjectContext:self.dataModel->context];
    
    [list setOrderingValue:order];
    
    NSString *listName = [NSString stringWithFormat:@"List #%d",listNum++];
    [list setListName:listName];
    [allLists addObject:list];
    
    return list;
}

- (void)removeItem:(CDList *)list
{
    [allLists removeObjectIdenticalTo:list];
    [context deleteObject:list];
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    if (from == to) {
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    CDList *list = [allLists objectAtIndex:from];
    
    // Remove p from array
    [allLists removeObjectAtIndex:from];
    
    // Insert p in array at new location
    [allLists insertObject:list atIndex:to];
    
    // Computing a new orderValue for the object that was moved
    double lowerBound = 0.0;
    
    // Is there an object before it in the array?
    if (to > 0) {
        lowerBound = [[allLists objectAtIndex:to - 1] orderingValue];
    } else {
        lowerBound = [[allLists objectAtIndex:1] orderingValue] - 2.0;
    }
    
    double upperBound = 0.0;
    
    // Is there an object after it in the array?
    if (to < [allLists count] - 1) {
        upperBound = [[allLists objectAtIndex:to + 1] orderingValue];
    } else {
        upperBound = [[allLists objectAtIndex:to - 1] orderingValue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    [list setOrderingValue:newOrderValue];
}

- (void)loadAllItems
{
    if (!allLists) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"CDList"];
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
        
        allLists = [[NSMutableArray alloc] initWithArray:result];
    }
}

@end
