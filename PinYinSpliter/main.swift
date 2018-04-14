//
//  main.swift
//  PinYinSpliter
//
//  Created by R0uter on 4/14/18.
//  Copyright © 2018 R0uter. All rights reserved.
//

import Foundation

let result = PinyinSpliter.split(py: "xian")
for i in result {
    print(i.0.joined(separator: "/"),i.1)
}

