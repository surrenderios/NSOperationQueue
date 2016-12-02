//
//  MacBaseOperation.m
//  NSOperationQueue
//
//  Created by Alex_WU on 16/7/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "MacBaseOperation.h"

@implementation MacBaseOperation
- (void)dealloc
{
    self.startBlock = nil;
    self.progressBlock = nil;
    self.completeBlock = nil;
    self.cancelBlock = nil;
}
@end
