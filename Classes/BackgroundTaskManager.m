//
//  BackgroundExtensionManager.m
//  Pong
//
//  Created by Ades on 11/09/2015.
//  Copyright (c) 2015 Ades. All rights reserved.
//



#import "BackgroundTaskManager.h"



@implementation BackgroundTaskManager



static dispatch_queue_t backgroundTaskDispatchQueue;



#pragma mark -
#pragma mark Private Methods



+ (void)createBackgroundTaskDispatchQueue
{
    if (!backgroundTaskDispatchQueue)
    {
        backgroundTaskDispatchQueue = dispatch_queue_create("backgroundTaskManager.queue", 0);
    }
}



#pragma mark -
#pragma mark Public Methods



+ (UIBackgroundTaskIdentifier)startBackgroundTask:(void(^)(void))backgroundTask
                                expirationHandler:(void(^)(void))expirationHandler
                                         taskName:(NSString*)taskName
{
    [self createBackgroundTaskDispatchQueue];
    __block UIBackgroundTaskIdentifier _bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithName:taskName
                                                          expirationHandler:^
    {
        if (expirationHandler)
        {
            expirationHandler();
        }
        
        [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
        _bgTask = UIBackgroundTaskInvalid;
    }];
    
    dispatch_async(backgroundTaskDispatchQueue, ^
                   {
                       if (backgroundTask)
                       {
                           backgroundTask();
                       }
                       
                       if (expirationHandler)
                       {
                           expirationHandler();
                       }
                       
                       [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
                       _bgTask = UIBackgroundTaskInvalid;
                   });
    
    return _bgTask;
}


+ (void)cancelBackgroundTaskWithIdentifier:(UIBackgroundTaskIdentifier)backgroundTaskIdentifier
{
    if (backgroundTaskIdentifier != UIBackgroundTaskInvalid)
    {
        dispatch_suspend(backgroundTaskDispatchQueue);
    }
}


@end
