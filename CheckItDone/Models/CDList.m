//
//  CDList.m
//  CheckItDone
//
//  Created by Scott Richards on 10/10/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDList.h"
#import "CDTaskStore.h"

@implementation CDList

- (id)init
{
    self = [super init];
    if (self) {
        self.taskList = [[CDTaskStore alloc] init];
    }
    
    return self;
}
#pragma mark Encoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_listName forKey:@"itemName"];
//    [aCoder encodeObject:_taskList forKey:@"taskList"];
   
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setListName:[aDecoder decodeObjectForKey:@"itemName"]];
 //       [self setTaskList:[aDecoder decodeObjectForKey:@"taskList"]];
    }
    return self;
}

@end
