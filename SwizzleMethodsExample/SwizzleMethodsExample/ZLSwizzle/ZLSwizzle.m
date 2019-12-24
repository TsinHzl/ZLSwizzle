//
//  ZLSwizzle.m
//  SwizzleMethods
//
//  Created by MacBook on 2019/12/24.
//  Copyright © 2019 Harllan. All rights reserved.
//

#import "ZLSwizzle.h"
#import <objc/runtime.h>


/**
@brief 替换类的类方法
@param cls 要修改的类
@param originalSelector 要替换的方法
@param swizzledSelector 新的方法实现
*/
void ZLSwizzleClassMethod(Class cls, SEL originalSelector, SEL swizzledSelector) {
    if (!cls) {
        NSLog(@"交换方法失败--请保证交换的类名不为空");
        return;
    }
    
    if (!originalSelector || !swizzledSelector) {
        NSLog(@"交换方法失败--请保证交换的方法名不为空");
        return;
    }
    
    Class originalMetaCls = object_getClass(cls);
    Class swizzledMetaCls = object_getClass(cls);
    
    Method originalMethod = class_getClassMethod(originalMetaCls, originalSelector);
    Method swizzledMethod = class_getClassMethod(swizzledMetaCls, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(originalMetaCls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(originalMetaCls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

/**
@brief 替换类的对象方法
@param cls 要修改的类
@param originalSelector 要替换的方法
@param swizzledSelector 新的方法实现
*/
void ZLSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector) {
    if (!cls) {
        NSLog(@"交换方法失败--请保证交换的类名不为空");
        return;
    }
    
    if (!originalSelector || !swizzledSelector) {
        NSLog(@"交换方法失败--请保证交换的方法名不为空");
        return;
    }
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(cls,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


/**
@brief 交换不同类中两个  对象方法    友好提示:自定义的方法可以写在任何的自定义类中 ）
@param originalCls 被交换的类
@param swizzledCls 用来交换的类
@param originalSelector 被交换的方法
@param swizzledSelector 用来交换的方法
  */
void ZLSwizzleDifferentClassInstanceMethod(Class originalCls,Class swizzledCls,SEL originalSelector, SEL swizzledSelector) {
    if (!originalCls || !swizzledCls) {
        NSLog(@"交换方法失败--请保证交换的类名不为空");
        return;
    }
    
    if (!originalSelector || !swizzledSelector) {
        NSLog(@"交换方法失败--请保证交换的方法名不为空");
        return;
    }
    
    Method originalMethod = class_getInstanceMethod(originalCls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledCls, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(originalCls,
                                        swizzledSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        method_exchangeImplementations(originalMethod, class_getInstanceMethod(originalCls, swizzledSelector));
    } else {
        NSLog(@"交换方法失败--添加方法失败");
    }
    
}

/**
@brief 交换不同类中两个  类方法 （  友好提示:自定义的方法可以写在任何的自定义类中 ）
@param originalCls 被交换的类
@param swizzledCls 用来交换的类
@param originalSelector 被交换的方法
@param swizzledSelector 用来交换的方法
  */
void ZLSwizzleDifferentClassClassMethod(Class originalCls,Class swizzledCls,SEL originalSelector, SEL swizzledSelector) {
    if (!originalCls || !swizzledCls) {
        NSLog(@"交换方法失败--请保证交换的类名不为空");
        return;
    }
    
    if (!originalSelector || !swizzledSelector) {
        NSLog(@"交换方法失败--请保证交换的方法名不为空");
        return;
    }
    
    Class originalMetaCls = object_getClass(originalCls);
    Class swizzledMetaCls = object_getClass(swizzledCls);
    
    Method originalMethod = class_getClassMethod(originalMetaCls, originalSelector);
    Method swizzledMethod = class_getClassMethod(swizzledMetaCls, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(originalMetaCls,
                                        swizzledSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        method_exchangeImplementations(originalMethod, class_getClassMethod(originalMetaCls, swizzledSelector));
    } else {
        NSLog(@"交换方法失败--添加方法失败");
    }
    
}
