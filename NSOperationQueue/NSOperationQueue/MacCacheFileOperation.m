//
//  MacCacheFileOperation.m
//  NSOperationQueue
//
//  Created by Alex_WU on 16/7/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "MacCacheFileOperation.h"

@interface MacCacheFileOperation ()
@property (nonatomic, copy) NSURL *rootUrl;
@end

@implementation MacCacheFileOperation
- (instancetype)init
{
    if (self = [super init]) {
#warning replace me with your url path
        self.rootUrl = [NSURL URLWithString:@"your url path"];
    }
    return self;
}


- (void)startScanCacheFileWithStart:(MacScanOperationStartBlock)start
                           progress:(MacScanOperationProgressBlock)progress
                           complete:(MacScanOperationCompleteBlock)complete
                             cancel:(MacScanOperationCancelBlock)cancel;
{
    self.startBlock    = start;
    self.progressBlock = progress;
    self.completeBlock = complete;
    self.cancelBlock   = cancel;
}

- (void)stopScan
{
    [self cancel];
}


//non-comcurrent
- (void)main
{
    if (self.startBlock) { self.startBlock(); }
    
    //FIX ME : this is for count
    NSDirectoryEnumerator *countItr =
    [[NSFileManager defaultManager] enumeratorAtURL:self.rootUrl
                         includingPropertiesForKeys:nil
                                            options:(NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsPackageDescendants)
                                       errorHandler:nil];
    
    NSDirectoryEnumerator *enumItr =
    [[NSFileManager defaultManager] enumeratorAtURL:self.rootUrl
                         includingPropertiesForKeys:nil
                                            options:(NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsPackageDescendants)
                                       errorHandler:nil];
    
    //when called this method,the countItr will be exhausted
    NSInteger totalCount = countItr.allObjects.count;
    
    NSUInteger current = 0;
    for (__unused NSURL *url in enumItr)
    {
        if ([self isCancelled])
        {
            if (self.cancelBlock) { self.cancelBlock(); }
            break;
        }
        
        current ++;
        if (self.progressBlock) { self.progressBlock(current,totalCount); }
        
        // do some thing
    }
    if (self.completeBlock) { self.completeBlock(YES,nil); }
}
@end
