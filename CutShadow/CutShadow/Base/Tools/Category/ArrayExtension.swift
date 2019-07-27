//
//  ArrayExtension.swift
//  Sierra
//
//  Created by 冯才凡 on 2018/6/25.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

import Foundation
extension Array {
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
