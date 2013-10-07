//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Scott Richards on 9/13/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
}

+ (BNRItemStore *)sharedStore;
- (NSArray *)allItems;
- (BNRItem *)createItem;
- (BNRItem *)createBlankItem;
- (void)removeItem:(BNRItem *)p;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;
- (NSString *)itemArchivePath;
- (BOOL)saveChanges;

@end
