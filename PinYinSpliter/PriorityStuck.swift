//
//  PriorityStuck.swift
//  LogInput
//
//  Created by R0uter on 2016/10/18.
//  Copyright © 2016年 R0uter. All rights reserved.
//

import Foundation


/// 一个使用插入排序实现的栈，依照大小自动排序，越大越靠上。
struct PriorityStuck<T:Comparable> {
    fileprivate var rowList:[T] = []
    let maxLength:Int
    
    
    init(Length length:Int) {
        maxLength = length
    }
    
    mutating func append(_ newElement:T) {
        
        if maxLength == count && newElement < rowList.last! {
            return
        }
        if rowList.isEmpty {rowList.append(newElement);return}
        var middleIndex = Int(count/2)
        if newElement > rowList[middleIndex] {
            while middleIndex >= 0 {
                
                if newElement > rowList[middleIndex] {
                    if middleIndex == 0 {rowList.insert(newElement, at: 0);break}
                    middleIndex -= 1
                    continue
                }
                
                rowList.insert(newElement, at: middleIndex + 1)
                break
            }
        } else {
            while middleIndex < count {

                if newElement < rowList[middleIndex] {
                    if middleIndex == count - 1 {rowList.append(newElement);break}
                    middleIndex += 1
                    continue
                }
                rowList.insert(newElement, at: middleIndex)
                break
            }
        }
        if count > maxLength {rowList.removeLast()}
        
    }
    
    mutating func pop()->T? {
        guard count > 0 else {return nil}
        return rowList.removeFirst()
    }
    func peak()->T? {
        guard count > 0 else {return nil}
        return rowList[0]
    }
    
    var count:Int {
        return rowList.count
    }
    
//    func getList() -> [T] {
//        return rowList
//    }

}
extension PriorityStuck:Sequence {
    typealias Iterator = IndexingIterator<Array<T>>
    func makeIterator() -> PriorityStuck.Iterator {
        return rowList.makeIterator()
    }
}
