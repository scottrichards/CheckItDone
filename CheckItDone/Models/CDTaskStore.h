//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Scott Richards on 9/13/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CDTask;
@class CDDataModel;

@interface CDTaskStore : NSObject
{
    NSMutableArray *allItems;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

@property (strong, nonatomic) CDDataModel *dataModel;

+ (CDTaskStore *)sharedStore;
- (NSArray *)allItems;
- (CDTask *)createItem;
- (CDTask *)createBlankItem;
- (void)removeItem:(CDTask *)p;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;
- (void)loadAllItems;

@end
