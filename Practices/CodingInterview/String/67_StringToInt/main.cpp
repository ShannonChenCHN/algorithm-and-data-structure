//
//  main.cpp
//  67_StringToInt
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>

// 题67：把字符串转换成整数
// 题目：请你写一个函数StrToInt，实现把字符串转换成整数这个功能。当然，不
// 能使用atoi或者其他类似的库函数。

/*

 
 基本思路：从前往后一次遍历各个字符，在将每一位转成数字后，将上一次计算得到的值乘以 10 加上当前位
 关于非法字符的处理：如果输入为 nullptr 或者空字符串、不包含‘0~9’的字符时，返回 0，同时设置一个标记错误的全局变量；值得注意的是，如果第一个有效位为‘+’或者‘-’时，也是合法的。
 溢出的处理： 由于返回的是 int 类型，在 Mac 上是占 4 个字节（32位），取值范围为 -2^31 ~ 2^31-1
 C语言库在 limits.h 中包含了极大INT_MAX (2147483647) 和极小 INT_MIN (-2147483648)的整数值的宏定义，直接调用就可以了  
 
 */

enum Status {
    kValid = 0,
    kInvalid
};
int g_nStatus = kValid;

int strToInt(char* string) {
    if (string == NULL) {
        g_nStatus = kInvalid;
        return 0;
    }
    
    long long number = 0; // 这里用 long long 是为了后面能够有足够的空间来存储大数值，并与上下阈值进行比较
    
    bool hasStarted = false;
    bool isNegtive = false;
    while (*string != '\0') {
        // '+123', '  -34', '54.33', '56yy', 'yy566', '-s', '  -f'
        if (!hasStarted) { // 还没开始
            if (*string >= '0' && *string <= '9') {
                // 数字
                hasStarted = true;
                continue;
            } else if (*string == ' ') {
                // 空格

                string++;
                continue;
            } else if (*string == '+' || *string == '-') {
                // 符号位
                hasStarted = true;
                isNegtive = (*string == '-');
                string++;
                continue;
            } else {
                // 非法的开头
                g_nStatus = kInvalid;
                number = 0;
                break;
            }
            
        } else {
            
            if (*string >= '0' && *string <= '9') {
                // 是数字
                int flag = isNegtive ? -1 : 1;
                number = number * 10 + flag * (*string - '0');
                
                if ((isNegtive && number < INT_MIN) ||
                     (!isNegtive && number > INT_MAX)) {
                    g_nStatus = kInvalid;
                    number = 0;
                    break;
                }
                
                string++;
            } else {
                // 不是数字
                
                string--; // 看前一位是不是符号位
                if (*string == '+' || *string == '-') {
                    // 前一位是符号位  '-fg'
                    g_nStatus = kInvalid;
                    number = 0;
                    break;
                } else {
                    break;
                }
            }
        }
    
    }
    
    return (int)number;
}

int main(int argc, const char * argv[]) {
    
    // '+123', '  -34', '54.33', '56yy', 'yy566', '-s', '  -f'
    char string[] = "-4862479487989794s";
    
    printf("%d", strToInt(string));
    
    return 0;
}
