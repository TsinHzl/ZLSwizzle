# ZLSwizzle
### 交换两个不同OC类的方法，以达到hook的效果

### 安装
- ```
  pod 'ZLSwizzle'
  ```

## 交换方法见头文件ZLSwizzle.h

#### 通过这个函数，你可以在自定义的任何类里面自定义需要拿去交换的方法，之后将自定义的方法以及该方法在的那个类对象传过去即可

#### 交换不同类的方法如下：

```objective-c
/**
@brief 交换不同类中两个  对象方法   （ 友好提示:自定义的方法可以写在任何的自定义类中 ）
@param originalCls 被交换的类
@param swizzledCls 用来交换的类
@param originalSelector 被交换的方法
@param swizzledSelector 用来交换的方法
  */
extern void ZLSwizzleDifferentClassInstanceMethod(Class originalCls,Class swizzledCls,SEL originalSelector, SEL swizzledSelector);


/**
@brief 交换不同类中两个  类方法 （  友好提示:自定义的方法可以写在任何的自定义类中 ）
@param originalCls 被交换的类
@param swizzledCls 用来交换的类
@param originalSelector 被交换的方法
@param swizzledSelector 用来交换的方法
  */
extern void ZLSwizzleDifferentClassClassMethod(Class originalCls,Class swizzledCls,SEL originalSelector, SEL swizzledSelector);
```

#### 交换相同类的方法如下：

```objective-c
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
```

无论是交换类方法，还是实例方法，通过我封装的方法，你都只需传入类对象即可，即是调用某个类或者对象的class方法，或者是通过NSClassFromString(@"ClassString")函数获取到的值传入即可

##### 详细代码如下：

```objective-c
#import "TestClass2.h"
#import "ZLSwizzle.h"



@implementation TestClass2

+ (void)load {
    //交换不同类 的  对象方法 (与自定义类TestClass1的test1交换)
    ZLSwizzleDifferentClassInstanceMethod(NSClassFromString(@"TestClass1"), [self class], @selector(test1), @selector(test2));
  
    //交换不同类 的 对象方法  (与NSArray的containsObject:进行交换)
    ZLSwizzleDifferentClassInstanceMethod(NSArray.class, [self class], @selector(containsObject:), @selector(test3:));
  
    //交换不同类 的 类方法  友好提示:自定义的方法可以写在任何的自定义类中
    ZLSwizzleDifferentClassClassMethod(NSClassFromString(@"TestClass1"), [self class], @selector(sharedClass1), @selector(sharedClass2));
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
```



