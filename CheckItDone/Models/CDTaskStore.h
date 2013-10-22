//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Scott Richards on 9/13/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CDTask;
@class CDList;
@class CDDataModel;

@interface CDTaskStore : NSObject
{
    NSMutableArray *allItems;
}

@property (strong, nonatomic) CDDataModel *dataModel;
@property (strong, nonatomic) CDList *taskList;

- (NSArray *)allItems;
- (CDTask *)createItem;
- (void)removeItem:(CDTask *)p;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;
- (void)loadList:(CDList *)list;
- (id)init;

@end
