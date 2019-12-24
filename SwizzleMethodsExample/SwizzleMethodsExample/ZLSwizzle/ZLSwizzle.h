//
//  ZLSwizzle.h
//  SwizzleMethods
//
//  Created by MacBook on 2019/12/24.
//  Copyright © 2019 Harllan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 class_getInstanceMethod实际上就是调用了runtime里写的IMP lookUpImpOrNil(Class cls, SEL sel, id inst, bool initialize, bool cache, bool resolver)函数，这个函数作用是在给定类的方法列表和方法cache列表中查找给定的方法的实现。
 这个方法会在以此从此类的cache和方法列表中查找这个方法的实现，一旦找到就存储在cache中并返回
 也就说这个方法获取到的方法实现可能会是父类甚至是父类的父类的方法实现
 同样的，在方法调用的时候，一样会首先执行这个查找方法。当你的子类和父类用一个同名的方法对另一个同名的方法进行交换之后，调用子类的那个方法时，就会出现循环调用的问题，最终导致程序crash。
 因此，在具有继承关系时，对同一个方法进行方法交换时，一定要将子类自定义的方法的名字和父类不一样才行，不然一定会出现魂环调用的问题
 */

/**
 @brief 替换类的类方法
 @param cls 要修改的类
 @param originalSelector 要替换的方法
 @param swizzledSelector 新的方法实现
 */
extern void ZLSwizzleClassMethod(Class cls, SEL originalSelector, SEL swizzledSelector);

/**
 @brief 替换类的对象方法
 @param cls 要修改的类
 @param originalSelector 要替换的方法
 @param swizzledSelector 新的方法实现
 */
extern void ZLSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector);

/**
@brief 交换不同类中两个  对象方法    友好提示:自定义的方法可以写在任何的自定义类中 ）
@param originalCls 被交换的类
@param swizzledCls 用来交换的类
@param originalSelector 被交换的方法
@param swizzledSelector 用来交换的方法
  */
extern void ZLSwizzlefDifferentClassInstanceMethod(Class originalCls,Class swizzledCls,SEL originalSelector, SEL swizzledSelector);


/**
@brief 交换不同类中两个  类方法 （  友好提示:自定义的方法可以写在任何的自定义类中 ）
@param originalCls 被交换的类
@param swizzledCls 用来交换的类
@param originalSelector 被交换的方法
@param swizzledSelector 用来交换的方法
  */
extern void ZLSwizzlefDifferentClassClassMethod(Class originalCls,Class swizzledCls,SEL originalSelector, SEL swizzledSelector);

