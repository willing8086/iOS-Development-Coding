//
//  ViewController.swift
//  Slais
//
//  Created by 陈思羽 on 2018-02-26.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var centerView: CenterView!
    @IBOutlet weak var functionalButtonStackView: UIStackView!
    @IBOutlet weak var saveOrCancelButtonStackView: UIStackView!
    
    var cellsInView: [Cell]?
    var selectedCell: Cell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isSelected = false
        isPickedSectionChanged =  false
        
        initBackgroundLayer()
        initGridLayer()
        initSelectLayer()
    }
    
    // MARK: init Background
    
    private let viewWidth = CGFloat(300)
    private let viewHeight = CGFloat(300)
    private let viewCellGridLength = 100
    
    func initBackgroundLayer() {
        let backgroundLayer = CALayer()
        let backgroundImage = UIImage(cgImage: #imageLiteral(resourceName: "tile-background").cgImage!, scale: #imageLiteral(resourceName: "tile-background").scale, orientation: UIImageOrientation.downMirrored)
        backgroundLayer.backgroundColor = UIColor(patternImage: backgroundImage).cgColor
        backgroundLayer.shadowColor = UIColor.lightGray.cgColor
        backgroundLayer.shadowOpacity = 1
        backgroundLayer.shadowRadius = 20
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: centerView.frame.width, height: centerView.frame.height)
        centerView.layer.addSublayer(backgroundLayer)
    }
    
    // MARK: init GridLayer
    
    func initGridLayer() {
        let upLineLayer = CAShapeLayer()
        upLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: viewWidth, height: 1)).cgPath
        upLineLayer.fillColor = UIColor.white.cgColor
        upLineLayer.frame = CGRect(x: 0, y: viewHeight / 3, width: viewWidth, height: 1)
        self.centerView.layer.addSublayer(upLineLayer)
        
        let downLineLayer = CAShapeLayer()
        downLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: viewWidth, height: 1)).cgPath
        downLineLayer.fillColor = UIColor.white.cgColor
        downLineLayer.frame = CGRect(x: 0, y: viewHeight * 2 / 3, width: viewWidth, height: 1)
        self.centerView.layer.addSublayer(downLineLayer)
        
        let leftLineLayer = CAShapeLayer()
        leftLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: viewHeight)).cgPath
        leftLineLayer.fillColor = UIColor.white.cgColor
        leftLineLayer.frame = CGRect(x: viewWidth / 3, y: 0, width: 1, height: viewHeight)
        self.centerView.layer.addSublayer(leftLineLayer)
        
        let rightLineLayer = CAShapeLayer()
        rightLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: viewHeight)).cgPath
        rightLineLayer.fillColor = UIColor.white.cgColor
        rightLineLayer.frame = CGRect(x: viewWidth * 2 / 3, y: 0, width: 1, height: viewHeight)
        self.centerView.layer.addSublayer(rightLineLayer)
    }
    
    // MARK: init SelectLayer
    
    private let focusCorner0Layer = CALayer()
    private let focusCorner10Layer = CALayer()
    private let focusCorner1Layer = CALayer()
    private let focusCorner11Layer = CALayer()
    
    func initSelectLayer() {
        let selectedRect = rangeToRect(range: selectedRange, scale: viewCellGridLength)
        
        focusCorner0Layer.contents = #imageLiteral(resourceName: "focus-corner-0").cgImage
        focusCorner0Layer.frame = CGRect(origin: CGPoint.zero, size: #imageLiteral(resourceName: "focus-corner-0").size)
        focusCorner0Layer.position = CGPoint(x: selectedRect.minX, y: selectedRect.minY)
        self.centerView.layer.addSublayer(focusCorner0Layer)
        
        focusCorner10Layer.contents = #imageLiteral(resourceName: "focus-corner-10").cgImage
        focusCorner10Layer.frame = CGRect(origin: CGPoint.zero, size: #imageLiteral(resourceName: "focus-corner-10").size)
        focusCorner10Layer.position = CGPoint(x: selectedRect.maxX, y: selectedRect.minY)
        self.centerView.layer.addSublayer(focusCorner10Layer)
  
        focusCorner1Layer.contents = #imageLiteral(resourceName: "focus-corner-1").cgImage
        focusCorner1Layer.frame = CGRect(origin: CGPoint.zero, size: #imageLiteral(resourceName: "focus-corner-1").size)
        focusCorner1Layer.position = CGPoint(x: selectedRect.minX, y: selectedRect.maxY)
        self.centerView.layer.addSublayer(focusCorner1Layer)
        
        focusCorner11Layer.contents = #imageLiteral(resourceName: "focus-corner-11").cgImage
        focusCorner11Layer.frame = CGRect(origin: CGPoint.zero, size: #imageLiteral(resourceName: "focus-corner-11").size)
        focusCorner11Layer.position = CGPoint(x: selectedRect.maxX, y: selectedRect.maxY)
        self.centerView.layer.addSublayer(focusCorner11Layer)
    }
    
    var isSelected: Bool = false {
        didSet{
            if isSelected == false {
                focusCorner0Layer.isHidden = true
                focusCorner1Layer.isHidden = true
                focusCorner10Layer.isHidden = true
                focusCorner11Layer.isHidden = true
            } else {
                focusCorner0Layer.isHidden = false
                focusCorner1Layer.isHidden = false
                focusCorner10Layer.isHidden = false
                focusCorner11Layer.isHidden = false
            }
        }
    }
    
    var isPickedSectionChanged: Bool = false {
        didSet{
            if isPickedSectionChanged == true {
                initSelectLayer()
            }
        }
    }

    // MARK: Pick section and Show focus anchors
    
    private var startPoint = CGPoint(x: 0, y: 0)
    private var endPoint = CGPoint(x: 0, y: 0)
    private var selectedRange = Range(x: 0, y: 0, width: 0, height: 0)
    
    @IBAction func pickSection(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            anchorHide()
            startPoint = sender.location(in: centerView)
            anchorPrepare(point: startPoint)
        case .changed:
            endPoint = sender.location(in: centerView)
            anchorFocus(startPoint: startPoint, endPoint: endPoint)
        case .ended:
            endPoint = sender.location(in: centerView)
            anchorFocus(startPoint: startPoint, endPoint: endPoint)
        default:
            break
        }
    }
    
    // MARK: Tap Gesture Action
    
    @IBAction func selectOrDeselectSection(_ sender: UITapGestureRecognizer) {
        let rect = centerView.frame
        let isTouchInCenterView = pointInRange(point: sender.location(in: self.view), rect: rect)
        
        if !isTouchInCenterView {
            isSelected = false
        } else {
            anchorHide()
            let point = sender.location(in: centerView)
            anchorPrepare(point: point)
            anchorFocus(startPoint: point, endPoint: point)
        }
        
    }
    
    // MARK: Prepare for anchor focusing
    
    func anchorHide() {
        CATransaction.setDisableActions(true)
        isSelected = false
    }
    
    func anchorPrepare(point: CGPoint) {
        CATransaction.setDisableActions(true)
        selectedRange = touchLocatedInRange(startPoint: point, endPoint: point)
        isPickedSectionChanged = true
    }
    
    func anchorFocus(startPoint: CGPoint, endPoint: CGPoint) {
        isSelected = true
        selectedRange = touchLocatedInRange(startPoint: startPoint, endPoint: endPoint)
        isPickedSectionChanged = true
    }
    
    @IBAction func pictureContentEdit(_ sender: UIPinchGestureRecognizer) {
        
    }
    
    func touchLocatedInRange(startPoint: CGPoint, endPoint: CGPoint) -> Range {
        let startPositionX = touchLocationToRangePosition(location: startPoint.x)
        let startPositionY = touchLocationToRangePosition(location: startPoint.y)
        let endPositionX = touchLocationToRangePosition(location: endPoint.x)
        let endPositionY = touchLocationToRangePosition(location: endPoint.y)
        
        let xInRange = comparePositions(position1: startPositionX, position2: endPositionX)
        let yInRange = comparePositions(position1: startPositionY, position2: endPositionY)
        let widthInRange = distanceBetweenPositions(position1: startPositionX, position2: endPositionX)
        let heightInRange = distanceBetweenPositions(position1: startPositionY, position2: endPositionY)
        
        return Range(x: xInRange, y: yInRange, width: widthInRange, height: heightInRange)
    }
    
    func touchLocationToRangePosition(location: CGFloat) -> Int {
        switch location {
        case 0..<(viewWidth / 3) :
            return 0
        case (viewWidth / 3)..<(2 * viewWidth / 3) :
            return 1
        case (2 * viewWidth / 3)...viewWidth :
            return 2
        default:
            return 0
        }
    }
    
    func comparePositions(position1: Int, position2: Int) -> Int {
        if position1 < position2 {
            return position1
        } else {
            return position2
        }
    }
    
    func distanceBetweenPositions(position1: Int, position2: Int) -> Int {
        var distance = 0
        if position1 < position2 {
            distance = position2 - position1 + 1
        } else {
            distance = position1 - position2 + 1
        }
        
        return distance
    }
    
    func rangeToRect(range: Range, scale: Int) -> CGRect {
        let rect = CGRect(x: range.x * scale,
                          y: range.y * scale,
                          width: range.width * scale,
                          height: range.height * scale)
        
        return rect
    }
    
    func pointInRange(point: CGPoint, rect: CGRect) -> Bool{
        if point.x >= rect.minX && point.x <= rect.maxX
            && point.y >= rect.minY && point.y <= rect.maxY {
            return true
        }
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

