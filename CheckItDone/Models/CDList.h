//
//  CDList.h
//  CheckItDone
//
//  Created by Scott Richards on 10/18/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDList : NSManagedObject

@property (nonatomic, retain) NSString * listName;
@property (nonatomic) double orderingValue;

@end
