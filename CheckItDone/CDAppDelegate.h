//
//  CDAppDelegate.h
//  CheckItDone
//
//  Created by Scott Richards on 9/11/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class CDDataModel;
@interface CDAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) CDDataModel *dataModel;

@end
