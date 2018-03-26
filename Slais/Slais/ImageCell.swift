//
//  ImageCell.swift
//  Slais
//
//  Created by 陈思羽 on 2018-03-18.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import Foundation

class ImageCell: Cell {
    init(_ range: Range?) {
        super.init(selected: range, forCell: .image)
    }
}
