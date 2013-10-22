//
//  CDTask.h
//  CheckItDone
//
//  Created by Scott Richards on 10/16/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDTask : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) NSDate *date;
@property (nonatomic) double orderingValue;

@end
