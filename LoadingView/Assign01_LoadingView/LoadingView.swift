//
//  LoadingView.swift
//  Assign01_LoadingView
//
//  Created by 陈思羽 on 2018-02-09.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import UIKit
import DynamicColor

@objc
enum LoadingViewSegmentStyle: Int {
    case flexRight = 0
    case fixLength = 1
}

@IBDesignable
class LoadingView: UIView {
    
    // Questions
    // 1. CocoaPods 是不是必须在 import 之前 先 rebuild
    // 2. 为什么 segmentStyle 的属性加了 @IBInspectable 还是不可监测
    //    但是 enum 如果不加 @objc 不能被监测 还有什么处理方法
    // 3. 关于 .fixLength 的功能 如果不加动画的话要显示出什么效果

    @IBInspectable
    var segmentStyle: LoadingViewSegmentStyle = .flexRight
    
    @IBInspectable
    var progress: Double = 0.01 {
        didSet {
            if progress <= 0 {
                self.progress = 0.01
            } else if progress > 1 {
                self.progress = 1
            } else {
                self.setNeedsDisplay()
            }
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let length = self.bounds.width - 20
        let startX = 10 + self.bounds.minX

        let maxLengthRatio = 0.4
        
        let backgroundLine = UIBezierPath()
        backgroundLine.move(to: CGPoint(x: startX, y: 20))
        backgroundLine.addLine(to: CGPoint(x: length + startX, y: 20))
        backgroundLine.lineCapStyle = .round
        backgroundLine.lineWidth = 4
        let backgroundLineColor = DynamicColor(hex: 0xDCDCDC)
        backgroundLineColor.setStroke()
        backgroundLine.stroke()

        
        let activeLine = UIBezierPath()
        activeLine.lineWidth = 4
        activeLine.lineCapStyle = .round
        if segmentStyle == .flexRight {
            activeLine.move(to: CGPoint(x: startX, y: 20))
            activeLine.addLine(to: CGPoint(x: length * CGFloat(progress) + startX, y: 20))
        } else if segmentStyle == .fixLength {
            progress *= 1 + maxLengthRatio
            if progress < maxLengthRatio {
                activeLine.move(to: CGPoint(x: startX, y: 20))
                activeLine.addLine(to: CGPoint(x: length * CGFloat(progress) + startX, y: 20))
            } else if progress >= maxLengthRatio && progress < 1 {
                activeLine.move(to: CGPoint(x: startX + length * CGFloat(progress - maxLengthRatio), y: 20))
                activeLine.addLine(to: CGPoint(x: startX + length * CGFloat(progress), y: 20))
            } else if progress >= 1 {
                activeLine.move(to: CGPoint(x: startX + length * CGFloat(progress - maxLengthRatio), y: 20))
                activeLine.addLine(to: CGPoint(x: length + startX, y: 20))
            }
        }
        
        let activeLineColor = DynamicColor(hex: 0x8D8D8D)
        activeLineColor.setStroke()
        activeLine.stroke()
    }

}
