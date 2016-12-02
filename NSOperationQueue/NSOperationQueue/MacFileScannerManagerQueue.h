//
//  MacFileScanner.h
//  NSOperationQueue
//
//  Created by Alex_WU on 16/7/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MacFileScannerManagerQueue : NSObject
+ (MacFileScannerManagerQueue *)shareFileScanner;

@property (nonatomic, assign) NSInteger maxConcurrentOperation;

- (void)addOperation:(NSOperation *)operation;
@end
