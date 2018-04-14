//
//  PinyinSpliter.swift
//  PinYinSpliter
//
//  Created by R0uter on 4/14/18.
//  Copyright © 2018 R0uter. All rights reserved.
//

import Foundation
class PinyinSpliter {
    static let pyfreq = NSDictionary(contentsOfFile: "pyfreq.plist")!
    
    
    class func split(py:String)-> [([String],Double)] {
        var D:[Int:PriorityStuck<DagNode>] = [:]
        for toIndex in 1...7 {
            guard toIndex <= py.count else {break}
            let phrase = py.subString(from: 0, to: toIndex)
            if let weight = pyfreq.value(forKey: phrase) as? Double {
                let dagNode = DagNode()
                dagNode.path = [phrase]
                dagNode.weight = weight
                if  D[toIndex] == nil {
                    D[toIndex] = PriorityStuck<DagNode>(Length:3)
                }
                D[toIndex]!.append(dagNode)
            }
        }
        for fromIndex in 1..<py.count {

            guard let prevPath = D[fromIndex] else {
                continue
            }
            for toIndex in fromIndex...fromIndex+7 {
                guard toIndex <= py.count else {break}
                let phrase = py.subString(from: fromIndex, to: toIndex)
                guard let weight = pyfreq.value(forKey: phrase) as? Double else {
                    continue
                }
                for prevItem in prevPath {
                    
                    let dagNode = DagNode()
                    dagNode.path = prevItem.path + [phrase]
                    dagNode.weight = prevItem.weight * weight
                    if  D[toIndex] == nil {
                        D[toIndex] = PriorityStuck<DagNode>(Length:3)
                    }
                    D[toIndex]!.append(dagNode)
                    
                }
            }
        }
        var r:[([String],Double)] = []
        for i in (1...py.count).reversed() {
            if let result = D[i] {
                for node in result {
                    let table = node.path
                    r.append((table,node.weight))
                }
                break
            }
        }
        return r
    }
}
extension String {
    
    /// 用数字切字符串 [0,count)
    ///
    /// - Parameters:
    ///   - from: 开始位置，最小为0
    ///   - to: 结束位置，最大为字符串长度
    /// - Returns: 返回新的字符串
    func subString(from:Int,to:Int) -> String {
        guard from < to && to <= self.count else {return ""}
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex ..< endIndex])
    }
    
    /// 从某位置开始直到字符串的末尾
    ///
    /// - Parameter from: 最小为0，最大不能超过字符串长度
    /// - Returns: 新的字符串
    func subString(from:Int) -> String {
        guard from < self.count else {return ""}
        let startIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[startIndex ..< self.endIndex])
    }
    
    
    /// 从头开始直到某位置停止，不包含索引位置[0,int),如果是负数则从后往前数n位
    ///
    /// - Parameter to: 要停止的位置，不包含这个位置
    /// - Returns: 新的字符串
    func subString(to:Int) -> String {
        guard to <= self.count else {return ""}
        if to < 0 {
            let endIndex = self.index(self.endIndex, offsetBy: to)
            return String(self[self.startIndex ..< endIndex])
        }
        let startIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[self.startIndex ..< startIndex])
    }
    
}
