//
//  CDListStore.m
//  CheckItDone
//
//  Created by Scott Richards on 10/10/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDListStore.h"
#import "CDList.h"

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
        //        allItems = [[NSMutableArray alloc] init];
        NSString *path = [self itemArchivePath];
        allLists = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one
        if (!allLists)
            allLists = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (NSArray *)allLists
{
    return allLists;
}

- (CDList *)createList
{
    CDList *p = [[CDList alloc] init];
    
    [allLists addObject:p];
    
    return p;
}

- (CDList *)createBlankList
{
    CDList *list = [[CDList alloc] init];
    
    [list setListName:@"New List"];
    [allLists addObject:list];
    
    return list;
}

- (void)removeItem:(CDList *)p
{
    [allLists removeObjectIdenticalTo:p];
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    if (from == to) {
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    CDList *p = [allLists objectAtIndex:from];
    
    // Remove p from array
    [allLists removeObjectAtIndex:from];
    
    // Insert p in array at new location
    [allLists insertObject:p atIndex:to];
}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"lists.archive"];
}

- (BOOL)saveChanges
{
    // returns success or failure
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:allLists
                                       toFile:path];
}

@end
