//
//  ViewController.swift
//  PhotoCutter
//
//  Created by 陈思羽 on 2018-02-19.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let upLineLayer = CAShapeLayer()
        upLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 302, height: 1)).cgPath
        upLineLayer.fillColor = UIColor.white.cgColor
        upLineLayer.frame = CGRect(x: 0, y: 100, width: 302, height: 1)
        imageView.layer.addSublayer(upLineLayer)

        let downLineLayer = CAShapeLayer()
        downLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 302, height: 1)).cgPath
        downLineLayer.fillColor = UIColor.white.cgColor
        downLineLayer.frame = CGRect(x: 0, y: 200, width: 302, height: 1)
        imageView.layer.addSublayer(downLineLayer)

        let leftLineLayer = CAShapeLayer()
        leftLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 302)).cgPath
        leftLineLayer.fillColor = UIColor.white.cgColor
        leftLineLayer.frame = CGRect(x: 100, y: 0, width: 1, height: 302)
        imageView.layer.addSublayer(leftLineLayer)

        let rightLineLayer = CAShapeLayer()
        rightLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 302)).cgPath
        rightLineLayer.fillColor = UIColor.white.cgColor
        rightLineLayer.frame = CGRect(x: 200, y: 0, width: 1, height: 302)
        imageView.layer.addSublayer(rightLineLayer)
        
    }

    @IBAction func importPicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func savePictures(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

