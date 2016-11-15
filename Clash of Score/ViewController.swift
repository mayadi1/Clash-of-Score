//
//  ViewController.swift
//  Clash of Score
//
//  Created by Mohamed Ayadi on 11/15/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox
import Firebase
import FirebaseDatabase


class ViewController: UIViewController {
    
    
    lazy var motionManager: CMMotionManager = {
        let motion = CMMotionManager()
        motion.accelerometerUpdateInterval = 1.0/10.0 // means update every 1 / 10 second
        return motion
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.motionManager.startAccelerometerUpdates()
        let xForce = self.motionManager.accelerometerData?.acceleration.x

        print(xForce)
        
        
        //Vibrate
      //  self.vibrate()
    }

    //Vibrate
    func vibrate(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

    }
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func buckButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: false) { 
            
        }
    }
    
    //new User Setup
    func newUser(){
        
 
        let ref = FIRDatabase.database().reference()
        UIDevice.current.identifierForVendor!.uuidString

    }
    
}

