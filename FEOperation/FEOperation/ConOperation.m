//
//  ConOperation.m
//  FEOperation
//
//  Created by keso on 2017/7/15.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "ConOperation.h"

@interface ConOperation()  {
    BOOL        executing;
    BOOL        finished;
}

@property (strong, nonatomic) NSURL *url;

- (void)completeOperation;

@end

@implementation ConOperation

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
        executing = NO;
        finished = NO;
    }
    return self ;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)start {
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @autoreleasepool {
        @try {
            
            // Do the main work of the operation here.
            
            sleep(1); // 下载图片或其他耗时操作
            
            NSLog(@"ConOperation:url地址:%@---当前线程---%@",self.url,[NSThread currentThread]);
            NSLog(@"ConOperation:url地址:%@---主线程---%@",self.url,[NSThread mainThread]);
            
            [self completeOperation];
        }
        @catch(...) {
            // Do not rethrow exceptions.
        }
    }
}

- (void)completeOperation {
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)performOperation:(NSOperation*)anOp {
    BOOL        ranIt = NO;
    
    if ([anOp isReady] && ![anOp isCancelled])
    {
        if (![anOp isConcurrent])
            [anOp start];
        else
            [NSThread detachNewThreadSelector:@selector(start)
                                     toTarget:anOp withObject:nil];
        ranIt = YES;
    }
    else if ([anOp isCancelled])
    {
        // If it was canceled before it was started,
        //  move the operation to the finished state.
        [self willChangeValueForKey:@"isFinished"];
        [self willChangeValueForKey:@"isExecuting"];
        executing = NO;
        finished = YES;
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
        
        // Set ranIt to YES to prevent the operation from
        // being passed to this method again in the future.
        ranIt = YES;
    }
    return ranIt;
}



@end
