//
//  MacBaseOperation.h
//  NSOperationQueue
//
//  Created by Alex_WU on 16/7/13.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  开始扫描
 */
typedef void(^MacScanOperationStartBlock)();

/**
 *  扫描进度
 *
 *  @param scanedPath 已经扫描的路径数量
 *  @param totalPaths 全部需要扫描的路径数量
 */
typedef void(^MacScanOperationProgressBlock)(NSInteger scanedPath, NSInteger totalPaths);

/**
 *  扫描结束
 *
 *  @param isFinished 是否结束
 *  @param error      错误描述
 */
typedef void(^MacScanOperationCompleteBlock)(BOOL isFinished, NSError *error);

/**
 *  取消扫描
 */
typedef void(^MacScanOperationCancelBlock)();


@interface MacBaseOperation : NSOperation
@property (nonatomic, copy) MacScanOperationStartBlock    startBlock;
@property (nonatomic, copy) MacScanOperationProgressBlock progressBlock;
@property (nonatomic, copy) MacScanOperationCompleteBlock completeBlock;
@property (nonatomic, copy) MacScanOperationCancelBlock   cancelBlock;
@end
