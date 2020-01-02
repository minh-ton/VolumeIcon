//
//  ViewController.swift
//  VolumeIcon
//
//  Created by Ford on 12/29/19.
//  Copyright © 2019 Ford Ton. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var desiredAction: NSPopUpButton!
    
    @IBOutlet weak var progressLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

