//
//  MacFileScanner.m
//  NSOperationQueue
//
//  Created by Alex_WU on 16/7/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "MacFileScannerManagerQueue.h"

@interface MacFileScannerManagerQueue ()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

@implementation MacFileScannerManagerQueue

#pragma mark - init scanner
+ (MacFileScannerManagerQueue *)shareFileScanner;
{
    static MacFileScannerManagerQueue *scanner = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scanner = [[MacFileScannerManagerQueue alloc]init];
    });
    return scanner;
}

- (instancetype)init
{
    if (self = [super init]) {
        _operationQueue = [[NSOperationQueue alloc]init];
        _maxConcurrentOperation = 1;
    }
    return self;
}

#pragma mark - add operation to operationQueue
- (void)addOperation:(NSOperation *)operation;
{
    [self.operationQueue addOperation:operation];
}
@end
