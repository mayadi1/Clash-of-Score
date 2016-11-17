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
    
    @IBOutlet weak var scoreButton: UIButton!
    
    var motionManager: CMMotionManager!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.1
                
        motionManager.startAccelerometerUpdates()
        
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    
        
        newUser()
        
        //Vibrate
        //self.vibrate()
        
        let refScore = FIRDatabase.database().reference().child("users").child(UIDevice.current.identifierForVendor!.uuidString).child("Score")

        refScore.observe(FIRDataEventType.value, with: { (snapshot) in
            
            if snapshot.value != nil{
                self.scoreButton.setTitle(snapshot.value as! String?, for: .normal)}
            })
        
         }
    
    func update () {
        if (motionManager.isAccelerometerActive) {
            
            //Firebase fatabase ref
            let ref = FIRDatabase.database().reference()
            
            //create my current point
            let myPoint = [motionManager.accelerometerData?.acceleration.x, motionManager.accelerometerData?.acceleration.z]
            
            //send my curretn point to firebase
            ref.child("target").setValue(myPoint)
        }
        
    }
    
    //Vibrate
    func vibrate(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

    }
    

    
    @IBAction func buckButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: false) { 
            self.motionManager.stopAccelerometerUpdates()
        }
    }
    
    //new User Setup
    func newUser(){
        
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(UIDevice.current.identifierForVendor!.uuidString).child("Score").setValue("0")
    }
    
}
//TO DO disable editing mode 
