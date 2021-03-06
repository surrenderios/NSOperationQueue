//
//  AppDelegate.m
//  NSOperationQueue
//
//  Created by Alex_WU on 16/7/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "AppDelegate.h"
#import "MacCacheFileOperation.h"
#import "MacCacheConcurrenceOperation.h"

#import "MacFileScannerManagerQueue.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //create non-concurrence operation
    MacCacheFileOperation *operation = [[MacCacheFileOperation alloc]init];
    [operation startScanCacheFileWithStart:^{
        NSLog(@"start>>>>>>>>>>");
    } progress:^(NSInteger scanedPath, NSInteger totalPaths) {
        CGFloat percent = (CGFloat)scanedPath / (CGFloat)totalPaths;
        NSString *resultString =  [NSString stringWithFormat:@"%.0f",percent*100];
        NSLog(@"%@",resultString);
    } complete:^(BOOL isFinished, NSError *error) {
        NSLog(@"complete>>>>>>>%hhd %@",isFinished,error);
    } cancel:^{
        NSLog(@"cancel>>>>>>>>>");
    }];
    
    //create concurrence operation
    MacCacheConcurrenceOperation *asynOperation = [[MacCacheConcurrenceOperation alloc]init];
    
    [operation addDependency:asynOperation];
    
    MacFileScannerManagerQueue *scanner = [MacFileScannerManagerQueue shareFileScanner];
    [scanner addOperation:operation];
    [scanner addOperation:asynOperation];
}
@end
