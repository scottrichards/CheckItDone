//
//  CDDataModel.m
//  CheckItDone
//
//  Created by Scott Richards on 10/17/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDDataModel.h"

@implementation CDDataModel

- (id)init
{
    self = [super init];
    if (self) {
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
        
    }
    
    return self;
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
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

@end
