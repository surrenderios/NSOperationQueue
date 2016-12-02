//
//  MacCacheFileOperation.h
//  NSOperationQueue
//
//  Created by Alex_WU on 16/7/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "MacBaseOperation.h"

@interface MacCacheFileOperation : MacBaseOperation

- (void)startScanCacheFileWithStart:(MacScanOperationStartBlock)start
                         progress:(MacScanOperationProgressBlock)progress
                           complete:(MacScanOperationCompleteBlock)complete
                             cancel:(MacScanOperationCancelBlock)cancel;
- (void)stopScan;
@end
