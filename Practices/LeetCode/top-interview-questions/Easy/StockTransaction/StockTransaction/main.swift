//
//  main.swift
//  StockTransaction
//
//  Created by ShannonChen on 2019/12/13.
//  Copyright © 2019 ShannonChen. All rights reserved.
//

import Foundation


/// Say you have an array for which the ith element is the price of a given stock on day i.
///
/// Design an algorithm to find the maximum profit. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times).
///
/// Note: You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).
///
/// Example 1:
///
/// Input: [7,1,5,3,6,4]
/// Output: 7
/// Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
///              Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
/// Example 2:
///
/// Input: [1,2,3,4,5]
/// Output: 4
/// Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
///              Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are
///              engaging multiple transactions at the same time. You must sell before buying again.
/// Example 3:
///
/// Input: [7,6,4,3,1]
/// Output: 0
/// Explanation: In this case, no transaction is done, i.e. max profit = 0.
///
/// 来源：力扣（LeetCode）
/// 链接：https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii
/// 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
func maxProfit(_ prices: [Int]) -> Int {
//    return mySolution(prices)
    return solution_03(prices)
}


/*
 思路：找出波峰和波谷，然后每次在最高点卖出
 时间复杂度：O(n)，空间复杂度：O(1)
 提交的时候，除语法错误外，有两处逻辑错误，一个是中间重复计算 profit，另一个是没考虑持平的情况
 */
func mySolution(_ prices: [Int]) -> Int {
    guard prices.count > 1 else {
              return 0
          }
          
          var minIndex = 0
          var maxIndex = 0
          var result = 0
          for (index, price) in prices.enumerated() {
              if (index == 0 && price > prices[index+1]) ||
              (index == prices.count-1 && price > prices[index-1]) ||
               (index > 0 && index < prices.count-1 && price > prices[index-1] && price >= prices[index+1]) { // 波峰
                  
                   maxIndex = index
                   
               // 到最高点卖出
              if maxIndex > minIndex {
                  let profit = prices[maxIndex] - prices[minIndex]
                  result = result + profit
                  
                  print("profit: ", profit ,"=", prices[maxIndex], "-", prices[minIndex])
                  
                  minIndex = maxIndex
              }
                   
              } else if (index == 0 && price < prices[index+1]) ||
              (index == prices.count-1 && price < prices[index-1]) ||
              (index > 0 && index < prices.count-1 && price <= prices[index-1] && price < prices[index+1])
              { // 波谷
                  minIndex = index
              } else {
                  // do nothing
              }
              
    
              
          }
          return result
}


/*
 官方解法一
 时间复杂度：O(n)，空间复杂度：O(1)
 思路：找到连续的波峰和波谷，遍历数组，先找波谷，只要下一个元素比当前元素小或者相等，就继续往前走，直到找到波谷，
      然后再继续往前走，找波峰，只要下一个元素比当前元素大或者相等，就继续往前走，直到找到波峰
 官方的解法这两层 While 循环用的很妙
 */
func solution_2(_ prices: [Int]) -> Int {
    guard prices.count > 1 else {
        return 0
    }
    
    var valley = prices.first ?? 0
    var peak = prices.first ?? 0
    var result = 0
    
    var i = 0
    while i < prices.count-1 { // 因为每次找波峰和波谷时都是拿下一个元素和当前元素作比较
        // 先找波谷
        while i < prices.count-1 && prices[i + 1] <= prices[i] {
            i = i + 1
        }
        valley = prices[i]
        
        // 再找波峰
        while i < prices.count-1 && prices[i + 1] >= prices[i] {
            i = i + 1
        }
        peak = prices[i]
        result = result + (peak - valley)
        print(peak, valley, result)
    }
    return result
}


/*
官方解法二（贪心）
时间复杂度：O(n)，空间复杂度：O(1)
思路：股票买卖策略有三种，单独交易日、连续上涨交易日和连续下跌交易日，我们只需要考虑单独交易日和连续上涨交易日；
     单独交易日的利润就是第一天买进，第二天卖出，也就是 `P2-P1`，连续上涨交易日的利润就是最低点买进最高点卖出，
    也就是 `Pn-P1`，连续上涨交易日的利润我们也可以看成是每天都买卖，第一天买，第二天卖出，第二天又再买入，
    第三天有卖出，也就是 `(P2-P1)+(P3-P2)+...+(Pn-P(n-1)) = Pn-P1`
*/
func solution_03(_ prices: [Int]) -> Int {
    guard prices.count > 1 else {
        return 0
    }
    
    var result = 0

    for i in 1..<prices.count {
        if prices[i] > prices[i - 1] {
            result = result + (prices[i] - prices[i - 1])
        }
    }
    
    return result
}

let prices = [3,2,6,5,0,3]
//let prices = [5,2,3,2,6,6,2,9,1,0,7,4,5,0]
print(maxProfit(prices))


/*
 
 总结：
 先想清楚再写代码；
 画图；
 考虑各种 Corner case；
 */
