//
//  main.cpp
//  67_StringToInt
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>

int main(int argc, const char * argv[]) {
    
    
    char *string = "486";
    
    int number = 0;
    
    while (*string != '\0') {
        number = number * 10 + *string - '0';
        string++;
    }
    
    printf("%i", number);
    
    return 0;
}
