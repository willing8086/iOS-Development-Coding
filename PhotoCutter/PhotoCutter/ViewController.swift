//
//  ViewController.swift
//  PhotoCutter
//
//  Created by 陈思羽 on 2018-02-19.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let marginX = imageView.frame.minX
        let marginY = imageView.frame.minY
        let width = CGFloat(300)
        let height = CGFloat(300)
        
        hasImage = false
        
        let upLineLayer = CAShapeLayer()
        upLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: 1)).cgPath
        upLineLayer.fillColor = UIColor.white.cgColor
        upLineLayer.frame = CGRect(x: marginX, y: marginY + height / 3, width: width, height: 1)
        self.view.layer.addSublayer(upLineLayer)

        let downLineLayer = CAShapeLayer()
        downLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: 1)).cgPath
        downLineLayer.fillColor = UIColor.white.cgColor
        downLineLayer.frame = CGRect(x: marginX, y: marginY + height * 2 / 3, width: width, height: 1)
        self.view.layer.addSublayer(downLineLayer)

        let leftLineLayer = CAShapeLayer()
        leftLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: height)).cgPath
        leftLineLayer.fillColor = UIColor.white.cgColor
        leftLineLayer.frame = CGRect(x: marginX + width / 3, y: marginY, width: 1, height: height)
        self.view.layer.addSublayer(leftLineLayer)

        let rightLineLayer = CAShapeLayer()
        rightLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: height)).cgPath
        rightLineLayer.fillColor = UIColor.white.cgColor
        rightLineLayer.frame = CGRect(x: marginX + width * 2 / 3, y: marginY, width: 1, height: height)
        self.view.layer.addSublayer(rightLineLayer)
        
    }
    
    var hasImage: Bool = false {
        didSet {
            if hasImage == false {
                saveButton.isEnabled = false
            } else {
                saveButton.isEnabled = true
            }
        }
    }

    @IBAction func importPicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func savePictures(_ sender: Any) {
        let gridLength = CGFloat(100)
        
        for i in 0..<9 {
            let x = i % 3
            let y = i / 3
            
            let render = UIGraphicsImageRenderer(bounds: CGRect(x: CGFloat(x) * gridLength,
                                                                y: CGFloat(y) * gridLength,
                                                                width: gridLength,
                                                                height: gridLength))
            let image = render.image { (context) in
                imageView.layer.render(in: context.cgContext)
            }
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
        let finishedAlert = UIAlertController(title: "保存好了", message: nil, preferredStyle: .alert)
        finishedAlert.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil))
        finishedAlert.view.tintColor = UIColor.red
        self.present(finishedAlert, animated: true, completion: nil)
        
        imageView.image = nil
        hasImage = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)
        picker.dismiss(animated: true, completion: nil)
        hasImage = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

