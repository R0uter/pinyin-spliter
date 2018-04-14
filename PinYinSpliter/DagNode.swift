//
//  DagNode.swift
//  LogInput
//
//  Created by R0uter on 2016/10/18.
//  Copyright © 2016年 R0uter. All rights reserved.
//

import Foundation
class DagNode {
    var path:[String] = []
    var weight:Double = 0.0
//    var length:Int {
//        var n = 0
//        for py in path {
//            n += py.count
//        }
//        return n
//    }
    var hashValue: Int {
        return self.path.joined().hashValue
    }
    
}
extension DagNode:Comparable {
    static func ==(lhs: DagNode, rhs: DagNode) -> Bool {
        return lhs.weight == rhs.weight
    }
    static func > (lhs: DagNode, rhs: DagNode) -> Bool {
        return lhs.weight > rhs.weight
    }
    static func <(lhs: DagNode, rhs: DagNode) -> Bool {
        return lhs.weight < rhs.weight
    }
    public static func <=(lhs: DagNode, rhs: DagNode) -> Bool {
        return lhs.weight <= rhs.weight
    }
    public static func >=(lhs: DagNode, rhs: DagNode) -> Bool {
        return lhs.weight >= rhs.weight
    }
}
