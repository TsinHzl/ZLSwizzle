//
//  main.m
//  SwizzleMethods
//
//  Created by MacBook on 2019/12/24.
//  Copyright © 2019 Harllan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestClass1.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        id obj = NSObject.new;
        id obj1 = NSObject.new;
        
        NSArray *arr = @[obj];
        BOOL succ1 = [arr containsObject:obj];
        BOOL succ2 = [arr containsObject:obj1];
        
//        [TestClass1 sharedClass1];
        
        NSLog(@"succ1 = %d, succ2 = %d",succ1,succ2);
    }
    return 0;
}
