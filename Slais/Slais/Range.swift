//
//  Range.swift
//  Slais
//
//  Created by 陈思羽 on 2018-03-18.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import Foundation

class Range {
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    
    init(x: Int, y: Int, width: Int, height: Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

extension Range: CustomDebugStringConvertible {
    var debugDescription: String {
        return "x: \(x), y: \(y), width: \(width), height: \(height)"
    }
    
    
}
