//
//  BackgroundExtensionManager.h
//  Pong
//
//  Created by Ades on 11/09/2015.
//  Copyright (c) 2015 Ades. All rights reserved.
//



#import <Foundation/Foundation.h>



@interface BackgroundTaskManager : NSObject

+ (UIBackgroundTaskIdentifier)startBackgroundTask:(void(^)(void))backgroundTask
                                expirationHandler:(void(^)(void))expirationHandler
                                         taskName:(NSString*)taskName;
+ (void)cancelBackgroundTaskWithIdentifier:(UIBackgroundTaskIdentifier)backgroundTaskIdentifier;


@end
