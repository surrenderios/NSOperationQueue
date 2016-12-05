//
//  NSOperationQueueTests.m
//  NSOperationQueueTests
//
//  Created by Alex_Wu on 12/2/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MacCacheFileOperation.h"

@interface NSOperationQueueTests : XCTestCase
@property (nonatomic, copy) MacScanOperationStartBlock    startBlock;
@property (nonatomic, copy) MacScanOperationProgressBlock progressBlock;
@property (nonatomic, copy) MacScanOperationCompleteBlock completeBlock;
@property (nonatomic, copy) MacScanOperationCancelBlock   cancelBlock;

@property (nonatomic, copy) NSURL *rootUrl;
@end

@implementation NSOperationQueueTests

- (void)setUp
{
    [super setUp];
    
    self.rootUrl = [NSURL URLWithString:@"file:///Users/Alex/Downloads/"];
    
    self.startBlock = ^{
        NSLog(@"start>>>>>>>>>>");
    };
    self.progressBlock = ^(NSInteger scanedPath, NSInteger totalPaths){
        CGFloat percent = (CGFloat)scanedPath / (CGFloat)totalPaths;
        NSString *resultString =  [NSString stringWithFormat:@"%.0f",percent*100];
        NSLog(@"%@",resultString);
    };
    self.completeBlock = ^(BOOL isFinished, NSError *error) {
        NSLog(@"complete>>>>>>>%hhd %@",isFinished,error);
    };
    self.cancelBlock = ^{
        NSLog(@"cancel>>>>>>>>>");
    };
}

- (void)tearDown
{
    [super tearDown];
}

//average 3.743
- (void)test_onceEnum
{
    [self measureBlock:^{
        NSLog(@"main start>>>>%f",CFAbsoluteTimeGetCurrent());
        
        if (self.startBlock) { self.startBlock(); }
        
        NSDirectoryEnumerator *enumItr =
        [[NSFileManager defaultManager] enumeratorAtURL:self.rootUrl
                             includingPropertiesForKeys:nil
                                                options:(NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsPackageDescendants)
                                           errorHandler:nil];
        
        NSInteger totalCount = 1000;
        NSUInteger current = 0;
        for (__unused NSURL *url in enumItr)
        {
            //            if ([self isCancelled])
            //            {
            //                if (self.cancelBlock) { self.cancelBlock(); }
            //                break;
            //            }
            
            current ++;
            if (self.progressBlock) { self.progressBlock(current,totalCount); }
            
            // do some thing
        }
        if (self.completeBlock) { self.completeBlock(YES,nil); }
    }];
}

//average 4.067
- (void)test_twiceEnum
{
    [self measureBlock:^{
        NSLog(@"main start>>>>%f",CFAbsoluteTimeGetCurrent());
        
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
//            if ([self isCancelled])
//            {
//                if (self.cancelBlock) { self.cancelBlock(); }
//                break;
//            }
            
            current ++;
            if (self.progressBlock) { self.progressBlock(current,totalCount); }
            
            // do some thing
        }
        if (self.completeBlock) { self.completeBlock(YES,nil); }
    }];
}

@end
