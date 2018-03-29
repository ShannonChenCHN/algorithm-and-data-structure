//
//  main.cpp
//  12_StringPathInMatrix
//
//  Created by ShannonChen on 2018/3/28.
//  Copyright © 2018年 ShannonChen. All rights reserved.
//

#include <iostream>


// 第12题：矩阵中的路径
// 题目：请设计一个函数，用来判断在一个矩阵中是否存在一条包含某字符串所有
// 字符的路径。路径可以从矩阵中任意一格开始，每一步可以在矩阵中向左、右、
// 上、下移动一格。如果一条路径经过了矩阵的某一格，那么该路径不能再次进入
// 该格子。
//
// 例如在下面的3×4的矩阵中包含一条字符串“bfce”的路径（路径中的字
// 母用下划线标出）。但矩阵中不包含字符串“abfb”的路径，因为字符串的第一个
// 字符b占据了矩阵中的第一行第二个格子之后，路径不能再次进入这个格子。
// A B T G
// C F C S
// J D E H


/*

 从第一行第一列开始扫描，判断当前元素是否在字符串中能匹配上，比如，上面的 0-1 能匹配 "bfce" 中的第一个字母 b，然后再看这个匹配的元素的上下左右是否也能匹配上，能就继续，不能就返回上一级，直到所有的字符都匹配上或者所有元素都扫描完。另外就是，扫描过的不再重复扫描。
 
 
               A
             /
           B*
         /  \
        T    F*
           / | \
          C* D  C*
        /      /  \
       J      S    E*
 
 
 这里采用的是回溯思想（暴力试错法的升级版），因为它适用于每一步都有多个选项的问题。用回溯法解决的问题的所有选项都可以形象地用树的结构来表示。所以从上面的解决思路中可以看到树和递归的影子。
 
*/

using namespace std;

bool HasPathCore(const char* matrix, int rowCount, int columnCount, int row, int column, const char* string, int& currentPathLenth, bool* visited);


bool HasPath(const char* matrix, int rowCount, int columnCount, const char* string) {
    if (matrix == nullptr || rowCount <= 0 || columnCount <= 0 || string == nullptr ) {
        return false;
    }
    
    // 创建保存访问记录的数组
    bool* visited = new bool[rowCount * columnCount];
    std::memset(visited, 0, rowCount * columnCount);
    
    int currentPathLenth = 0;
    for (int row = 0; row < rowCount; row++) {
        for (int column = 0; column < columnCount; column++) {
            
            if (HasPathCore(matrix, rowCount, columnCount, row, column, string, currentPathLenth, visited)) {
                delete[] visited;
                return true;
            }
        }
    }
    
    delete[] visited;
    
    return false;
}

bool HasPathCore(const char* matrix, int rowCount, int columnCount, int row, int column, const char* string, int& currentPathLenth, bool* visited) {
    
    // 路径查找完毕
    if(string[currentPathLenth] == '\0') {
        return true;
    }
    
    bool HasPath = false;
    if(row >= 0 && row < rowCount && column >= 0 && column < columnCount     // 不越界
       && matrix[row * columnCount + column] == string[currentPathLenth]     // 当前元素匹配成功
       && !visited[row * columnCount + column]) {                            // 避免重复查找
        
        ++currentPathLenth;
        visited[row * columnCount + column] = true;
        
        // 查找下一个
        HasPath = HasPathCore(matrix, rowCount, columnCount, row, column - 1,
                              string, currentPathLenth, visited)
        || HasPathCore(matrix, rowCount, columnCount, row - 1, column,
                       string, currentPathLenth, visited)
        || HasPathCore(matrix, rowCount, columnCount, row, column + 1,
                       string, currentPathLenth, visited)
        || HasPathCore(matrix, rowCount, columnCount, row + 1, column,
                       string, currentPathLenth, visited);
        
        // 下一个没有匹配上
        if(!HasPath) {
            --currentPathLenth;
            visited[row * columnCount + column] = false;
        }
    }
    
    return HasPath;
}

