//
//  ServerViewController.swift
//  Clash of Score
//
//  Created by Mohamed Ayadi on 11/15/16.
//  Copyright © 2016 Mohamed Ayadi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreMotion
import AudioToolbox

class ServerViewController: UIViewController {
    @IBOutlet weak var apple: UIImageView!
    @IBOutlet weak var target: UIImageView!
    var motionManager: CMMotionManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager = CMMotionManager()
        //motionManager.accelerometerUpdateInterval = 0.1
        
        motionManager.startAccelerometerUpdates()
        
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ServerViewController.update), userInfo: nil, repeats: true)
        
        
        newUser()
        
        //Vibrate
        //self.vibrate()
        
//        let refScore = FIRDatabase.database().reference().child("users").child(UIDevice.current.identifierForVendor!.uuidString).child("Score")
//        
//        refScore.observe(FIRDataEventType.value, with: { (snapshot) in
//            
//            if snapshot.value != nil{
//                self.scoreButton.setTitle(snapshot.value as! String?, for: .normal)}
//        })

        
     let ref = FIRDatabase.database().reference()
        
        ref.child("target").observe(FIRDataEventType.value, with: { (snapshot) in
            
            if snapshot.value != nil{
                print("I am the poiunt")
                
                
                let twDataArray: NSArray = snapshot.value as! NSArray
                
                
                var pointX = twDataArray[0] as! Double
                var pointY = twDataArray[1] as! Double
                
                pointX = pointX * 1000
                pointY = pointY * 1000
                let myPoint = CGPoint(x: abs(pointX), y: abs(pointY))

                self.target.center = myPoint
                
                print(pointY)
                

                }
        })

        
        
        
    }
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func randomInRange(lo: Int, hi : Int) -> Int {
        return lo + Int(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    func newApplePossition(){
        // x coordinate between MinX (left) and MaxX (right):
        let randomX = randomInRange(lo: Int(self.view.frame.minX + 5), hi: Int(self.view.frame.maxX - 5))
        // y coordinate between MinY (top) and MidY (middle):
        let randomY = randomInRange(lo: Int(self.view.frame.minY + 5), hi: Int(self.view.frame.maxY - 5))
        let randomPoint = CGPoint(x: randomX, y: randomY)
        
        //check if the point in the view
        let isPointInFrame = self.view.frame.contains(randomPoint)
        
        if isPointInFrame == true{
          
            self.apple.center = randomPoint
            print(randomPoint)
            let ref = FIRDatabase.database().reference()
            ref.child("apple").setValue([randomPoint.x, randomPoint.y])
        }else{
            newApplePossition()
        }

    }
    @IBAction func test(_ sender: AnyObject) {
        newApplePossition()
        
        
    }
    func update () {
        if (motionManager.isAccelerometerActive) {
            
            //Firebase fatabase ref
            let ref = FIRDatabase.database().reference()
            
            //create my current point
            
            if (motionManager.accelerometerData?.acceleration.x != nil && motionManager.accelerometerData?.acceleration.z != nil){
            let myPoint = [motionManager.accelerometerData?.acceleration.x, motionManager.accelerometerData?.acceleration.z]
            
            //send my curretn point to firebase
            ref.child("target").setValue(myPoint)
            }
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
