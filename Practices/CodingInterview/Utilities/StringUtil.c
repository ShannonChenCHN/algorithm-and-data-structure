//
//  StringUtil.c
//  58_01_ReverseWordsInSentence
//
//  Created by ShannonChen on 2018/6/4.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include "StringUtil.h"



void ReverseString(char *pBegin, char *pEnd) {
    if (pBegin == NULL || pEnd == NULL) {
        return;
    }
    
    while (pBegin < pEnd) {
        
        char temp = *pBegin;
        *pBegin = *pEnd;
        *pEnd = temp;
        
        pBegin++;
        pEnd--;
    }
}
