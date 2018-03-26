//
//  Cell.swift
//  Slais
//
//  Created by 陈思羽 on 2018-03-18.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import Foundation

enum CellType {
    case image
    case text
    case color
}

class Cell {
    var range: Range?
    var type: CellType
    
    init(selected range: Range?, forCell type: CellType) {
        self.range = range
        self.type = type
    }
    
}

