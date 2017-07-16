//
//  MyOperation.m
//  FEOperation
//
//  Created by keso on 2017/7/14.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "MyOperation.h"

@interface MyOperation()

@property (strong, nonatomic) NSURL *url;

@end

@implementation MyOperation

- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self ;
}

- (void)main {
    
    @autoreleasepool {
        
        @try {
            sleep(1); // 下载图片
            NSLog(@"MyOperation:url地址:%@---当前线程 = %@",self.url,[NSThread currentThread]);
            NSLog(@"MyOperation:url地址:%@---主线程    = %@",self.url,[NSThread mainThread]);
//            NSLog(@"图片下载---%@",self.url);
        }
        @catch(...) {
            // Do not rethrow exceptions.
        }

    }
}

@end
