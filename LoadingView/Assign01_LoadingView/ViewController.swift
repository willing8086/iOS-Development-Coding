//
//  ViewController.swift
//  Assign01_LoadingView
//
//  Created by 陈思羽 on 2018-02-09.
//  Copyright © 2018 陈思羽. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadingView.progress = Double(slider.value)
        self.loadingView.segmentStyle = .fixLength
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slideChange(_ sender: UISlider) {
        self.loadingView.progress = Double(sender.value)
    }
    
}

