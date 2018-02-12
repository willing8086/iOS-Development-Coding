//
//  PieView.swift
//  Assign01_PieView
//
//  Created by 陈思羽 on 2018-02-09.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import UIKit
import DynamicColor

@IBDesignable
class PieView: UIView {

    var items = [PieViewItem]()
    @IBInspectable var radius: CGFloat = 0
    @IBInspectable var ringWidth: CGFloat = 0
    
//    var parts = 3
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let part1 = PieViewItem()
        part1.color = DynamicColor(hex: 0xffe590)
        part1.percentage = 1
        
        let part2 = PieViewItem()
        part2.color = DynamicColor(hex: 0xa8ee85)
        part2.percentage = 0.8
        
        let part3 = PieViewItem()
        part3.color = DynamicColor(hex: 0x90daff)
        part3.percentage = 0.3
        
        items.append(part1)
        items.append(part2)
        items.append(part3)
        
//        for _ in 0...parts {
//            items.append(PieViewItem())
//        }
        
        for item in items {
            let path = UIBezierPath()
            let centerPoint = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            let startAngle = CGFloat(-Double.pi / 2)
            let endAngle = startAngle + CGFloat(2 * Double.pi)
            let currentAngle = startAngle + (endAngle - startAngle) * CGFloat(item.percentage)
            path.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: currentAngle, clockwise: true)
            
            path.lineWidth = radius - ringWidth
            path.lineCapStyle = .square
            item.color.setStroke()
            path.stroke()
        }
        
    }
    

}
