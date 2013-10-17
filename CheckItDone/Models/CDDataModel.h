//
//  CDDataModel.h
//  CheckItDone
//
//  Created by Scott Richards on 10/17/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CDDataModel : NSObject
{
    @public
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

//@property (strong,nonatomic) NSManagedObjectContext *context;
//@property (strong,nonatomic) NSManagedObjectModel *model;

- (NSString *)itemArchivePath;
- (BOOL)saveChanges;
@end
