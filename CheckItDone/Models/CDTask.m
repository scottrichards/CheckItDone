//
//  CDTask.m
//  CheckItDone
//
//  Created by Scott Richards on 10/16/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDTask.h"


@implementation CDTask

@dynamic name;
@dynamic date;
@dynamic orderingValue;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    NSTimeInterval t = [[NSDate date] timeIntervalSinceReferenceDate];
    [self setDate:t];
}

@end
