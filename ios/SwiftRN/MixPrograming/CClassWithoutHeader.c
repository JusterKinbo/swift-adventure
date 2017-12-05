//
//  CClassWithoutHeader.c
//  New2SwiftByCodes
//
//  Created by bjjiachunhui on 2017/8/24.
//  Copyright © 2017年 bjjiachunhui. All rights reserved.
//

#include <stdio.h>
//1.定义函数
int sum1(int a, int b)
{
    return a+b;
}

void desc1(){
    //2.声明函数指针
    int (*p)(int, int);
    
    //3.函数指针指向函数
    p = sum1;
    
    //4.使用
    int result = p(10,20);
    
    printf("swift调用C函数输出result:%d\n",result);
}
