//
//  AMAppDelegate.h
//  AMapNaviRepo
//
//  Created by Mofang on 14-2-21.
//  Copyright (c) 2014年 yaonphy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
