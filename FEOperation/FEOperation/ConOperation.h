//
//  ConOperation.h
//  FEOperation
//
//  Created by keso on 2017/7/15.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConOperation : NSOperation

- (instancetype)initWithUrl:(NSURL *)url;

- (BOOL)performOperation:(NSOperation*)anOp;

@end
