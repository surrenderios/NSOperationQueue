//
//  MacCacheConcurrenceOperation.m
//  NSOperationQueue
//
//  Created by Alex_Wu on 12/5/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "MacCacheConcurrenceOperation.h"

@interface MacCacheConcurrenceOperation ()
{
    BOOL _opExcuting;
    BOOL _opFinished;
}
@end

@implementation MacCacheConcurrenceOperation
- (instancetype)init
{
    if (self = [super init]) {
        _opExcuting = NO;
        _opFinished = NO;
    }
    return self;
}

- (void)main
{
    @try {
        
        for (int i = 0; i < 100; i++)
        {
            if([self isCancelled])
            {
                [self completeOperation];
            }
            
            NSLog(@">>>>%d",i);
        }
        
        
        [self completeOperation];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)completeOperation
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    _opExcuting = NO;
    _opFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
    
}


#pragma mark - NSOperation
- (void)start
{
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        [self willChangeValueForKey:@"isFinished"];
        _opFinished = YES;
        [self didChangeValueForKey:@"isFinished"];
        
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    _opExcuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (BOOL)isExecuting
{
    return _opExcuting;
}

- (BOOL)isFinished
{
    return _opFinished;
}

@end
