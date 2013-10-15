//
//  CDListStore.h
//  CheckItDone
//
//  Created by Scott Richards on 10/10/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDList.h"

@interface CDListStore : NSObject
{
    NSMutableArray *allLists;
}

+ (CDListStore *)sharedStore;
- (NSArray *)allLists;
- (CDList *)createList;
- (CDList *)createBlankList;
- (void)removeItem:(CDList *)p;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;
- (NSString *)itemArchivePath;
- (BOOL)saveChanges;
@end
