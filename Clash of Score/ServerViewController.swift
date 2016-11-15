//
//  ServerViewController.swift
//  Clash of Score
//
//  Created by Mohamed Ayadi on 11/15/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit

class ServerViewController: UIViewController {
    @IBOutlet weak var apple: UIImageView!
    @IBOutlet weak var target: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let point = CGPoint(x: 0.5, y: 0.5)
        self.target.center = point
    }
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
