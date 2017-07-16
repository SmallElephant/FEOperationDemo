//
//  ViewController.m
//  FEOperation
//
//  Created by keso on 2017/7/14.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "ViewController.h"
#import "MyOperation.h"
#import "ViewController.h"
#import "ConOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self testOperation];
//    [self testOperationQueue];
//    [self testOperationQueue1];
//    [self testOperationQueue2];
//    [self testOperationQueue3];
//    [self testOperationQueue4];
//    [self testOperationQueue5];
//    [self testOperationQueue6];
    [self testOperationQueue7];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testOperation {
    
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"NSBlockOperation执行任务");
//    }];
//    [operation start];
    
}

- (void)testOperationQueue {
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(2);
//        NSLog(@"NSBlockOperation执行任务");
//    }];
//
//    [queue addOperations:@[operation] waitUntilFinished:YES];
//    
//    NSLog(@"NSOperationQueue任务执行完成");
    

}

- (void)testOperationQueue1 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        sleep(2);
        NSLog(@"NSBlockOperation执行任务");
    }];
    
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationInvocation) object:nil];
    
    [invocationOperation addDependency:operation];
    
    [queue addOperations:@[operation,invocationOperation] waitUntilFinished:YES];
    
    NSLog(@"NSOperationQueue任务执行完成");
}

- (void)operationInvocation {
    NSLog(@"NSInvocationOperation执行任务");
}

- (void)testOperationQueue2 {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        sleep(2);
        NSLog(@"mainQueue主队列执行任务");
    }];
    
    NSLog(@"任务执行完成");
}

- (void)testOperationQueue3 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSMutableArray *operations = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 10; i++) {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            sleep(1);
            NSLog(@"NSBlockOperation执行任务--%ld",i);
        }];
        
        [operations addObject:operation];
    }
    
    queue.maxConcurrentOperationCount = 3;
    
    [queue setSuspended:YES];
    
    NSLog(@"程序挂起");
    
    sleep(2);
    
    [queue setSuspended:NO];
    
    NSLog(@"继续执行");
    
    [queue addOperations:operations waitUntilFinished:YES];
    
    NSLog(@"NSOperationQueue任务执行完成");
}

- (void)testOperationQueue4 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSMutableArray *operations = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 1; i <= 10; i++) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%ld---http://www.jianshu.com/u/24da48b2ddb3",i]];
        MyOperation *operation = [[MyOperation alloc] initWithUrl:url];
        [operations addObject:operation];
    }
    
    queue.maxConcurrentOperationCount = 5;
    
    [queue addOperations:operations waitUntilFinished:YES];
    
    NSLog(@"NSOperationQueue任务执行完成");
}

- (void)testOperationQueue5 {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"1---http://www.jianshu.com/u/24da48b2ddb3"]];
    MyOperation *operation = [[MyOperation alloc] initWithUrl:url];
    [operation start];
    NSLog(@"MyOperation执行完成");
}

- (void)testOperationQueue6 {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"1---http://www.jianshu.com/u/24da48b2ddb3"]];
    ConOperation *operation1 = [[ConOperation alloc] initWithUrl:url];
    [operation1 start];
    NSLog(@"ConOperation执行完成");
}


- (void)testOperationQueue7 {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"1---http://www.jianshu.com/u/24da48b2ddb3"]];
    ConOperation *operation1 = [[ConOperation alloc] initWithUrl:url];
    [operation1 performOperation:operation1];
    NSLog(@"ConOperation执行完成");
}

@end