// ====================测试代码====================
void Test(const char* testName, const char* matrix, int rows, int cols, const char* str, bool expected)
{
    if(testName != nullptr)
        printf("%s begins: ", testName);
    
    if(HasPath(matrix, rows, cols, str) == expected)
        printf("Passed.\n");
    else
        printf("FAILED.\n");
}

//ABTG
//CFCS
//JDEH

//BFCE
void Test1()
{
    const char* matrix = "ABTGCFCSJDEH";
    const char* str = "BFCE";
    
    Test("Test1", (const char*) matrix, 3, 4, str, true);
}

//ABCE
//SFCS
//ADEE

//SEE
void Test2()
{
    const char* matrix = "ABCESFCSADEE";
    const char* str = "SEE";
    
    Test("Test2", (const char*) matrix, 3, 4, str, true);
}

//ABTG
//CFCS
//JDEH

//ABFB
void Test3()
{
    const char* matrix = "ABTGCFCSJDEH";
    const char* str = "ABFB";
    
    Test("Test3", (const char*) matrix, 3, 4, str, false);
}

//ABCEHJIG
//SFCSLOPQ
//ADEEMNOE
//ADIDEJFM
//VCEIFGGS

//SLHECCEIDEJFGGFIE
void Test4()
{
    const char* matrix = "ABCEHJIGSFCSLOPQADEEMNOEADIDEJFMVCEIFGGS";
    const char* str = "SLHECCEIDEJFGGFIE";
    
    Test("Test4", (const char*) matrix, 5, 8, str, true);
}

//ABCEHJIG
//SFCSLOPQ
//ADEEMNOE
//ADIDEJFM
//VCEIFGGS

//SGGFIECVAASABCEHJIGQEM
void Test5()
{
    const char* matrix = "ABCEHJIGSFCSLOPQADEEMNOEADIDEJFMVCEIFGGS";
    const char* str = "SGGFIECVAASABCEHJIGQEM";
    
    Test("Test5", (const char*) matrix, 5, 8, str, true);
}

//ABCEHJIG
//SFCSLOPQ
//ADEEMNOE
//ADIDEJFM
//VCEIFGGS

//SGGFIECVAASABCEEJIGOEM
void Test6()
{
    const char* matrix = "ABCEHJIGSFCSLOPQADEEMNOEADIDEJFMVCEIFGGS";
    const char* str = "SGGFIECVAASABCEEJIGOEM";
    
    Test("Test6", (const char*) matrix, 5, 8, str, false);
}

//ABCEHJIG
//SFCSLOPQ
//ADEEMNOE
//ADIDEJFM
//VCEIFGGS

//SGGFIECVAASABCEHJIGQEMS
void Test7()
{
    const char* matrix = "ABCEHJIGSFCSLOPQADEEMNOEADIDEJFMVCEIFGGS";
    const char* str = "SGGFIECVAASABCEHJIGQEMS";
    
    Test("Test7", (const char*) matrix, 5, 8, str, false);
}

//AAAA
//AAAA
//AAAA

//AAAAAAAAAAAA
void Test8()
{
    const char* matrix = "AAAAAAAAAAAA";
    const char* str = "AAAAAAAAAAAA";
    
    Test("Test8", (const char*) matrix, 3, 4, str, true);
}

//AAAA
//AAAA
//AAAA

//AAAAAAAAAAAAA
void Test9()
{
    const char* matrix = "AAAAAAAAAAAA";
    const char* str = "AAAAAAAAAAAAA";
    
    Test("Test9", (const char*) matrix, 3, 4, str, false);
}

//A

//A
void Test10()
{
    const char* matrix = "A";
    const char* str = "A";
    
    Test("Test10", (const char*) matrix, 1, 1, str, true);
}

//A

//B
void Test11()
{
    const char* matrix = "A";
    const char* str = "B";
    
    Test("Test11", (const char*) matrix, 1, 1, str, false);
}

void Test12()
{
    Test("Test12", nullptr, 0, 0, nullptr, false);
}

int main(int argc, char* argv[]) {
    
    Test1();
    Test2();
    Test3();
    Test4();
    Test5();
    Test6();
    Test7();
    Test8();
    Test9();
    Test10();
    Test11();
    Test12();
    
    return 0;
}
