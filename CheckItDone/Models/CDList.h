//
//  CDList.h
//  CheckItDone
//
//  Created by Scott Richards on 10/10/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CDTaskStore;

@interface CDList : NSObject <NSCoding>

@property (nonatomic, copy) NSString *listName;
@property (weak, nonatomic) NSString *name;
@property (strong, nonatomic) CDTaskStore *taskList;
@end
