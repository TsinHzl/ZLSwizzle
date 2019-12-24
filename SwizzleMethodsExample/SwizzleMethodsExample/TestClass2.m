//
//  TestClass2.m
//  SwizzleMethods
//
//  Created by MacBook on 2019/12/24.
//  Copyright © 2019 Harllan. All rights reserved.
//

#import "TestClass2.h"
#import "ZLSwizzle.h"



@implementation TestClass2

+ (void)load {
    //交换不同类 的  对象方法 (与自定义类TestClass1的test1交换)
    ZLSwizzlefDifferentClassInstanceMethod(NSClassFromString(@"TestClass1"), [self class], @selector(test1), @selector(test2));
    //交换不同类 的 对象方法  (与NSArray的containsObject:进行交换)
    ZLSwizzlefDifferentClassInstanceMethod(NSArray.class, [self class], @selector(containsObject:), @selector(test3:));
    //交换不同类 的 类方法  友好提示:自定义的方法可以写在任何的自定义类中
    ZLSwizzlefDifferentClassClassMethod(NSClassFromString(@"TestClass1"), [self class], @selector(sharedClass1), @selector(sharedClass2));
}

- (void)test2 {
    NSLog(@"test2");
    [self test2];
}
- (BOOL)test3:(id)obj {
    NSLog(@"test2");
    return [self test3:obj];
}

+ (void)sharedClass2 {
    NSLog(@"sharedClass2");
    [self sharedClass2];
}

@end
