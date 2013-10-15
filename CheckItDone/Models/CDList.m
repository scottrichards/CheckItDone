//
//  CDList.m
//  CheckItDone
//
//  Created by Scott Richards on 10/10/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDList.h"
#import "BNRItemStore.h"

@implementation CDList

- (id)init
{
    self = [super init];
    if (self) {
        self.taskList = [[BNRItemStore alloc] init];
    }
    
    return self;
}

@end
